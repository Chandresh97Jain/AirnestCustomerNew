import 'package:get/get.dart';

import '../controllers/create_bid_for_cleaner_and_cohost_controller.dart';

class CreateBidForCleanerAndCohostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateBidForCleanerAndCohostController>(
      () => CreateBidForCleanerAndCohostController(),
    );
  }
}
