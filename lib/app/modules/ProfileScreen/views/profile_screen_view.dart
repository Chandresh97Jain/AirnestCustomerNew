import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/cached_netword_image.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/app/modules/ProfileScreen/controllers/profile_screen_controller.dart';
import 'package:power_maids/app/modules/ProfileScreen/profile_ui.dart';
import 'package:power_maids/app/routes/app_pages.dart';
import 'package:share/share.dart';

class ProfileScreenView extends GetView<ProfileScreenController> {
  const ProfileScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Obx(
      () => Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            shadowColor: Colors.white,
            margin: const EdgeInsets.only(left: 13, right: 13),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 20, bottom: 20),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppStyles.appThemeColor),
                        shape: BoxShape.circle),
                    height: 130,
                    width: 130,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: ProfileImage(
                            image: controller.image.value, fit: BoxFit.fill)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                      child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Textwidget(
                          maxLines: 2,
                          text:
                              "${controller.fname.value} ${controller.lname.value}",
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                        Textwidget(
                          maxLines: 2,
                          text: controller.email.value,
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: AppStyles.appThemeColor,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () async {
                            await Get.toNamed(Routes.EDIT_PROFILE)!
                                .then((value) {
                              if (value == true) {
                                // Perform the refresh action here
                                controller.retriveData();
                              }
                            });
                          },
                          child: SizedBox(
                            width: 150,
                            height: 40,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: AppStyles.BlackColor,
                              margin: EdgeInsets.zero,
                              child: Center(
                                  child: Textwidget(
                                textscalefector: 1,
                                text: "Manage Profile",
                                color: AppStyles.backgroundColor,
                                fontSize: 12,
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileUI(
                    iconColor: AppStyles.appThemeColor,
                    iconImages: 'assets/icons/createbidicon.png',
                    title: 'Create a bid/Co-host/Search Cleaner',
                    onPressed: () {
                      Get.toNamed(Routes.MAKE_ACCOUNT_WITH_SCREEN,
                          arguments: false);
                    },
                  ),
                  Divider(
                    endIndent: 18,
                    indent: 18,
                    height: 0,
                    thickness: 1,
                    color: AppStyles.deviderColor,
                  ),
                  ProfileUI(
                    iconColor: AppStyles.appThemeColor,
                    iconImages: 'assets/icons/mybid_icon.png',
                    title: 'My Bids',
                    onPressed: () {
                      Get.toNamed(Routes.CLEANER_BIDS_LIST);
                    },
                  ),
                  Divider(
                    endIndent: 18,
                    indent: 18,
                    height: 0,
                    thickness: 1,
                    color: AppStyles.deviderColor,
                  ),
                  ProfileUI(
                    iconColor: AppStyles.appThemeColor,
                    iconImages: 'assets/icons/changepasswordIcon.png',
                    title: 'Change Password',
                    onPressed: () {
                      Get.toNamed(Routes.CHANGE_PASSWORD);
                    },
                  ),
                  Divider(
                    endIndent: 18,
                    indent: 18,
                    height: 0,
                    thickness: 1,
                    color: AppStyles.deviderColor,
                  ),
                  ProfileUI(
                    iconColor: AppStyles.appThemeColor,
                    iconImages: 'assets/icons/cardnumbericon.png',
                    title: 'Saved Card',
                    onPressed: () {
                      Get.toNamed(Routes.SAVED_CARD);
                    },
                  ),
                  Divider(
                    endIndent: 18,
                    indent: 18,
                    height: 0,
                    thickness: 1,
                    color: AppStyles.deviderColor,
                  ),
                  ProfileUI(
                    iconColor: AppStyles.appThemeColor,
                    iconImages: 'assets/icons/helpicon.png',
                    title: 'Help',
                    onPressed: () {
                      Get.toNamed(Routes.HELP_SCREEN);
                    },
                  ),
                  Divider(
                    endIndent: 18,
                    indent: 18,
                    height: 0,
                    thickness: 1,
                    color: AppStyles.deviderColor,
                  ),
                  ProfileUI(
                    iconColor: AppStyles.appThemeColor,
                    iconImages: 'assets/icons/unlike.png',
                    title: 'My Favourite',
                    onPressed: () {
                      Get.toNamed(Routes.MY_FAVOURITE);
                    },
                  ),
                  Divider(
                    endIndent: 18,
                    indent: 18,
                    height: 0,
                    thickness: 1,
                    color: AppStyles.deviderColor,
                  ),
                  ProfileUI(
                    iconColor: AppStyles.appThemeColor,
                    iconImages: 'assets/icons/addproperty.png',
                    title: 'My Property',
                    onPressed: () {
                      Get.toNamed(Routes.ADD_PROPERTY_SCREEN);
                    },
                  ),
                  Divider(
                    endIndent: 18,
                    indent: 18,
                    height: 0,
                    thickness: 1,
                    color: AppStyles.deviderColor,
                  ),
                  ProfileUI(
                    iconColor: AppStyles.appThemeColor,
                    iconImages: 'assets/icons/chatbooticon.png',
                    title: 'Chat Bot',
                    onPressed: () {
                      Get.toNamed(Routes.CHAT_BOD_SCREEN);
                    },
                  ),
                  Divider(
                    endIndent: 18,
                    indent: 18,
                    height: 0,
                    thickness: 1,
                    color: AppStyles.deviderColor,
                  ),
                  ProfileUI(
                    iconColor: AppStyles.appThemeColor,
                    iconImages: 'assets/icons/blog.png',
                    imageIconColor: AppStyles.appThemeColor,
                    title: 'Blog section',
                    onPressed: () {
                      Get.toNamed(Routes.BLOGSSCREEN);
                    },
                  ),
                  Divider(
                    endIndent: 18,
                    indent: 18,
                    height: 0,
                    thickness: 1,
                    color: AppStyles.deviderColor,
                  ),
                  ProfileUI(
                    iconColor: AppStyles.appThemeColor,
                    iconImages: 'assets/icons/refer.png',
                    imageIconColor: AppStyles.appThemeColor,
                    title: 'Refer App',
                    onPressed: () {
                      Share.share('Check out this cool app: YourAppLink');
                      // var whatsappUrl =
                      //     "https://wa.me/?text=Hey buddy, try this super cool new app!";
                      // // "whatsapp:";
                      // // "whatsapp://send?phone=8575785855";
                      // try {
                      //   launch(whatsappUrl);
                      // } catch (e) {
                      //   //To handle error and display error message
                      // }
                    },
                  ),
                  Divider(
                    endIndent: 18,
                    indent: 18,
                    height: 0,
                    thickness: 1,
                    color: AppStyles.deviderColor,
                  ),
                  ProfileUI(
                    iconColor: AppStyles.appThemeColor,
                    iconImages: 'assets/icons/logoutIcon.png',
                    title: 'Log Out',
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 0,
                                contentPadding: EdgeInsets.zero,
                                titlePadding: EdgeInsets.zero,
                                content: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 20, bottom: 20),
                                  child: Obx(
                                    () => Visibility(
                                      visible: controller.isLoading.isFalse,
                                      replacement: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ShowLoader.isLoadingProgress(
                                              controller.isLoading.value),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Textwidget(
                                            textAlign: TextAlign.center,
                                            text:
                                                "Are you sure\nyou want to logout?",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                50,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: MyButtonForAlertbox(
                                                      text: "Logout",
                                                      onPressed: () {
                                                        controller
                                                            .logOut(context);
                                                      },
                                                      color: AppStyles
                                                          .appThemeColor,
                                                      TextColor: AppStyles
                                                          .backgroundColor)),
                                              Expanded(
                                                  child: MyButtonForAlertbox(
                                                      text: "Cancel",
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      color: AppStyles
                                                          .backgroundColor,
                                                      TextColor: AppStyles
                                                          .BlackColor)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                          });
                    },
                  ),
                  Divider(
                    endIndent: 18,
                    indent: 18,
                    height: 0,
                    thickness: 1,
                    color: AppStyles.deviderColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )));
  }
}
