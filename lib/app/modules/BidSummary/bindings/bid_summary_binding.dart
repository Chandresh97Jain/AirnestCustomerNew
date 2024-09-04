import 'package:get/get.dart';

import '../controllers/bid_summary_controller.dart';


class BidSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BidSummaryController>(
      () => BidSummaryController(),
    );
  }
}
