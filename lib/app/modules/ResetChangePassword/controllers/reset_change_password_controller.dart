import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/routes/app_pages.dart';


class ResetChangePasswordController extends GetxController {
  //TODO: Implement ResetChangePasswordController
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController oldPasswordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController = TextEditingController();


  final count = 0.obs;
  final obscureTextPassword = true.obs;
  final obscureTextOldPassword = true.obs;
  final obscureTextConfirmPassword = true.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    obscureTextPassword.toggle();
    update();
  }

  void toggleOldPasswordVisibility() {
    obscureTextOldPassword.toggle();
    update();
  }
  void toggleConfirmPasswordVisibility() {
    obscureTextConfirmPassword.toggle();
    update();
  }

   @override
  void onInit() {
    super.onInit();
  }

  resetPasswordApi() async {
    try {
      isLoading(true);

      var response = await ApiService()
          .updatePassword(oldPasswordTextController.text,passwordTextController.text,confirmPasswordTextController.text);

      if (response['status'] == true) {

        ToastClass.showToast('${response['message']}',);


        Get.offAllNamed(Routes.DESHBOARD);


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
