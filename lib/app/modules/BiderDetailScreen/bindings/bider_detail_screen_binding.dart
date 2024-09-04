import 'package:get/get.dart';

import '../controllers/bider_detail_screen_controller.dart';

class BiderDetailScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BiderDetailScreenController>(
      () => BiderDetailScreenController(),
    );
  }
}
