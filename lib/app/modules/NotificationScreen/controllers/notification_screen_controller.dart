import 'dart:developer';
import 'package:get/get.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/NotificationScreen/MOdel/notification_list_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationScreenController extends GetxController {
  //TODO: Implement NotificationScreenController
  RefreshController refreshController = RefreshController(initialRefresh: false);

  final count = 0.obs;

  final imagesList = [
    "assets/images/nImageone.png",
    "assets/images/nImagetwo.png",



  ];
  final nameList = [
    "Amber Julia", "Barbara Michelle"



  ];
  final titleList = [
    'confirmed your booking request',
    'confirmed your booking request',


  ];
  final dateList = [

    'Mon, Oct 16',
    'Mon, Oct 16',


  ];
  final timeList = [

    "10:00 PM",
    "10:00 PM",


  ];


  final notificationItems = {
    'ImagesList': [

    ],
    'NameList': [],
    'TitleList': [

    ],
    'DateList': [
      'Mon, Oct 16',
      'Mon, Oct 16',
    ],
    'TimeList': [
      "10:00 PM",
    ],
  };

  final isLoadingNotification = false.obs;
  final isReadNotification = false.obs;
  final getNotificationList = <NotificationListModule>[].obs;




  Future allNotificationGet() async {
    try {

      isLoadingNotification(true);

      log('allNotificationGet----------------');

      var response = await ApiService().notificationListAPI();


      if (response['status'] == true) {

        List dataList = response['data'].toList();

        getNotificationList.value = dataList.map((json) => NotificationListModule.fromJson(json)).toList();


        log('intro----------------${response}');
      } else if (response['status'] == false) {
        isLoadingNotification(false);
      }
    } finally {
      isLoadingNotification(false);
    }
  }

  Future readNotification({notificationId, bidDetailsId}) async {
    try {

      isReadNotification(true);

      log('readNotification----------------');

      var response = await ApiService().readNotificationAPI(notificationId: notificationId.toString());


      if (response['status'] == true) {
        log("lklklkl$bidDetailsId");

        var data = {
          "bid_id": bidDetailsId.toString()
        };

        // await  Get.toNamed(Routes.PROJECT_DETAILS_SCREEN,parameters: data)!.then((value) {
        //   if (value == true) {
        //     // Perform the refresh action here
        //     allNotificationGet();
        //   }
        // });

        log('intro----------------${response}');
      } else if (response['status'] == false) {
        isReadNotification(false);
      }
    } finally {
      isReadNotification(false);
    }
  }


  void reFreshApis() async {
    allNotificationGet();
  }


  @override
  void onInit() {

    allNotificationGet();

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
