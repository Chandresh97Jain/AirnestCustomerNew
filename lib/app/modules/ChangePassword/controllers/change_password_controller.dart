import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/routes/app_pages.dart';


class ChangePasswordController extends GetxController {
  //TODO: Implement ChangePasswordController

  final TextEditingController mobileController = TextEditingController();


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
    if(mobileController.text.isEmpty ){
      ToastClass.showToast('Enter mobile number',);

    }else{
      verifyMobileApi();
    }
  }




  verifyMobileApi() async {
    try {
      isLoading(true);

      var response = await ApiService().forgotPasswordApi(mobileController.text);

      if (response['status'] == true) {

        ToastClass.showToast('${response['message']}',);
        log("OTP -- ${response['data']['otp'].toString()}");

        var data = {
          'number':response['data']['mobile'].toString(),
          'otp':response['data']['otp'].toString()
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
