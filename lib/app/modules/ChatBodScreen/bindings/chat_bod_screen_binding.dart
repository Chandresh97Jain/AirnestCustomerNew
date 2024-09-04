import 'package:get/get.dart';

import '../controllers/chat_bod_screen_controller.dart';

class ChatBodScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatBodScreenController>(
      () => ChatBodScreenController(),
    );
  }
}
