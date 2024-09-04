import 'dart:developer';
import 'package:get/get.dart';
import 'package:power_maids/Utils/api_service.dart';

class TermsAndConditionsController extends GetxController {
  //TODO: Implement TermsAndConditionsController

  final count = 0.obs;
  final title = "".obs;
  final content = "".obs;

  final isLoadingTermsConditions =false.obs;

  Future getTermsAndConditions() async {
    try {
      isLoadingTermsConditions(true);


      log('GetProfile----------------');
      var response = await ApiService().getTermsAndConditions();

      
      if (response['status'] == true) {

        title.value = response['data']['title'];
        content.value = response['data']['content'];




        log('intro----------------$response');
      } else if (response['status'] == false) {
        isLoadingTermsConditions(false);
      }
    } finally {
      isLoadingTermsConditions(false);
    }
  }


  @override
  void onInit() {

    getTermsAndConditions();

    super.onInit();
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
