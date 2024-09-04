import 'package:get/get.dart';

import '../controllers/maid_details_controller.dart';

class MaidDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaidDetailsController>(
      () => MaidDetailsController(),
    );
  }
}
