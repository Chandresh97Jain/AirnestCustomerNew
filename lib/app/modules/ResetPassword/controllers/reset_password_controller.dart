import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/routes/app_pages.dart';


class ResetPasswordController extends GetxController {
  //TODO: Implement ResetPasswordController
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController = TextEditingController();


  final count = 0.obs;
  final obscureTextpassword = true.obs;
  final obscureTextconfirmpassword = true.obs;

  void togglePasswordVisibility() {
    obscureTextpassword.toggle();
    update();
  }
  void toggleConfirmPasswordVisibility() {
    obscureTextconfirmpassword.toggle();
    update();
  }

  final mobile = ''.obs;
  final userId = ''.obs;
  final isLoading = false.obs;


  @override
  void onInit() {
    userId.value = Get.parameters['user_id']!;
    super.onInit();
  }

  resetPassApi() async {
    try {
      isLoading(true);

      var response = await ApiService().resetPass(userId.value,passwordTextController.text,confirmPasswordTextController.text);

      if (response['status'] == true) {

        ToastClass.showToast('${response['message']}',);
        log("OTP -- ${response['data']['otp'].toString()}");

        isLoading(false);
        Get.offAllNamed(Routes.SIGN_IN);

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
