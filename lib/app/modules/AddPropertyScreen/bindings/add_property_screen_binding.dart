import 'package:get/get.dart';

import '../controllers/add_property_screen_controller.dart';

class AddPropertyScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPropertyScreenController>(
      () => AddPropertyScreenController(),
    );
  }
}
