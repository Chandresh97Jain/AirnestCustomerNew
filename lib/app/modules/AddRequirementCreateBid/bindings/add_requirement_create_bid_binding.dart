import 'package:get/get.dart';

import '../controllers/add_requirement_create_bid_controller.dart';

class AddRequirementCreateBidBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddRequirementCreateBidController>(
      () => AddRequirementCreateBidController(),
    );
  }
}
