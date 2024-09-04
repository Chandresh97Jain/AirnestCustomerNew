import 'package:get/get.dart';

import '../controllers/sign_up_verify_otp_controller.dart';

class SignUpVerifyOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpVerifyOtpController>(
      () => SignUpVerifyOtpController(),
    );
  }
}
