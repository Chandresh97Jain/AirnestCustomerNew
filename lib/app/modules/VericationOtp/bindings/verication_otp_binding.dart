import 'package:get/get.dart';

import '../controllers/verication_otp_controller.dart';

class VericationOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VericationOtpController>(
      () => VericationOtpController(),
    );
  }
}
