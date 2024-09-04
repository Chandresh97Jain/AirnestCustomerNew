import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/routes/app_pages.dart';


class VerifyChangePasswordController extends GetxController {
  //TODO: Implement VerifyChangePasswordController

  final count = 0.obs;
  final otpController = TextEditingController().obs;
  final otp = "".obs;
  final mobile = "".obs;
  final isLoading = false.obs;
  final isLoadingg = false.obs;


  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.black),
    ),
  );

  late Timer timer;
  final start = 30.obs;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (start.value == 0) {
          timer.cancel();
          isLoadingg(false);
        } else {
          start.value--;
        }
      },
    );
  }

  @override
  void onInit() {
    otpController.value.text = Get.parameters['otp']!;
    mobile.value = Get.parameters['number']!;

    startTimer();

    super.onInit();
  }

  verifyOtpApi() async {
    try {
      isLoading(true);

      var response = await ApiService().otpVerify(mobile.value,otpController.value.text);

      if (response['status'] == true) {

        ToastClass.showToast('${response['message']}',);

        var data = {
          'number':response['data']['mobile'].toString(),
          'user_id':response['data']['id'].toString(),
        };

        // Get.toNamed(Routes.RESET_PASSWORD,parameters: data);
        Get.offNamed(Routes.RESET_CHANGE_PASSWORD,parameters: data);

        isLoading(false);


      } else if (response['status'] == false) {
        ToastClass.showToast('${response['message']}',);
        isLoading(false);
      }

    } finally {

      isLoading(false);

    }
  }

  resendApi() async {
    try {
      isLoading(true);

      var response = await ApiService().forgotPasswordApi(mobile.value);

      if (response['status'] == true) {

        ToastClass.showToast('${response['message']}',);
        log("OTP -- ${response['data']['otp'].toString()}");

        otpController.value.text = response['data']['otp'].toString();
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
