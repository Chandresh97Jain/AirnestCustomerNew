import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/routes/app_pages.dart';


class ForgotPasswordController extends GetxController {
  //TODO: Implement ForgotPasswordController
  final TextEditingController mobileTextController = TextEditingController();

  final count = 0.obs;
  final isLoading = false.obs;

  validation(context) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp =   RegExp(patttern);

    if (mobileTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration:  const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please enter your registered mobile number",color: Colors.white,)),
      ));
    }else if(mobileTextController.text.length < 10){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please enter ten digit of mobile number",color: Colors.white,)),
      ));
    } else {
      forgotPassApi();
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  forgotPassApi() async {
    try {
      isLoading(true);

      var response = await ApiService().forgotPasswordApi(mobileTextController.text);

      if (response['status'] == true) {

        ToastClass.showToast('${response['message']}',);
        log("OTP -- ${response['data']['otp'].toString()}");

        var data = {
          'number':response['data']['mobile'].toString(),
          'otp':response['data']['otp'].toString()
        };
        Get.toNamed(Routes.VERICATION_OTP,parameters: data);
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
