import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChangePasswordController extends GetxController {
  //TODO: Implement ChangePasswordController

  final TextEditingController emailController = TextEditingController();


  final count = 0.obs;
  final oldPasswordObscureText = true.obs;
  final newPasswordObscureText = true.obs;
  final confirmPasswordObscureText = true.obs;
  final isLoading = false.obs;

  void oldPasswordVisibility() {
    oldPasswordObscureText.toggle();
    update();
  }
  void newPasswordVisibility() {
    newPasswordObscureText.toggle();
    update();
  }
  void confirmPasswordVisibility() {
    confirmPasswordObscureText.toggle();
    update();
  }
  @override
  void onInit() {
    super.onInit();
  }


  void onSubmit (){
    if(emailController.text.isEmpty ){
      ToastClass.showToast('Enter email address',);

    }else{
      verifyMobileApi();
    }
  }




  verifyMobileApi() async {
    try {
      isLoading(true);

      var response = await ApiService().forgotPasswordApi(emailController.text);

      if (response['status'] == true) {

        ToastClass.showToast('${response['message']}',);
        log("OTP -- ${response['data']['otp'].toString()}");

        var data = {
          'email':emailController.text,
          // 'otp':response['data']['otp'].toString()
        };
        Get.toNamed(Routes.VERIFY_CHANGE_PASSWORD,parameters: data);

        isLoading(false);

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

  void increment() => count.value++;
}
