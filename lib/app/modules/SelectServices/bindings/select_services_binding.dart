import 'package:get/get.dart';

import '../controllers/select_services_controller.dart';

class SelectServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectServicesController>(
      () => SelectServicesController(),
    );
  }
}
