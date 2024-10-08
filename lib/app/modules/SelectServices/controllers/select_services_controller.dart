import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:power_maids/GoogleMap/google_map_and_places.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/CreateBidForCleanerAndCohost/model/service_list_model.dart';

class SelectServicesController extends GetxController {
  //TODO: Implement SelectServicesController
  final TextEditingController zipTextController = TextEditingController();
  final count = 0.obs;
  final title = "".obs;
  final id = "".obs;

  final GoogleMapServiceController googleMapService =
      Get.put(GoogleMapServiceController());

  final nextScreendis = "".obs;
  final selectedServiceId = "".obs;
  final selectedServiceName = "".obs;
  final userType = "".obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    googleMapService.addressController.value.text = "";
    title.value = Get.parameters['title'] ?? "";
    id.value = Get.parameters['id'] ?? "";
    userType.value = Get.parameters['user_type'] ?? "";
    nextScreendis.value = Get.parameters['nextScreendis'] ?? "";
    serviceListApi(userType.value);
    log("user_type -- ${userType.value}");

    super.onInit();
  }

  final serviceList = <ServicesListModel>[].obs;
  Future serviceListApi(serviceFor) async {
    serviceList.clear();
    try {
      isLoading(true);

      var response = await ApiService().serviceListApi(serviceFor);

      if (response['status'] == true) {
        List dataList = response['data'].toList();
        serviceList.value =
            dataList.map((json) => ServicesListModel.fromJson(json)).toList();

        update();
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
