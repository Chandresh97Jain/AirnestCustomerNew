import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/CreateBidForCleanerAndCohost/model/service_list_model.dart';


class CreateBidForCleanerAndCohostController extends GetxController {
  //TODO: Implement CreateBidForCleanerAndCohostController

  final TextEditingController zipTextController = TextEditingController();
  final count = 0.obs;

  final selectedBid = 0.obs;
  final isLoading= false.obs;

  void selectIndex(int index) {
    selectedBid.value = index;
  }

  final selectedServiceId = "".obs;
  final selectedServiceName = "".obs;
  final userType = "1".obs;

  final selectbid  = [
   "Cleaner",
    "Co-Host"
  ].obs;

  @override
  void onInit() {
    super.onInit();
    serviceListApi("1");
  }

  final serviceList = <ServicesListModel>[].obs;
  Future serviceListApi(serviceFor) async {
    serviceList.clear();
    try {
      isLoading(true);

      var response = await ApiService().serviceListApi(serviceFor);

      if (response['status'] == true) {

        List dataList = response['data'].toList();
        serviceList.value = dataList.map((json) => ServicesListModel.fromJson(json)).toList();

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
