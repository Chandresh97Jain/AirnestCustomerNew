import 'package:get/get.dart';

import '../controllers/customer_information_controller.dart';

class CustomerInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerInformationController>(
      () => CustomerInformationController(),
    );
  }
}
