import 'package:get/get.dart';

class PaymentSuccessfulScreenController extends GetxController {
  //TODO: Implement PaymentSuccessfulScreenController

  final count = 0.obs;
  final bookingId = ''.obs;


  @override
  void onInit() {
    bookingId.value = Get.parameters['booking_id']??"";
    super.onInit();
  }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
