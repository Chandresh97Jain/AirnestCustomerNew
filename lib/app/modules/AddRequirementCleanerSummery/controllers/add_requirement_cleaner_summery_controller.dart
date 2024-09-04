import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/AddRequirementCleaner/controllers/add_requirement_cleaner_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';


class AddRequirementCleanerSummeryController extends GetxController {
  //TODO: Implement AddRequirementCleanerSummeryController

  AddRequirementCleanerController addRequirementCleanerController =  Get.put(AddRequirementCleanerController());


  final count = 0.obs;
  // final title ="".obs;
  // final id ="".obs;
  final userType ="".obs;
  final zipCode ="".obs;
  final cleanerCohostId ="".obs;
  final serviceId ="".obs;
  final serviceName ="".obs;
  final isLoading = false.obs;

  String? formatTimeOfDay(TimeOfDay? timeOfDay) {
    if (timeOfDay == null) return null;

    int hour = timeOfDay.hour;
    final minute = timeOfDay.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';

    if (hour == 0) {
      hour = 12; // Midnight case
    } else if (hour > 12) {
      hour -= 12; // Convert to 12-hour format
    }

    final formattedHour = hour.toString().padLeft(2, '0');
    return '$formattedHour:$minute $period';
  }

  @override
  void onInit() {
    isLoading.value  = false;
    // title.value = Get.parameters['title']??"";
    // id.value = Get.parameters['id']??"";
    zipCode.value = Get.parameters['zip_code']!;
    userType.value = Get.parameters['user_type']!;
    cleanerCohostId.value = Get.parameters['cleaner_cohost_id']!;
    serviceId.value = Get.parameters['service_id']!;
    serviceName.value = Get.parameters['service_name']!;
    super.onInit();
  }

