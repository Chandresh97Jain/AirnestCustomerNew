import 'dart:developer';

import 'package:get/get.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/HelpScreen/Model/help_center_model.dart';

class HelpScreenController extends GetxController {
  //TODO: Implement HelpScreenController

  final count = 0.obs;
  final isChecked = false.obs;
  final isLoadingHelpAuth = false.obs;
  final isLoadingHelpOtherQueries = false.obs;
  final title = "".obs;
  final content = "".obs;
  final getHelpAuthList = <HelpCenterModel>[].obs;
  final getHelpOtherQueriesList = <HelpCenterModel>[].obs;

  Future getHelpForAuth() async {
    try {
      isLoadingHelpAuth(true);

      log('getHelpForAuth----------------');
      var response = await ApiService().helpCenterAPI(type: "");

      if (response['status'] == true) {
        log('intro----------------$response');

        List dataList = response['data'].toList();

        getHelpAuthList.value =
            dataList.map((json) => HelpCenterModel.fromJson(json)).toList();

        title.value = getHelpAuthList[0].title.toString();
        content.value = getHelpAuthList[0].content.toString();
      } else if (response['status'] == false) {
        isLoadingHelpAuth(false);
      }
    } finally {
      isLoadingHelpAuth(false);
    }
  }

  Future getHelpForOtherQueries() async {
    try {
      isLoadingHelpOtherQueries(true);

      log('getHelpForOtherQueries----------------');
      var response = await ApiService().helpCenterAPI(type: "1");

      if (response['status'] == true) {
        log('intro----------------$response');

        List dataList = response['data'].toList();

        getHelpOtherQueriesList.value =
            dataList.map((json) => HelpCenterModel.fromJson(json)).toList();
      } else if (response['status'] == false) {
        isLoadingHelpOtherQueries(false);
      }
    } finally {
      isLoadingHelpOtherQueries(false);
    }
  }

  final helpCenter = {
    "title": ["Authentication", "Other queries"],
    "disc": [
      "How can we reset password?",
      "How can we retrieve my account?",
      "Having problem while signing in",
    ]
  };
  final helpCenterOtherQueries = {
    "disc": [
      "How to schedule an appointment?",
      "Where to check lorem ipsum?",
      "How can we lorem ipsum data?"
    ]
  };

  @override
  void onInit() {
    getHelpForAuth();
    // getHelpForOtherQueries();
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
