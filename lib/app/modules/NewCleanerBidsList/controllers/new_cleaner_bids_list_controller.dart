import 'package:get/get.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/NewCleanerBidsList/cleaner_list_by_bid_modle.dart';


class NewCleanerBidsListController extends GetxController {
  //TODO: Implement NewCleanerBidsListController

  final count = 0.obs;
  final bidId = ''.obs;
  final address = ''.obs;
  final isLoading = false.obs;



  @override
  void onInit() {
    bidId.value = Get.parameters['bid_id']!;
    address.value = Get.parameters['address']!;
    super.onInit();
    cleanerListByBidApi();
  }

  final cleanerList = <CleanerListByBidModel>[].obs;
  Future cleanerListByBidApi() async {
    cleanerList.clear();
    try {
      isLoading(true);

      var response = await ApiService().bidByCleanerListApi(bidId.value);

      if (response['status'] == true) {

        List dataList = response['data'].toList();
        cleanerList.value = dataList.map((json) => CleanerListByBidModel.fromJson(json)).toList();

        print("cleaner_list --  ${cleanerList.length}");

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