  cleanerPropertyAddApiForSD() async {
    try {
      isLoading(true);

      String titlee =  addRequirementCleanerController.serviceTitleList.toString();

      // Remove the square brackets
      String cleanedInput = titlee.substring(1, titlee.length - 1);

      // Split the string by commas and trim each item, then add double quotes
      List<String> result = cleanedInput
          .split(',')
          .map((item) => '"${item.trim()}"')
          .toList();

      log(result.toString());  // Output: ["Per Bedroom", "Per Bathroom", "Per Hour"]

      var response = await ApiService().cleanerPropertyAdd(
        addRequirementCleanerController.nameTextController.value.text,
        addRequirementCleanerController.googleMapService.addressController.value.text,
        addRequirementCleanerController.userType.value,
        addRequirementCleanerController.propertySizeSQFT.value,
        "0",
        addRequirementCleanerController.selectedDate.value.toString(),
        formatTimeOfDay(addRequirementCleanerController.selectedTime.value),
        addRequirementCleanerController.needsTextController.text,
        addRequirementCleanerController.zipCode.value,
        serviceId.value,
        addRequirementCleanerController.serviceLableId.toString(),
          result.toString(),
        addRequirementCleanerController.serviceQtyList.toString(),
        addRequirementCleanerController.serviceActualPrice.toString(),
        addRequirementCleanerController.selectServiceStandardDeep.value == "0"?"1":"2",
        cleanerCohostId.value,
          addRequirementCleanerController.washTowels.value,
          addRequirementCleanerController.cleanerSupplies.value,
          addRequirementCleanerController.selectPropertyId.value??""
      );
      if (response['status'] == true) {


        log("Check prices formate  ${addRequirementCleanerController.serviceLableId.toString()}");
        log("Check prices formate  ${result.toString()}");
        log("Check prices formate  ${addRequirementCleanerController.serviceQtyList.toString()}");
        log("Check prices formate  ${addRequirementCleanerController.serviceTotalPriceList.toString()}");


        ToastClass.showToast('${response['message']}',);

        var data = {
          // "title": title.toString(),
          // "id": id.toString(),
          "zip_code": zipCode.toString(),
          "user_type": userType.toString(),
          "cleaner_cohost_id": cleanerCohostId.toString(),
          "service_id": serviceId.toString(),
          "service_name": serviceName.toString(),
          "property_id": response['data']['id'].toString(),
          "bid_id": response['data']['bid_id'].toString(),
        };
        Get.toNamed(Routes.BOOKING_SUMMARY,parameters: data);

        isLoading(false);

      } else if (response['status'] == false) {
        ToastClass.showToast('${response['message']}',);
        isLoading(false);
      }

    } finally {

      isLoading(false);

    }
  }
  cleanerPropertyAddApiForHourly() async {
    try {
      isLoading(true);

      var response = await ApiService().cleanerPropertyAddForPerHour(
        addRequirementCleanerController.nameTextController.value.text,
        addRequirementCleanerController.googleMapService.addressController.value.text,
        addRequirementCleanerController.userType.value,
        addRequirementCleanerController.propertySizeSQFT.value,
        "0",
        addRequirementCleanerController.selectedDate.value.toString(),
        formatTimeOfDay(addRequirementCleanerController.selectedTime.value),
        addRequirementCleanerController.needsTextController.text,
        addRequirementCleanerController.zipCode.value,
        serviceId.value,
        addRequirementCleanerController.hourQty.toString(),
        addRequirementCleanerController.actualHourlyPrice.toString(),
        addRequirementCleanerController.selectServiceWeeklyHourly.value == "0"
            ?"1"
            : addRequirementCleanerController.selectServiceWeeklyHourly.value == "1"
            ?"2"
            :"3",
        cleanerCohostId.value,
          addRequirementCleanerController.washTowels.value,
          addRequirementCleanerController.cleanerSupplies.value,
        addRequirementCleanerController.selectPropertyId.value??""
      );
      if (response['status'] == true) {

        ToastClass.showToast('${response['message']}',);

        var data = {
          // "title": title.toString(),
          // "id": id.toString(),
          "zip_code": zipCode.toString(),
          "user_type": userType.toString(),
          "cleaner_cohost_id": cleanerCohostId.toString(),
          "service_id": serviceId.toString(),
          "service_name": serviceName.toString(),
          "property_id": response['data']['id'].toString(),
          "bid_id": response['data']['bid_id'].toString(),
        };
        Get.toNamed(Routes.BOOKING_SUMMARY,parameters: data);

        isLoading(false);

      } else if (response['status'] == false) {
        ToastClass.showToast('${response['message']}',);
        isLoading(false);
      }

    } finally {

      isLoading(false);

    }
  }
  cleanerPropertyAddApiForSqrFet() async {
    try {
      isLoading(true);
      var response = await ApiService().cohostPropertyAdd(
        addRequirementCleanerController.nameTextController.value.text,
        cleanerCohostId.value,
        addRequirementCleanerController.userType.value,
        addRequirementCleanerController.googleMapService.addressController.value.text,
        addRequirementCleanerController.propertySizeSQFT.value,
        addRequirementCleanerController.selectedDate.value.toString(),
        formatTimeOfDay(addRequirementCleanerController.selectedTime.value),
        addRequirementCleanerController.needsTextController.text,
        addRequirementCleanerController.selectServiceWeeklyHourly.value == "0"
            ?"1"
            : addRequirementCleanerController.selectServiceWeeklyHourly.value == "1"
            ?"2"
            :"3",
        addRequirementCleanerController.zipCode.value,
        addRequirementCleanerController.washTowels.value,
        addRequirementCleanerController.cleanerSupplies.value,
        addRequirementCleanerController.sQft.value,
        addRequirementCleanerController.totalSqftPrice.value,
        serviceId.value,
        addRequirementCleanerController.selectPropertyId.value??"",
     );
      if (response['status'] == true) {

        ToastClass.showToast('${response['message']}',);

        var data = {
          // "title": title.toString(),
          // "id": id.toString(),
          "zip_code": zipCode.toString(),
          "user_type": userType.toString(),
          "cleaner_cohost_id": cleanerCohostId.toString(),
          "service_id": serviceId.toString(),
          "service_name": serviceName.toString(),
          "property_id": response['data']['id'].toString(),
          "bid_id": response['data']['bid_id'].toString(),
        };
        Get.toNamed(Routes.BOOKING_SUMMARY,parameters: data);

        isLoading(false);

      } else if (response['status'] == false) {
        ToastClass.showToast('${response['message']}',);
        isLoading(false);
      }

    } finally {

      isLoading(false);

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
