import 'dart:developer';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:power_maids/GoogleMap/google_map_and_places.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/modules/SignIn/controllers/sign_in_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SignUpController extends GetxController {
  //TODO: Implement SignUpController


   final TextEditingController firstNameTextController = TextEditingController();
   final TextEditingController lastNameTextController = TextEditingController();
   final TextEditingController emailTextController = TextEditingController();
   final TextEditingController phoneTextController = TextEditingController();
   final TextEditingController passwordTextController = TextEditingController();

   final TextEditingController firstnameTextController = TextEditingController();
   final TextEditingController lastnameTextController = TextEditingController();
   final TextEditingController mobileTextController = TextEditingController();
   final TextEditingController userIdTextController = TextEditingController();
   final TextEditingController nameTextController = TextEditingController();
   // final  addressController = TextEditingController().obs;

   final GoogleMapServiceController googleMapService = Get.put(GoogleMapServiceController());

   // Call the login method from LoginController
   final loginController = Get.find<SignInController>();

   final isChecked = false.obs;
   final count = 0.obs;
   final obscureTextpassword = true.obs;
   final obscureTextconfirmpassword = true.obs;
   final isLoading = false.obs;
   final deviceToken = ''.obs;
   final countryCode = ''.obs;


   void togglePasswordVisibility() {
     obscureTextpassword.toggle();
     update();
   }
   void toggleConfirmPasswordVisibility() {
     obscureTextconfirmpassword.toggle();
     update();
   }

   bool isValidEmail(String email) {
     final RegExp emailRegex = RegExp(
       r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
     );
     return emailRegex.hasMatch(email);
   }





   validation(context) {
     if (firstNameTextController.text.isEmpty) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         duration: const Duration(seconds: 1),
         dismissDirection: DismissDirection.horizontal,
         backgroundColor: AppStyles.appThemeColor,
         content: Center(child: Textwidget(text: "Please enter your first name",color: Colors.white,)),
       ));
     } else if (lastNameTextController.text.isEmpty) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         duration: const Duration(seconds: 1),
         dismissDirection: DismissDirection.horizontal,
         backgroundColor: AppStyles.appThemeColor,
         content: Center(child: Textwidget(text: "Please enter your last name",color: Colors.white,)),
       ));
     } else if (emailTextController.text.isEmpty) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         duration: const Duration(seconds: 1),
         dismissDirection: DismissDirection.horizontal,
         backgroundColor: AppStyles.appThemeColor,
         content: Center(child: Textwidget(text: "Please enter your email",color: Colors.white,)),
       ));
     }else if (!isValidEmail(emailTextController.text)) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         duration: const Duration(seconds: 1),
         dismissDirection: DismissDirection.horizontal,
         backgroundColor: AppStyles.appThemeColor,
         content: Center(child: Textwidget(text: "Please enter a valid email",color: Colors.white,)),
       ));
     } else if (phoneTextController.text.isEmpty) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         duration: const Duration(seconds: 1),
         dismissDirection: DismissDirection.horizontal,
         backgroundColor: AppStyles.appThemeColor,
         content: Center(child: Textwidget(text: "Please enter your phone number",color: Colors.white,)),
       ));
     } else if (passwordTextController.text.isEmpty) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         duration: const Duration(seconds: 1),
         dismissDirection: DismissDirection.horizontal,
         backgroundColor: AppStyles.appThemeColor,
         content: Center(child: Textwidget(text: "Please enter your password",color: Colors.white,)),
       ));
     } else if (googleMapService.addressController.value.text.isEmpty) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         duration: const Duration(seconds: 1),
         dismissDirection: DismissDirection.horizontal,
         backgroundColor: AppStyles.appThemeColor,
         content: Center(child: Textwidget(text: "Please select your address",color: Colors.white,)),
       ));
     } else if(isChecked.value != true){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         duration: const  Duration(seconds: 1),
         dismissDirection: DismissDirection.horizontal,
         backgroundColor: AppStyles.appThemeColor,
         content: Center(child: Textwidget(text: "Are you agree to the Terms & Conditions of Airnests",color: Colors.white,)),
       ));
     } else {
       signUpApi();
     }
   }

   getDeviceToken() async {
     final prefs = await SharedPreferences.getInstance();
     FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

     // Retrieve the current token from SharedPreferences
     String? currentToken = prefs.getString('device_token');

     // Listen for token refresh events
     _firebaseMessaging.onTokenRefresh.listen((newToken) async {
       // Update token only if it has changed
       if (currentToken != newToken) {
         await prefs.setString('device_token', newToken);
         deviceToken.value = newToken;
          log('Device token refreshed: -- - - -   - --  $newToken');
       }
     });

     // Get the current token
     _firebaseMessaging.getToken().then((value) async {
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

  @override
  void onInit() {
    getDeviceToken();
    super.onInit();
  }

   getProfile() async {
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

   Future<User?> signUpWithEmailAndPassword(String email, String password) async {
     try {
       UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
       return userCredential.user;
     } catch (e) {
       if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
         log('The account already exists for that email.');
         // ToastClass.showToast("The account already exists for that email.",);
         return null; // Indicate that the email is already in use
       } else {
         // ToastClass.showToast("'Error: $e",);
         log('Error: $e');
         return null;
       }
     }
   }

   addDocumentWithCustomID(token,fName,lName,pUrl) async {
     Future.delayed(const Duration(seconds: 3)).then((value) async {
       // Get a reference to the Firestore collection
       CollectionReference users = FirebaseFirestore.instance.collection('users');

       // Specify the custom ID for the document
       final User? user = auth.currentUser;
       String uid = user!.uid;
       var uFName = fName;
       var uLName = lName;
       var uEmail = user.email;
       var uPhoto = pUrl;
       var fcmToken = deviceToken.value;

       await updateFirebaseID(uid,token);

       log(" JAydeep ------firebase user id  -- $uid");
       log(" JAydeep ------firebase user fname  -- $uFName");
       log(" JAydeep ------firebase user lname  -- $uLName");
       log(" JAydeep ------firebase user email  -- $uEmail");
       log(" JAydeep ------firebase user Photo  -- $uPhoto");
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
       isLoading(false);
     }
     );

   }

   updateFirebaseID(firebaseId, authToken) async {
     try {
       isLoading(true);

       var response = await ApiService().updateFirebaseIDAPI(firebaseId.toString(),authToken);

       if (response['status'] == true) {

         final prefs = await SharedPreferences.getInstance();
         await prefs.setString('firebase_user_id', firebaseId);

         log('intro----------------$response');
       } else if (response['status'] == false) {
         isLoading(false);
       }
     } finally {
       isLoading(false);
     }
   }

   signUpApi() async {
     // var device_token = prefs.getString('device_token');

     try {
       isLoading(true);

       var response = await ApiService().signUpApi(
         "app",
         firstNameTextController.text,
         lastNameTextController.text,
         emailTextController.text,
         passwordTextController.text,
         phoneTextController.text,
         deviceToken.value,
         googleMapService.addressController.value.text,
         googleMapService.latitude.toString(),
         googleMapService.longitude.toString(),
       );

       if (response['status'] == true) {

           ToastClass.showToast('${response['message']}',);

           // Authentication with email and password

          await signUpWithEmailAndPassword(emailTextController.text,passwordTextController.text);
          await addDocumentWithCustomID(
              response['token'],
              firstNameTextController.text,
              lastNameTextController.text,
            ""
          );
           final prefs = await SharedPreferences.getInstance();
           prefs.setString('dialCode',countryCode.value);


           var data = {
             'number':phoneTextController.text,
             'otp':response['otp'].toString(),
             'first_name':firstNameTextController.text,
             'last_name':lastNameTextController.text,
             'email':emailTextController.text,
             'password':passwordTextController.text,
             'auth_token':response['token'].toString(),
             'dialCode':countryCode.value,
           };

           Get.toNamed(Routes.SIGN_UP_VERIFY_OTP,parameters: data);

         isLoading(false);


       } else if (response['status'] == false) {
         ToastClass.showToast('${response['message']}',);
         isLoading(false);
       }

     } finally {

       isLoading(false);

     }
   }

   socialSignUpApi(loginType,id,email,firstname,lastname, photoUrl) async {

     // final prefs = await SharedPreferences.getInstance();
     // var devicetype = prefs.getString('device_type');
     // var device_token = prefs.getString('device_token');
     log("device_token =====jay==== ${deviceToken.value}");
     try {
       isLoading(true);

       var response = await ApiService().googleSignUp(
         loginType,
         id,
         deviceToken.value, // Device_id/fcm token
         email,
         firstname,
         lastname,
       );

       if (response['status'] == true) {

         final prefs = await SharedPreferences.getInstance();
         await prefs.setString('auth_token', response['token']);

         if(response['first_login'] == "0"){
           await addDocumentWithCustomID(response['token'].toString(),firstname,lastname,photoUrl);
         }else{
           log("user Already registered");
         }

         getProfile();
         if(loginType == 'google'){
           ToastClass.showToast("Welcome! Google login was successful.");
         }else if(loginType == 'facebook'){
           ToastClass.showToast("Welcome! Facebook login was successful.");
         }else{
           ToastClass.showToast("Welcome! Apple login was successful.");
         }

         Get.toNamed(Routes.DESHBOARD);


       } else if (response['status'] == false) {
         ToastClass.showToast('${response['message']}',);
         await GoogleSignIn().disconnect();
         FirebaseAuth.instance.signOut();
         isLoading(false);
       }

     } finally {

       isLoading(false);

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

     log('first name --  $fname');
     log('last name  ---  $lname');


     // Create a new credential
     final credential = GoogleAuthProvider.credential(
       accessToken: googleAuth?.accessToken,
       idToken: googleAuth?.idToken,
     );
     socialSignUpApi("google",googleUser.id,googleUser.email,fname,lname,googleUser.photoUrl);

     // UserCredential firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;

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


         socialSignUpApi("facebook",uid,email,fname,lname,'');


         /*  {name: Harry Archie, email: mailto:framesport23@gmail.com, picture: {data: {height: 180, is_silhouette: true, url:
            https://scontent.fbho2-1.fna.fbcdn.net/v/t1.30497-1/84628273_176159830277856_972693363922829312_n.jpg?stp=dst-jpg_s200x200&_nc_cat=1&ccb=1-7&_nc_sid=12b3be&_nc_ohc=VJTzx8w9FSQAX9Y0f6o&_nc
            _ht=scontent.fbho2-1.fna&edm=AP4hL3IEAAAA&oh=00_AfB-FJkEC1F5G3LUygoorOjlF5JSOhHDFfh_-_z-iLy2Nw&oe=64C4A0D9, width: 180}}, id: 174530345601675}
            */
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
       socialSignUpApi( "apple",
           credential.userIdentifier,
           userCredential.user!.email,
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
    firstNameTextController.clear();
    lastNameTextController.clear();
    emailTextController.clear();
    phoneTextController.clear();
    passwordTextController.clear();
    googleMapService.addressController.value.clear();
  }

  void increment() => count.value++;
}


