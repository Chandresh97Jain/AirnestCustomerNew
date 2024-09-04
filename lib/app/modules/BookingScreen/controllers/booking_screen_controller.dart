import 'package:get/get.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/BookingScreen/booking_request_list.dart';

class BookingScreenController extends GetxController {
  //TODO: Implement BookingScreenController

  final count = 0.obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    bookingRequestListApi();
    bookingHistoryListApi();
  }

  final bookingRequestList = <BookingRequestModel>[].obs;
  Future bookingRequestListApi() async {
   // bookingRequestList.clear();
    try {
      isLoading(true);

      var response = await ApiService().bookingRequestList('');

      if (response['status'] == true) {
        List dataList = response['data'].toList();
        bookingRequestList.value =
            dataList.map((json) => BookingRequestModel.fromJson(json)).toList();

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

  final bookingHistoryList = <BookingRequestModel>[].obs;
  Future bookingHistoryListApi() async {
   // bookingHistoryList.clear();
    try {
      isLoading(true);

      var response = await ApiService().bookingRequestList('history');

      if (response['status'] == true) {
        List dataList = response['data'].toList();
        bookingHistoryList.value =
            dataList.map((json) => BookingRequestModel.fromJson(json)).toList();

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
