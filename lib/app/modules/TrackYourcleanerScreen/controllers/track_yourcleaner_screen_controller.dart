import 'package:get/get.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/TrackYourcleanerScreen/booking_tracking_model.dart';


class TrackYourcleanerScreenController extends GetxController {
  //TODO: Implement TrackYourcleanerScreenController

  final count = 0.obs;
  final isLoading = false.obs;
  final bookingId = ''.obs;

  final extraWorkelist  = [

    "Inside Fridge",
    "Deep Cleaning",
    "Interior Windows",
    "Inside Oven"
  ];

  @override
  void onInit() {
    bookingId.value = Get.parameters['booking_id']!;
    super.onInit();
    bookingTrackingApi();
  }


  final bookingList = <BookingTrackingModel>[].obs;
  final trackingDetails = {}.obs;
  Future bookingTrackingApi() async {

    bookingList.clear();
    try {
      isLoading(true);

      var response = await ApiService().bookingTrackingApi(bookingId.toString());


      if (response['status'] == true) {

        List dataList = response['data'].toList();
        bookingList.value = dataList.map((json) => BookingTrackingModel.fromJson(json)).toList();
        // tracking_details.value = booking_list.toJson();

        update();

        isLoading(false);
      } else if (response['status'] == false) {
        ToastClass.showToast('${response['message']}',);
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
