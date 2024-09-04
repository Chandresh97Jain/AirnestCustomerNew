import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/modules/BookingScreen/views/booking_screen_view.dart';
import 'package:power_maids/app/modules/ChatList/views/chat_list_view.dart';
import 'package:power_maids/app/modules/Deshboard/controllers/deshboard_controller.dart';
import 'package:power_maids/app/modules/HomeScreen/views/home_screen_view.dart';
import 'package:power_maids/app/modules/NotificationScreen/views/notification_screen_view.dart';
import 'package:power_maids/app/modules/ProfileScreen/views/profile_screen_view.dart';

class DeshboardView extends GetView<DeshboardController> {
  const DeshboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // Set a base font size
    double titleFontSize = 11.0;
    // Calculate the adjusted font size based on screen width
    double adjustedFontSize = screenWidth / 355.0 * titleFontSize;

    return Obx(() => Scaffold(
          backgroundColor: AppStyles.backgroundColor,
          // key: controller.navigatorKey,
          body: PageStorage(
            bucket: controller.bucket,
            child: controller.currentScreen,
          ),
          bottomNavigationBar: BottomAppBar(
            color: AppStyles.backgroundColor,
            surfaceTintColor: AppStyles.backgroundColor,
            shape: const CircularNotchedRectangle(),
            height: 90,
            // notchMargin: 10,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    // highlightColor: CommonClass.color_primary,
                    onTap: () {
                      controller.currentScreen =
                      const HomeScreenView(); // if user taps on this dashboard tab will be active
                      controller.currentTab.value = 0;
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/icons/HomeIcon.png",
                            height: 23,
                            color: controller.currentTab.value == 0
                                ? AppStyles.appThemeColor
                                : AppStyles.UnselectedTabColor),
                        Textwidget(
                          text: "Home",
                          color: controller.currentTab.value == 0
                              ? AppStyles.appThemeColor
                              : AppStyles.UnselectedTabColor,
                          fontSize: adjustedFontSize,
                          textscalefector: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    //  highlightColor: CommonClass.color_primary,
                    onTap: () {
                      controller.currentScreen =
                          const ChatListView(); // if user taps on this dashboard tab will be active
                      controller.currentTab.value = 1;
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/icons/ChatIcon.png",
                            height: 23,
                            color: controller.currentTab.value == 1
                                ? AppStyles.appThemeColor
                                : AppStyles.UnselectedTabColor),
                        Textwidget(
                          text: "Chat",
                          color: controller.currentTab.value == 1
                              ? AppStyles.appThemeColor
                              : AppStyles.UnselectedTabColor,
                          fontSize: adjustedFontSize,
                          textscalefector: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    // highlightColor: CommonClass.color_primary,
                    onTap: () {
                      controller.currentScreen =
                          const BookingScreenView(); // if user taps on this dashboard tab will be active
                      controller.currentTab.value = 2;
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/icons/BookingIcon.png",
                            height: 23,
                            color: controller.currentTab.value == 2
                                ? AppStyles.appThemeColor
                                : AppStyles.UnselectedTabColor),
                        Textwidget(
                          text: "Booking",
                          color: controller.currentTab.value == 2
                              ? AppStyles.appThemeColor
                              : AppStyles.UnselectedTabColor,
                          fontSize: adjustedFontSize,
                          textscalefector: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    //  highlightColor: CommonClass.color_primary,
                    onTap: () {
                      controller.currentScreen =
                          const NotificationScreenView(); // if user taps on this dashboard tab will be active
                      controller.currentTab.value = 3;
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/icons/NotificationIcon.png",
                            height: 23,
                            color: controller.currentTab.value == 3
                                ? AppStyles.appThemeColor
                                : AppStyles.UnselectedTabColor),
                        Textwidget(
                          text: "Notification",
                          color: controller.currentTab.value == 3
                              ? AppStyles.appThemeColor
                              : AppStyles.UnselectedTabColor,
                          fontSize: adjustedFontSize,
                          textscalefector: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    //  highlightColor: CommonClass.color_primary,
                    onTap: () {
                      controller.currentScreen =
                          const ProfileScreenView(); // if user taps on this dashboard tab will be active
                      controller.currentTab.value = 4;
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/icons/ProfileIcon.png",
                            height: 23,
                            color: controller.currentTab.value == 4
                                ? AppStyles.appThemeColor
                                : AppStyles.UnselectedTabColor),
                        Textwidget(
                          text: "Profile",
                          color: controller.currentTab.value == 4
                              ? AppStyles.appThemeColor
                              : AppStyles.UnselectedTabColor,
                          fontSize: adjustedFontSize,
                          textscalefector: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
