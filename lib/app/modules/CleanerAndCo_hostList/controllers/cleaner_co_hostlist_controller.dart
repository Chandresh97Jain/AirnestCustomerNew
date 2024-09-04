import 'package:get/get.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/SelectServices/model/cleaner_cohost_list_model.dart';


class CleanerAndCoHostListController extends GetxController {
  //TODO: Implement CleanerListController

  final count = 0.obs;
  final id = "".obs;
  final title = "".obs;
  final userType = "".obs;
  final zipCode = "".obs;
  final serviceId = "".obs;
  final serviceName = "".obs;
  final isLoading = false.obs;


  @override
  void onInit() {
    id.value = Get.parameters['id'] ?? "";
    title.value = Get.parameters['title'] ?? "";
    userType.value = Get.parameters['user_type'] ?? "";
    zipCode.value = Get.parameters['zip_code'] ?? "";
    serviceId.value = Get.parameters['service_id'] ?? "";
    serviceName.value = Get.parameters['service_name'] ?? "";

    findCleanerCoHostApi(zipCode.value,serviceId.value);

    super.onInit();
  }

  final cleanercohostList = <CleanerCoHostListModel>[].obs;
  Future findCleanerCoHostApi(zip,serviceId) async {

    try {
      isLoading(true);

      var response = await ApiService().findCleanerCoHostApi(userType.value,zip,serviceId);

      if (response['status'] == true) {

        List dataList = response['data'].toList();
        cleanercohostList.value = dataList.map((json) => CleanerCoHostListModel.fromJson(json)).toList();

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
