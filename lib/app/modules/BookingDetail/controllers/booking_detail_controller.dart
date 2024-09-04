import 'dart:developer';

import 'package:get/get.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/BookingDetail/booking_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BookingDetailController extends GetxController {
  //TODO: Implement BookingDetailController

  final count = 0.obs;
  final isLoading = false.obs;
  final bookingId = ''.obs;
  final fName ="".obs;
  final lName ="".obs;
  final address ="".obs;
  final number ="".obs;
  final status ="".obs;

  @override
  void onInit() {
    getSession();
    bookingId.value = Get.parameters['booking_id']!;
    status.value = Get.parameters['status']!;
    bookingSummaryApi(Get.parameters['booking_id']!);
    super.onInit();
  }

  getSession()async{
    final prefs = await SharedPreferences.getInstance();
    fName.value = prefs.getString('firstname')!;
    lName.value = prefs.getString('lastname')!;
    address.value = prefs.getString('address')!;
    number.value = prefs.getString('mobile')!;

    log("mobile ------ ${number.value}");
    log("mobile ------ ${number.value}");
  }

  final bookingDetails = <BookingDetailModel>[].obs;
  final bookingSummary = {}.obs;
  Future bookingSummaryApi(bookingId) async {
    bookingDetails.clear();
    try {
      isLoading(true);

      var response = await ApiService().finalBookingSummaryApi(bookingId);

      if (response['status'] == true) {


        List dataList = response['data'].toList();
        bookingDetails.value = dataList.map((json) => BookingDetailModel.fromJson(json)).toList();

        bookingSummary.value = bookingDetails[0].toJson();



        update();
        isLoading(false);
      } else if (response['status'] == false) {

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
