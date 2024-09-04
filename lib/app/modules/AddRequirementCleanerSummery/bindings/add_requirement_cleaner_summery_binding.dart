import 'package:get/get.dart';

import '../controllers/add_requirement_cleaner_summery_controller.dart';

class AddRequirementCleanerSummeryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddRequirementCleanerSummeryController>(
      () => AddRequirementCleanerSummeryController(),
    );
  }
}
