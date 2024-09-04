import 'package:get/get.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/CreateBidSummary/model/property_summary_model.dart';


class CreateBidSummaryController extends GetxController {
  //TODO: Implement CreateBidSummaryController

  final count = 0.obs;

  final title ="".obs;
  final propertyId ="".obs;
  final serviceName ="".obs;
  final isLoading = false.obs;


  // String? formatTimeOfDay(TimeOfDay? timeOfDay) {
  //   if (timeOfDay == null) return null;
  //
  //   int hour = timeOfDay.hour;
  //   final minute = timeOfDay.minute.toString().padLeft(2, '0');
  //   final period = hour >= 12 ? 'PM' : 'AM';
  //
  //   if (hour == 0) {
  //     hour = 12; // Midnight case
  //   } else if (hour > 12) {
  //     hour -= 12; // Convert to 12-hour format
  //   }
  //
  //   final formattedHour = hour.toString().padLeft(2, '0');
  //   return '$formattedHour:$minute $period';
  // }

  @override
  void onInit() {
    propertyId.value = Get.parameters['property_id']??"";
    serviceName.value = Get.parameters['service_name']??"";
    super.onInit();
    propertySummaryApi();
  }


  final propertySummaryList = <PropertySummaryModel>[].obs;
  final summaryList = {}.obs;
  Future propertySummaryApi() async {
    propertySummaryList.clear();
    try {
      isLoading(true);

      var response = await ApiService().propertySummary(propertyId.value);

      if (response['status'] == true) {

        List dataList = response['data'].toList();
        propertySummaryList.value = dataList.map((json) => PropertySummaryModel.fromJson(json)).toList();

        summaryList.value = propertySummaryList[0].toJson(); // Assuming toJson() method is available to convert PropertySummaryModel to a map.

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
