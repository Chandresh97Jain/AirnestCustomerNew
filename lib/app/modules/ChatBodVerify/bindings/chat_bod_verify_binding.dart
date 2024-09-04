import 'package:get/get.dart';

import '../controllers/chat_bod_verify_controller.dart';

class ChatBodVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatBodVerifyController>(
      () => ChatBodVerifyController(),
    );
  }
}
