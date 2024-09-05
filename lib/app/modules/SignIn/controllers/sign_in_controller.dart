import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/get_storage.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/sd_constand.dart';
import 'package:power_maids/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';


class SignInController extends GetxController {
  //TODO: Implement SignInController

  final  TextEditingController  emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  final TextEditingController firstnameTextController = TextEditingController();
  final TextEditingController lastnameTextController = TextEditingController();
  final TextEditingController mobileTextController = TextEditingController();
  final TextEditingController userIdTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();

  final count = 0.obs;
  final isChecked = false.obs;
  final obscureText = true.obs;
  final isLoading = false.obs;
  final deviceToken = ''.obs;

  final emailHinttext = "Email".obs;

  void togglePasswordVisibility() {
    obscureText.toggle();
    update();
  }
  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }


  validation(context) {
    if (emailTextController.value.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please enter your email",color: Colors.white,)),
      ));
    } else if (!isValidEmail(emailTextController.value.text)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please enter a valid email",color: Colors.white,)),
      ));
    } else if (passwordTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please enter your password",color: Colors.white,)),
      ));
    } else {
      signInApi();
    }
  }

  getDeviceToken() async {
    final prefs = await SharedPreferences.getInstance();
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    // Retrieve the current token from SharedPreferences
    String? currentToken = prefs.getString('device_token');

    // Listen for token refresh events
    firebaseMessaging.onTokenRefresh.listen((newToken) async {
      // Update token only if it has changed
      if (currentToken != newToken) {
        await prefs.setString('device_token', newToken);
        deviceToken.value = newToken;
        log('Device token refreshed: -- - - -   - --  $newToken');
      }
    });

    // Get the current token
    firebaseMessaging.getToken().then((value) async {
      // Save token only if it doesn't exist or has changed
      if (currentToken == null || currentToken != value) {
        await prefs.setString('device_token', value!);
        deviceToken.value = value;
        log('Device token on login: $value');
      }else{
        deviceToken.value = currentToken;
      }
    });
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> updateToken() async {
    try {
      // Delete FCM token
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('device_token');
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

      // Perform any additional cleanup if necessary, e.g., deleting user data from Firestore
      String uid = auth.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'fcmToken': token,
      });
      log('token updated --- : $token');

    } catch (e) {
      log('Error signing out: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadRememberedCredentials();
    getDeviceToken();

  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {

    try {

      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      log('Error: $e');
      return null;
    }
  }

  // Store user in firebase database
  addDocumentWithCustomID(token,fname,lname,pUrl) async {
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      // Get a reference to the Firestore collection
      final prefs = await SharedPreferences.getInstance();
      CollectionReference users = FirebaseFirestore.instance.collection('users');

      // Specify the custom ID for the document
      final User? user = auth.currentUser;
      var uid = user!.uid;
      var uFName = fname;
      var uLName = lname;
      var uEmail = user.email;
      var uPhoto = pUrl;
      var fcmToken = deviceToken.value; // FCM Token

      // await updateToken();
      await updateFirebaseID(uid,token);

      log("  ----------------------------firebase user id  -- $uid");
      log("  ----------------------------firebase user fname  -- $uFName");
      log("  ----------------------------firebase user Lname  -- $uLName");
      log("  ----------------------------firebase user email  -- $uEmail");
      log("  ----------------------------firebase user photo  -- $uPhoto");
      // Get a reference to the document with the custom ID
      DocumentReference documentRef = users.doc(uid);

      // Create a Map containing the data to be added to the document
      Map<String, dynamic> data = {
        'first_name': uFName??"",
        'last_name': uLName??"",
        'id': uid,
        'email': uEmail,
        'profile': uPhoto??"",
        'fcmToken': fcmToken??"",
        'isOnline': ""??"",
      };

      // Add the document with the custom ID to Firestore
      documentRef.set(data).then((_) {
        log('Document with custom ID added successfully: $uid');
      })
          .catchError((error) {
        log('Error adding document with custom ID: $error');
      });
    });

  }

  updateFirebaseID(firebaseId, authToken) async {
    try {
      isLoading(true);

      var response = await ApiService().updateFirebaseIDAPI(firebaseId.toString(),authToken);

      if (response['status'] == true) {

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('firebase_user_id', firebaseId);

      } else if (response['status'] == false) {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }


  signInApi() async {
    try {
      isLoading(true);

      var response = await ApiService().signInApi(
        "app",
        emailTextController.value.text, deviceToken.value, // Device_id/fcm token
        passwordTextController.text,
      );

      if (response['status'] == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', response['token']);


        if (isChecked.isTrue) {
          await saveRememberedCredentials();
        } else {
          await clearRememberedCredentials();
        }

          await getProfile(deviceToken.value);

          isLoading(false);
          ToastClass.showToast("Login Successfully!");
          Get.offAllNamed(Routes.DESHBOARD);

      } else if (response['status'] == false) {
        ToastClass.showToast('${response['message']}');
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }


  socialSignInApi(apptype,id,email,firstname,lastname,pUrl) async {

    log("device_token =====jay==== ${deviceToken.value}");
    try {
      isLoading(true);

      var response = await ApiService().googleSignIn(
        apptype,
       id,
        deviceToken.value, // Device_id/fcm token
        email,
          firstname,
          lastname,
      );

      if (response['status'] == true) {

        await getProfile(deviceToken.value);
        // ToastClass.showToast('${response['message']}',);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', response['token']);

        if(response['first_login'] == "0"){
          await addDocumentWithCustomID(response['token'],firstname,lastname,pUrl);
          log("new social user");
        }else{
          log("user Already registered");
        }

        if(apptype == 'google'){
          ToastClass.showToast("Success! You've logged in with Google");
        }else if(apptype == 'facebook'){
          ToastClass.showToast("Success! You've logged in with Facebook");
        }else{
          ToastClass.showToast("Success! You've logged in with Apple");
        }


        Get.offAllNamed(Routes.DESHBOARD);


      } else if (response['status'] == false) {
        ToastClass.showToast('${response['message']}',);
        await GoogleSignIn().disconnect();
        FirebaseAuth.instance.signOut();
        isLoading(false);
      }

    } finally {

      // isLoading(false);

    }
  }

  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    log('Signed in displayName ${googleUser!.displayName}');
    log('Signed in id ${googleUser.id}');
    log('Signed in email ${googleUser.email}');

    var fname = googleUser.displayName!.split(" ").first;
    var lname = googleUser.displayName!.split(" ").last;


    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    socialSignInApi("google",googleUser.id,googleUser.email,fname,lname,googleUser.photoUrl);

    log("googleAuth?.accessToken -- - - - ${googleAuth?.accessToken}");

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void signInWithFacebook() async {
    var name = "", email = "", uid = "";
    FacebookAuth.instance.logOut();
    FacebookAuth.instance.login(permissions: ["public_profile", "email"]).then((value) {
      FacebookAuth.instance.getUserData().then((userData) {
        userData.forEach((key, value) {
          if ("name" == key) {
            name = value;
          }
          if ("email" == key) {
            email = value;
          }
          if ("id" == key) {
            uid = value;
          }
        });
        // CommonClass.showLoaderDialog(Get.context!);

        log("EMAIL12321 ::     $name");
        log("EMAIL12321 ::     $email");
        log("EMAIL12321 ::     $uid");

        var fname = name.split(" ").first;
        var lname = name.split(" ").last;

        socialSignInApi("facebook",uid,email,fname,lname,'');

      });
    });
  }

  void onAppleLogin() async {
    try {
      // Request credentials from Apple
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Extract the email and full name from the credential
      final String email = credential.email ?? '';  // Email may be null
      final String firstName = credential.givenName ?? '';  // First name may be null
      final String lastName = credential.familyName ?? ''; // Last name may be null

      print("User ID ::--- ${credential.userIdentifier}");
      // print("Email ::---  ${credential.email}");
      print("Full Name ::--- ${credential.givenName} ${credential.familyName}");


      // Create OAuthCredential for Firebase Authentication
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        rawNonce: generateNonce(),  // You may want to generate a nonce here
      );

      // Sign in with Firebase using the credential
      final userCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      // Print the user credential
      print("User Credential: -----  ${userCredential.user!.email}");

      // Call your API with the retrieved user information
      socialSignInApi( "apple",
          credential.userIdentifier,
          userCredential.user!.email??"",
          firstName ??"",
          lastName??"",
          ""
      );
    } catch (e) {
      // Handle any errors that occur during the process
      print("Exception during Apple Sign-In: $e");
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    emailTextController.clear();
    passwordTextController.clear();
    firstnameTextController.clear();
    lastnameTextController.clear();
    mobileTextController.clear();
    userIdTextController.clear();
    nameTextController.clear();
  }

  getProfile(deviceToken) async {
    try {
      var response = await ApiService().getProfileApi();

      if (response['status'] == true) {

        final prefs = await SharedPreferences.getInstance();

        prefs.setString('firstname', response['data']['firstname']);
        prefs.setString('lastname', response['data']['lastname']);
        prefs.setString('email', response['data']['email']);
        prefs.setString('mobile', response['data']['mobile']);
        prefs.setString('image', response['data']['image']);
        prefs.setString('member_since', response['data']['member_since']);
        prefs.setString('firebase_user_id', response['data']['firebase_id']??"");
        prefs.setString('user_id', response['data']['id'].toString());
        prefs.setString('address', response['data']['address'].toString());
        prefs.setString('lat', response['data']['latitude'].toString());
        prefs.setString('lng', response['data']['longitude'].toString());

        var firebaseID = response['data']['firebase_id'];

        String uid = firebaseID;
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'fcmToken': deviceToken,
        });
        log('token updated in firebase--- : $deviceToken');


        // // get storage
        // userData.write('user_id',response['data']['id']);
        // userData.write('firstname',response['data']['firstname']);
        // userData.write('lastname',response['data']['lastname']);
        // userData.write('email',response['data']['email']);
        // userData.write('mobile',response['data']['mobile']);
        // userData.write('address',response['data']['address']);
        // userData.write('your_introduction',response['data']['your_introduction']);
        // userData.write('experience',response['data']['experience']);
        // userData.write('zipcode',response['data']['zipcode']);
        // userData.write('business_name',response['data']['business_name']);
        // userData.write('website',response['data']['website']);
        // userData.write('image',response['data']['image']);
        // userData.write('role',response['data']['role']);
        // // userData.write('address',response['data']['address']);
        // // userData.write('lat',response['data']['latitude']);
        // // userData.write('lng',response['data']['longitude']);
        //

        update();
      } else if (response['status'] == false) {

        update();
      }
    } finally {
      update();
    }
  }

  void increment() => count.value++;

  void toggleRememberMe(bool value) {
    isChecked.value = value;
    if (value) {
      saveRememberedCredentials();
    } else {
      clearRememberedCredentials();
    }
  }

  Future<void> saveRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SDConstant.rememberedEmail, emailTextController.text);
    await prefs.setString(SDConstant.rememberedPassword, passwordTextController.text);
  }

  Future<void> loadRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString(SDConstant.rememberedEmail);
    String? password = prefs.getString(SDConstant.rememberedPassword);


    // emailTextController.text = email.toString();
    // passwordTextController.text = password.toString();




    if (email != null && password != null) {

      emailTextController.text = email.toString();
      passwordTextController.text = password.toString();
      isChecked.value = true;



    }
  }

  Future<void> clearRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SDConstant.rememberedEmail);
    await prefs.remove(SDConstant.rememberedPassword);
  }

}

class SecureStorage {
  static final _storage = FlutterSecureStorage();

  static Future<void> saveUserInfo(String token, String userIdentifier, String? email, String? fname, String? lname) async {
    await _storage.write(key: 'userToken', value: token);
    await _storage.write(key: 'userIdentifier', value: userIdentifier);
    if (email != null) await _storage.write(key: 'email', value: email);
    if (fname != null) await _storage.write(key: 'fname', value: fname);
    if (lname != null) await _storage.write(key: 'lname', value: lname);
  }

  static Future<Map<String, String?>> getUserInfo() async {
    return {
      'userToken': await _storage.read(key: 'userToken'),
      'userIdentifier': await _storage.read(key: 'userIdentifier'),
      'email': await _storage.read(key: 'email'),
      'fname': await _storage.read(key: 'fname'),
      'lname': await _storage.read(key: 'lname'),
    };
  }

  static Future<void> deleteUserInfo() async {
    await _storage.deleteAll();
  }
}