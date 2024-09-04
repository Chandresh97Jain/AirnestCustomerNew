import 'package:get/get.dart';

import '../../../../Utils/api_service.dart';
import '../model/extra_service_model.dart';

class ExtraworkAddScreenController extends GetxController {
  //TODO: Implement ExtraworkAddScreenController

  final count = 0.obs;
  // final title ="".obs;
  // final id ="".obs;
  final userType ="".obs;
  final cleanerCohostId ="".obs;
  final serviceId ="".obs;
  final zipCode ="".obs;
  final serviceName ="".obs;
  final isLoading =false.obs;

  final addExtraServices = [].obs;


  void toggleItemSelection(String item) {
    if (addExtraServices.contains(item)) {
      addExtraServices.remove(item);
    } else {
      addExtraServices.add(item);
      // print("extra item list id ${addExtraServices[0]}");
    }
  }

  bool isItemSelected(String item) {
    return addExtraServices.contains(item);
  }

  @override
  void onInit() {
    // title.value = Get.parameters['title']??"";
    // id.value = Get.parameters['id']??"";
    zipCode.value = Get.parameters['zip_code']??"";
    userType.value = Get.parameters['user_type']!;
    cleanerCohostId.value = Get.parameters['cleaner_cohost_id']!;
    serviceId.value = Get.parameters['service_id']!;
    serviceName.value = Get.parameters['service_name']!;
    serviceListApi();
    super.onInit();
  }

  final extraServiceList = <ExtraServicesModel>[].obs;
  Future serviceListApi() async {
    extraServiceList.clear();
    try {
      isLoading(true);

      var response = await ApiService().extraServiceList();

      if (response['status'] == true) {

        List dataList = response['data'].toList();
        extraServiceList.value = dataList.map((json) => ExtraServicesModel.fromJson(json)).toList();

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
