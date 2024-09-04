import 'package:get/get.dart';

import '../controllers/chatbootverify_otp_controller.dart';

class ChatbootverifyOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatbootverifyOtpController>(
      () => ChatbootverifyOtpController(),
    );
  }
}
