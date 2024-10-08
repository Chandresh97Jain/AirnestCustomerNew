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

  final extraServicesId = [].obs;
  final extraServicesTitle = [].obs;
  final extraServicesQty = [].obs;
  final extraServicesPrice = [].obs;


  void toggleItemSelection(String id,String title,String price) {
    if (extraServicesId.contains(id)) {
      extraServicesId.remove(id);
      extraServicesTitle.remove(title);
      extraServicesQty.remove("1");
      extraServicesPrice.remove(price);

      print("extra service title remove-- ${extraServicesTitle}");
    } else {
      extraServicesId.add(id);
      extraServicesTitle.add(title);
      extraServicesQty.add("1");
      extraServicesPrice.add(price);
      print("extra service title add-- ${extraServicesTitle}");
    }
  }

  bool isItemSelected(String item) {
    return extraServicesId.contains(item);
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
