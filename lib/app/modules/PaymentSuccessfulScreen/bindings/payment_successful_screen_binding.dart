import 'package:get/get.dart';

import '../controllers/payment_successful_screen_controller.dart';

class PaymentSuccessfulScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentSuccessfulScreenController>(
      () => PaymentSuccessfulScreenController(),
    );
  }
}
