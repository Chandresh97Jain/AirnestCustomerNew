import 'package:get/get.dart';

import '../controllers/review_booking_detail_controller.dart';

class ReviewBookingDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewBookingDetailController>(
      () => ReviewBookingDetailController(),
    );
  }
}
