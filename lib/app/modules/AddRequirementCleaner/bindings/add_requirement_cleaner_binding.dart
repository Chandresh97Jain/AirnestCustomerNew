import 'package:get/get.dart';

import '../controllers/add_requirement_cleaner_controller.dart';

class AddRequirementCleanerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddRequirementCleanerController>(
      () => AddRequirementCleanerController(),
    );
  }
}
