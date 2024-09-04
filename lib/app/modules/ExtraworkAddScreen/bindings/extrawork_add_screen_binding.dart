import 'package:get/get.dart';

import '../controllers/extrawork_add_screen_controller.dart';

class ExtraworkAddScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExtraworkAddScreenController>(
      () => ExtraworkAddScreenController(),
    );
  }
}
