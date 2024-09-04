import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';

class WritereviewController extends GetxController {
  //TODO: Implement WritereviewController

  final rating = 0.obs;


  TextEditingController reviewController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  final count = 0.0.obs;
  final isLoading = false.obs;
  final bookingId = ''.obs;
  final cleanerName = ''.obs;
  final cleanerImage = ''.obs;
  final description = ''.obs;
  final bookingDate = ''.obs;

  @override
  void onInit() {
    bookingId.value = Get.parameters['booking_id']!;
    cleanerName.value = Get.parameters['cleaner_name']!;
    cleanerImage.value = Get.parameters['cleaner_image']!;
    description.value = Get.parameters['description']!;
    bookingDate.value = Get.parameters['booking_date']!;

    log("cleaner_name.value--- ${cleanerName.value.toString()}");
    super.onInit();
  }

  reviewApi() async {
    try {
      isLoading(true);

      var response = await ApiService().reviewByCustomerApi(bookingId.value,
          rating.value.toString(), titleController.text, reviewController.text);

      if (response['status'] == true) {
        Get.back();

        ToastClass.showToast(
          '${response['message']}',
        );

        isLoading(false);
      } else if (response['status'] == false) {
        ToastClass.showToast(
          '${response['message']}',
        );
        isLoading(false);
        update();
      }
    } finally {
      isLoading(false);
      update();
    }
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
