import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:power_maids/GoogleMap/google_map_and_places.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/Utils/get_storage.dart';
import 'package:power_maids/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileController extends GetxController {
  final firstnameController = TextEditingController().obs;
  final numberController = TextEditingController().obs;
  final lastnameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;

  final GoogleMapServiceController googleMapService =
      Get.put(GoogleMapServiceController());

  //TODO: Implement EditProfileController
  RxString profileNetwork = ''.obs;
  RxString memberSince = ''.obs;
  var selectedImage = File("").obs;
  final getProfilePicture = ''.obs;
  final ImagePicker picker = ImagePicker();

  final count = 0.obs;
  final dialCode = ''.obs;
  final firebase_id = ''.obs;
  final lat = ''.obs;
  final lng = ''.obs;
  final isLoading = false.obs;
  final dashBtn = false.obs;
  final isLoadingAccountDelete = false.obs;

  final selectedLanguage = "".obs;

  void selectLanguage(String language) {
    selectedLanguage.value = language;
  }

  Future<void> pickImageFromGallery(context) async {
    XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      // maxWidth: 1800,
      // maxHeight: 1800,
    );
    // final croppedFile = await ImageCropper().cropImage(
    //   sourcePath: pickedFile!.path,
    //   compressFormat: ImageCompressFormat.jpg,
    //   compressQuality: 100,
    //   uiSettings: [
    //     AndroidUiSettings(
    //         toolbarTitle: 'Cropper',
    //         activeControlsWidgetColor: AppStyles.appThemeColor,
    //         cropFrameColor: AppStyles.appThemeColor,
    //         cropGridColor: AppStyles.appThemeColor,
    //         // dimmedLayerColor: HexColor("#0D86BF"),
    //         statusBarColor: AppStyles.appThemeColor,
    //         toolbarColor: AppStyles.appThemeColor,
    //         toolbarWidgetColor: AppStyles.backgroundColor,
    //         initAspectRatio: CropAspectRatioPreset.original,
    //         lockAspectRatio: false),
    //     IOSUiSettings(
    //       title: 'Cropper',
    //     ),
    //     WebUiSettings(
    //       context: context,
    //       presentStyle: CropperPresentStyle.dialog,
    //       boundary: const CroppieBoundary(
    //         width: 520,
    //         height: 520,
    //       ),
    //       viewPort: CroppieViewPort(width: 480, height: 480, type: 'circle'),
    //       enableExif: true,
    //       enableZoom: true,
    //       showZoomer: true,
    //     ),
    //   ],
    // );
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      profileNetwork.value = selectedImage.value.path;

      log("profileNetwork.value =======>?>>>>>>>>>>> ${profileNetwork.value.toString()}");
      log("selectedImage.value =======>?>>>>>>>>>>> ${selectedImage.value.toString()}");
    }
  }

  Future<void> pickImageFromCamera(context) async {
    XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      // maxWidth: 1800,
      // maxHeight: 1800,
    );
    // final croppedFilee = await ImageCropper().cropImage(
    //   sourcePath: pickedFile!.path,
    //   compressFormat: ImageCompressFormat.jpg,
    //   compressQuality: 100,
    //   uiSettings: [
    //     AndroidUiSettings(
    //         toolbarTitle: 'Cropper',
    //         activeControlsWidgetColor: AppStyles.appThemeColor,
    //         cropFrameColor: AppStyles.appThemeColor,
    //         cropGridColor: AppStyles.appThemeColor,
    //         // dimmedLayerColor: HexColor("#0D86BF"),
    //         statusBarColor: AppStyles.appThemeColor,
    //         toolbarColor: AppStyles.appThemeColor,
    //         toolbarWidgetColor: AppStyles.backgroundColor,
    //         initAspectRatio: CropAspectRatioPreset.original,
    //         lockAspectRatio: false),
    //     IOSUiSettings(
    //       title: 'Cropper',
    //     ),
    //     WebUiSettings(
    //       context: context,
    //       presentStyle: CropperPresentStyle.dialog,
    //       boundary: const CroppieBoundary(
    //         width: 520,
    //         height: 520,
    //       ),
    //       viewPort: CroppieViewPort(width: 480, height: 480, type: 'circle'),
    //       enableExif: true,
    //       enableZoom: true,
    //       showZoomer: true,
    //     ),
    //   ],
    // );
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      profileNetwork.value = selectedImage.value.path;

      log("profileNetwork.value =======>?>>>>>>>>>>> ${profileNetwork.value.toString()}");
      log("selectedImage.value =======>?>>>>>>>>>>> ${selectedImage.value.toString()}");
    }
  }

  logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.offAllNamed(Routes.SIGN_IN);
  }

  Future accountDelete(context) async {
    try {

      isLoadingAccountDelete(true);

      var response = await ApiService().removeAccountApi();

      if (response['status'] == true) {
        logout();

        Get.offAllNamed(Routes.SIGN_UP);
        Navigator.pop(context);

        update();
        isLoadingAccountDelete(false);
      } else if (response['status'] == false) {
        isLoadingAccountDelete(false);
        update();
      }
    } finally {
      isLoadingAccountDelete(false);
      update();
    }
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
        prefs.setString('firebase_user_id', response['data']['firebase_id']);
        prefs.setString('user_id', response['data']['id'].toString());
        prefs.setString('address', response['data']['address'].toString());
        prefs.setString('lat', response['data']['latitude'].toString());
        prefs.setString('lng', response['data']['longitude'].toString());

        // get storage
        userData.write('user_id',response['data']['id']);
        userData.write('firstname',response['data']['firstname']);
        userData.write('lastname',response['data']['lastname']);
        userData.write('email',response['data']['email']);
        userData.write('mobile',response['data']['mobile']);
        userData.write('address',response['data']['address']);
        userData.write('your_introduction',response['data']['your_introduction']);
        userData.write('experience',response['data']['experience']);
        userData.write('zipcode',response['data']['zipcode']);
        userData.write('business_name',response['data']['business_name']);
        userData.write('website',response['data']['website']);
        userData.write('image',response['data']['image']);
        userData.write('role',response['data']['role']);

        String  image = response['data']['image'] ?? "";
        String  uid = response['data']['firebase_id']??"";
        Map<String, dynamic> fieldsToUpdate = {
          'profile': image,
        };
        FirebaseFirestore.instance.collection('users').doc(uid).update(fieldsToUpdate);

        update();

      } else if (response['status'] == false) {

        update();

      }
    } finally {
      update();
    }
  }

  @override
  void onInit() {
    dashBtn.value = Get.arguments??false;

    // googleMapService.focusNode.value = FocusNode();
    retriveData();
    super.onInit();
  }

  void retriveData() async {
    final prefs = await SharedPreferences.getInstance();

    firstnameController.value.text = prefs.getString('firstname')!;
    lastnameController.value.text = prefs.getString('lastname')!;
    emailController.value.text = prefs.getString('email')!;
    numberController.value.text = prefs.getString('mobile')!;
    profileNetwork.value = prefs.getString('image')!;
    memberSince.value = prefs.getString('member_since')!;
    googleMapService.addressController.value.text = prefs.getString('address')!;
    googleMapService.latitude.value = prefs.getString('lat')!;
    googleMapService.longitude.value = prefs.getString('lng')!;
    memberSince.value = prefs.getString('member_since')!;
    dialCode.value = prefs.getString('dialCode')!;
    firebase_id.value = prefs.getString('firebase_user_id')!;
    lat.value = prefs.getString('lat')!;
    lng.value = prefs.getString('lng')!;

    log("firebase_id -- ${firebase_id.value}");

    // numberController.text =  mobile;
  }



  void updateFields(Map<String, dynamic> fieldsToUpdate) {
    // User? user = FirebaseAuth.instance.currentUser;

    String uid = firebase_id.value;

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update(fieldsToUpdate)
        .then((_) {
      log("Fields updated successfully.... ");
    }).catchError((error) {
      log("Failed to update fields: $error");
    });

    // if (user != null) {
    //
    // } else {
    //   log("No user is currently signed in.");
    //   // Handle the scenario when there is no signed-in user.
    // }
  }


  updateProfileApi(context) async {
    try {
      isLoading(true);
      var response = await ApiService().updateProfileApi(
        firstnameController.value.text,
        lastnameController.value.text,
        numberController.value.text,
        selectedImage.value.path,
        googleMapService.addressController.value.text,
        googleMapService.latitude.toString() ?? lat.value,
        googleMapService.longitude.toString() ?? lng.value,
      );

      if (response['status'] == true) {
        final prefs = await SharedPreferences.getInstance();

        log("Edit profile -------- $response");

        prefs.setString('image', profileNetwork.value);
        prefs.setString('firstname', firstnameController.value.text);
        prefs.setString('lastname', lastnameController.value.text);
        prefs.setString('mobile', numberController.value.text);
        prefs.setString('address', googleMapService.addressController.value.text);
        prefs.setString('lat', googleMapService.latitude.value.toString());
        prefs.setString('lng', googleMapService.longitude.value.toString());
        prefs.setString('dialCode', dialCode.value);

        Map<String, dynamic> fieldsToUpdate = {
          'first_name': firstnameController.value.text,
          'last_name': lastnameController.value.text,
          // 'profile': profileNetwork.value.toString(),
          'profile': profileNetwork.value.toString(),
        };

        log("Edit profile -------- ${profileNetwork.value}");
        getProfile();
        retriveData();

        updateFields(fieldsToUpdate);

        // userData.erase();

        //
        // userData.remove('firstname');
        // userData.remove('lastname');
        // userData.remove('mobile');
        // userData.remove('image');
        //
        // print("firstname --- ${firstnameController.text}");
        // print("lastname --- ${lastnameController.text}");
        // print("mobile --- ${numberController.text}");
        // print("image --- ${selectedImage.value.path}");
        //
        //
        //   userData.write('firstname',firstnameController.text);
        //   userData.write('lastname',lastnameController.text);
        //   userData.write('mobile',numberController.text);
        //   userData.write('image',selectedImage.value.path);
        //

        update();

        ToastClass.showToast(
          '${response['message']}',
        );

        if(dashBtn.value==true){

            Get.offAllNamed(Routes.MAKE_ACCOUNT_WITH_SCREEN,arguments: true);


        }else{

          Navigator.pop(context);

        }

        // Get.offAllNamed(Routes.DESHBOARD);

        isLoading(false);
      } else if (response['status'] == false) {
        ToastClass.showToast(
          '${response['message']}',
        );
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    // googleMapService.focusNode.value.dispose();
    super.dispose();
  }

  void increment() => count.value++;
}
