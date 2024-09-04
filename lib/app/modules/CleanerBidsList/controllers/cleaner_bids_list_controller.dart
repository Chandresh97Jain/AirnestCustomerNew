import 'package:get/get.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/CleanerBidsList/bid_list_model.dart';


class CleanerBidsListController extends GetxController {
  //TODO: Implement CleanerBidsListController

  final count = 0.obs;
  final isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    bidListCleanerApi();
    bidListCoHostApi();
  }

  final cleanerBidList = <BidListModel>[].obs;
  Future bidListCleanerApi() async {
    cleanerBidList.clear();
    try {
      isLoading(true);

      var response = await ApiService().bidByCleanerApi('1');

      if (response['status'] == true) {

        List dataList = response['data'].toList();
        cleanerBidList.value = dataList.map((json) => BidListModel.fromJson(json)).toList();

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

  final coHostBidList = <BidListModel>[].obs;
  Future bidListCoHostApi() async {
    coHostBidList.clear();
    try {
      isLoading(true);

      var response = await ApiService().bidByCleanerApi('2');

      if (response['status'] == true) {

        List dataList = response['data'].toList();
        coHostBidList.value = dataList.map((json) => BidListModel.fromJson(json)).toList();

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

  Future deleteCleanerBidApi(bidId,idx) async {
    try {
      // isLoading(true);

      var response = await ApiService().deleteBid(bidId);

      if (response['status'] == true) {

        cleanerBidList.removeAt(idx);

        update();
        // isLoading(false);
      } else if (response['status'] == false) {

        // isLoading(false);
        update();
      }
    } finally {
      // isLoading(false);
      update();

    }
  }
  Future deleteCoHostBidApi(bidId,idx) async {
    try {
      // isLoading(true);

      var response = await ApiService().deleteBid(bidId);

      if (response['status'] == true) {

        coHostBidList.removeAt(idx);

        update();
        // isLoading(false);
      } else if (response['status'] == false) {

        // isLoading(false);
        update();
      }
    } finally {
      // isLoading(false);
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
