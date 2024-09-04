import 'package:get/get.dart';

import '../controllers/wellcome_screen_controller.dart';

class WellcomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WellcomeScreenController>(
      () => WellcomeScreenController(),
    );
  }
}
