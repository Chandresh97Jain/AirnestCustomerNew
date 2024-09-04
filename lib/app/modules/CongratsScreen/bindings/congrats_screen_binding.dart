import 'package:get/get.dart';

import '../controllers/congrats_screen_controller.dart';

class CongratsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CongratsScreenController>(
      () => CongratsScreenController(),
    );
  }
}
