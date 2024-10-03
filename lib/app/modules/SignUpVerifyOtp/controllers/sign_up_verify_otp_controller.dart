import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pinput/pinput.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/SignUp/controllers/sign_up_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';

class SignUpVerifyOtpController extends GetxController {
  //TODO: Implement SignUpVerifyOtpController

  final signUpController = Get.find<SignUpController>();

  final count = 0.obs;
  final otpController = TextEditingController().obs;
  final firstName = "".obs;
  final lastName = "".obs;
  final email = "".obs;
  final mobile = "".obs;
  final password = "".obs;
  final address = "".obs;
  final dialCode = "1".obs;
  final otp = "".obs;

  final lat = "".obs;
  final long = "".obs;
  final deviceToken = "".obs;
  final loginType = "".obs;

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
    otp.value = Get.parameters['otp']!;
    mobile.value = Get.parameters['number']!;
    firstName.value = Get.parameters['first_name']!;
    lastName.value = Get.parameters['last_name']!;
    email.value = Get.parameters['email']!;
    password.value = Get.parameters['password']!;
    address.value = Get.parameters['address']!;
    dialCode.value = Get.parameters['dialCode']!;
    deviceToken.value = Get.parameters['deviceToken']!;
    lat.value = Get.parameters['lat']!;
    long.value = Get.parameters['long']!;
    loginType.value = Get.parameters['loginType']!;

    print("dialCode ----${dialCode}");
    print("deviceToken ----${deviceToken}");
    print("lat ----${lat}");
    print("long ----${long}");
    print("address ----${address}");

    if (dialCode.isEmpty) {
      dialCode.value = "1";
    }

    startTimer();
    super.onInit();
  }

  verifyOtpApi() async {
    try {
      isLoading(true);

      var response = await ApiService().signUpApi(
        loginType.value,
        firstName.value,
        lastName.value,
        email.value,
        password.value,
        mobile.value,
        deviceToken.value,
        address.value,
        lat.value,
        long.value,
      );

      if (response['status'] == true) {
        log("AUTH_TOKEN ----------------> ${response['token']}");

        await signUpController.signUpWithEmailAndPassword(
            signUpController.emailTextController.text,
            signUpController.passwordTextController.text);
        await signUpController.addDocumentWithCustomID(
            response['token'],
            signUpController.firstNameTextController.text,
            signUpController.lastNameTextController.text,
            "");

        ToastClass.showToast(
          '${response['message']}',
        );

        var data = {
          'first_name': firstName.value ?? "",
          'auth_token': response['token'].toString() ?? '',
        };
        Get.toNamed(Routes.SIGN_UP_BASIC_DETAILS_SCREEN, parameters: data);

        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString('auth_token', auth_token.value);
        // await prefs.setString('user_id', response['data']['id'].toString());

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

  resendApi() async {
    try {
      isLoading(true);

      var response = await ApiService().verifyEmailApi(
        email.value,
        loginType.value,
        firstName.value,
        lastName.value,
        password.value,
        mobile.value,
        deviceToken.value,
        address.value,
        lat.value,
        long.value,
      );

      if (response['status'] == true) {
        ToastClass.showToast(
          '${"Otp resend successfully"}',
        );
        otp.value = response['otp'];

        log("OTP ---- ${response['otp'].toString()}");

        otpController.value.text = response['data']['otp'].toString();
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

  // Resend_Api() async {
  //   // final prefs = await SharedPreferences.getInstance();
  //   // var devicetype = prefs.getString('device_type');
  //   // var device_token = prefs.getString('device_token');
  //
  //   // log("device_token ========= ${device_token}");
  //
  //   try {
  //     isLoading(true);
  //
  //     var response = await ApiService().Sign_Up(
  //         "app",
  //         firstName.value,
  //         lastName.value,
  //         email.value,
  //         password.value,
  //         mobile.value,
  //         '1'
  //     );
  //
  //     if (response['status'] == true) {
  //
  //       ToastClass.showToast('${response['message']}',);
  //
  //       Otp_controller.value.text = "1234";
  //
  //       isLoading(false);
  //
  //
  //     } else if (response['status'] == false) {
  //       ToastClass.showToast('${response['message']}',);
  //       isLoading(false);
  //     }
  //
  //   } finally {
  //
  //     isLoading(false);
  //
  //   }
  // }

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
