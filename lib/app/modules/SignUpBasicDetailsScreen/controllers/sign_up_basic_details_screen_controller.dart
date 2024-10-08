import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/Utils/get_storage.dart';
import 'package:power_maids/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpBasicDetailsScreenController extends GetxController {
  //TODO: Implement SignUpBasicDetailsScreenController

  final TextEditingController goalcontroller = TextEditingController();
  final TextEditingController propertycontroller = TextEditingController();
  final TextEditingController pmsController = TextEditingController();


  final count = 0.obs;
  final isLoading = false.obs;


  void navigateUser() async {
       Get.offAllNamed(Routes.EDIT_PROFILE,arguments: true);
  }

  List<bool> isSelected = [true, false].obs;

  final authToken = ''.obs;
  final name = ''.obs;
  final userId = ''.obs;


  @override
  void onInit() {
    // user_id.value = Get.parameters['user_id']!;
    authToken.value = Get.parameters['auth_token']!;
    name.value = Get.parameters['first_name']??"";
    super.onInit();
  }

  basicDetailsApi() async {
    try {
      isLoading(true);

      var response = await ApiService().signUpBasicDetails(
        authToken.value,
        isSelected[0] ? 'Cleaning Services' : 'Property Management',
        propertycontroller.text,
        pmsController.text,
      );

      if (response['status'] == true) {

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', authToken.value.toString());
        // await prefs.setString('user_id', user_id.value.toString());

        await getProfile();
        isLoading(false);

        navigateUser();
      } else if (response['status'] == false) {
        ToastClass.showToast('${response['message']}',);
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


        update();
      } else if (response['status'] == false) {

        update();
      }
    } finally {
      update();
    }
  }

  void increment() => count.value++;
}
