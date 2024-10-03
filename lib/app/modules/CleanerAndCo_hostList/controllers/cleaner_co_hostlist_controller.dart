import 'package:get/get.dart';
import 'package:power_maids/GoogleMap/google_map_and_places.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/SelectServices/model/cleaner_cohost_list_model.dart';

class CleanerAndCoHostListController extends GetxController {
  //TODO: Implement CleanerListController

  final count = 0.obs;
  final id = "".obs;
  final title = "".obs;
  final userType = "".obs;
  final addresss = "".obs;
  final lati = "".obs;
  final long = "".obs;
  final serviceId = "".obs;
  final serviceName = "".obs;
  final isLoading = false.obs;


  @override

  /// Called when the widget is inserted into the tree.
  ///
  /// This method is used to initialize the parameters
  /// id, title, userType, zipCode, serviceId, and serviceName
  /// and then call the findCleanerCoHostApi method to
  /// get the list of cleaner and co-hosts.
  ///
  /// This method is called when the widget is inserted
  /// into the tree.
  void onInit() {
    id.value = Get.parameters['id'] ?? "";
    title.value = Get.parameters['title'] ?? "";
    userType.value = Get.parameters['user_type'] ?? "";
    addresss.value = Get.parameters['address'] ?? "";
    serviceId.value = Get.parameters['service_id'] ?? "";
    serviceName.value = Get.parameters['service_name'] ?? "";
    serviceName.value = Get.parameters['lat'] ?? "";
    serviceName.value = Get.parameters['long'] ?? "";

    findCleanerCoHostApi(userType.value, addresss.value, serviceId.value,
        lati.value, long.value);

    super.onInit();
  }

  final cleanercohostList = <CleanerCoHostListModel>[].obs;
  Future findCleanerCoHostApi(
      usertype, address, serviceId, latitude, longitude) async {
    try {
      isLoading(true);

      var response = await ApiService().findCleanerCoHostApi(
          usertype, address, serviceId, latitude, longitude);

      if (response['status'] == true) {
        List dataList = response['data'].toList();
        cleanercohostList.value = dataList
            .map((json) => CleanerCoHostListModel.fromJson(json))
            .toList();

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
