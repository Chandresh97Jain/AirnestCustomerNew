import 'package:get/get.dart';

import '../controllers/create_bid_summary_controller.dart';

class CreateBidSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateBidSummaryController>(
      () => CreateBidSummaryController(),
    );
  }
}
