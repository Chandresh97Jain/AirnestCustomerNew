import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/Utils/get_storage.dart';
import 'package:power_maids/app/modules/BookingScreen/controllers/booking_screen_controller.dart';
import 'package:power_maids/app/modules/BookingScreen/views/booking_screen_view.dart';
import 'package:power_maids/app/modules/ChatList/controllers/chat_list_controller.dart';
import 'package:power_maids/app/modules/ChatList/views/chat_list_view.dart';
import 'package:power_maids/app/modules/HomeScreen/controllers/home_screen_controller.dart';
import 'package:power_maids/app/modules/HomeScreen/views/home_screen_view.dart';
import 'package:power_maids/app/modules/NotificationScreen/controllers/notification_screen_controller.dart';
import 'package:power_maids/app/modules/NotificationScreen/views/notification_screen_view.dart';
import 'package:power_maids/app/modules/ProfileScreen/controllers/profile_screen_controller.dart';
import 'package:power_maids/app/modules/ProfileScreen/views/profile_screen_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DeshboardController extends GetxController {
  //TODO: Implement DeshboardController
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final home = Get.put(HomeScreenController());
  final chatList = Get.put(ChatListController());
  final booking = Get.put(BookingScreenController());
  final notification = Get.put(NotificationScreenController());
  final profile = Get.put(ProfileScreenController());
  var tabIndex = 0.obs;

  Widget currentScreen = const HomeScreenView(); // First view in viewport
  final currentTab = 0.obs; // to keep track of active tab index
  final PageStorageBucket bucket = PageStorageBucket();

  void changeTabindex(int index) {
    tabIndex.value = index;
    update();
  }

  final List<Widget> screens = [
    const HomeScreenView(),
    const ChatListView(),
    const BookingScreenView(),
    const NotificationScreenView(),
    const ProfileScreenView(),
  ];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getProfile();
    home.onInit();
    chatList.onInit();
    booking.onInit();
    notification.onInit();
    profile.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

   getProfile() async {
    try {
      var response = await ApiService().getProfileApi();

      if (response['status'] == true) {

        final prefs = await SharedPreferences.getInstance();

         prefs.setString('firstname', response['data']['firstname']);
         prefs.setString('lastname', response['data']['lastname']);
         prefs.setString('email', response['data']['email']);
         prefs.setString('mobile', response['data']['mobile']);
         prefs.setString('image', response['data']['image']);
         prefs.setString('member_since', response['data']['member_since']);
         prefs.setString('firebase_user_id', response['data']['firebase_id']);
        prefs.setString('user_id', response['data']['id'].toString());
        prefs.setString('address', response['data']['address'].toString());
        prefs.setString('lat', response['data']['latitude'].toString());
        prefs.setString('lng', response['data']['longitude'].toString());

          // get storage
        userData.write('user_id',response['data']['id']);
        userData.write('firstname',response['data']['firstname']);
        userData.write('lastname',response['data']['lastname']);
        userData.write('email',response['data']['email']);
        userData.write('mobile',response['data']['mobile']);
        userData.write('address',response['data']['address']);
        userData.write('your_introduction',response['data']['your_introduction']);
        userData.write('experience',response['data']['experience']);
        userData.write('zipcode',response['data']['zipcode']);
        userData.write('business_name',response['data']['business_name']);
        userData.write('website',response['data']['website']);
        userData.write('image',response['data']['image']);
        userData.write('role',response['data']['role']);


        update();
      } else if (response['status'] == false) {

        update();
      }
    } finally {
      update();
    }
  }


  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
