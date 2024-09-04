import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/cached_netword_image.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/app/modules/BiderDetailScreen/controllers/bider_detail_screen_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';

class BiderDetailScreenView extends GetView<BiderDetailScreenController> {
  const BiderDetailScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        titleSpacing: 5,
        toolbarHeight: 70,
        surfaceTintColor: AppStyles.backgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppStyles.backgroundColor,
        title: AppbarWithBackButton(
          text: 'New Cleaner Bids',
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: false,
      ),
      body: Obx(() => Stack(
        children: [
          controller.isLoading.isTrue
              ?ShowLoader.isLoadingProgress(controller.isLoading.value)
              :SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/icons/IconforHome.png",
                        height: 22,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Textwidget(
                          maxLines: 10,
                            text: controller.address.value,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      thickness: 1.5,
                      color: AppStyles.deviderColor,
                      height: 0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 80,
                              width: 85,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child:ProfileImage(image: controller.cleanerImage.value,fit: BoxFit.fill,)
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Textwidget(
                                    text: controller.serviceName.value,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  Textwidget(
                                    text: controller.cleanerName.value,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                  Textwidget(
                                    text: "\$${controller.totalPrice.value} for cleaning",
                                  ),
                                  // Textwidget(
                                  //   text: "Expire in a day",
                                  //   color: AppStyles.GraylightTextColor,
                                  //   fontSize: 12,
                                  // ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          var data = {
                            'remote_firebase_id' : controller.remoteFirebaseId.toString(),
                            'remote_user_id' : controller.remoteUserId.toString(),
                            'other_user_name' : controller.otherUserName.toString(),
                          };
                          Get.toNamed(Routes.CHAT_SCREEN,parameters: data);
                        },
                        icon: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppStyles.appThemeColor),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                                child: Image.asset(
                                  "assets/icons/chat-dots.png",
                                  height: 30,
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Textwidget(
                    text: "Bio",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Textwidget(
                    maxLines: 100,
                    text:
                    controller.about.value,
                    color: AppStyles.BlacklightTextcolor,
                    fontSize: 13,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Textwidget(
                    text: "Badges",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/icons/verifyIcon.png",
                              height: 25,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Flexible(
                                child: Textwidget(
                                  text: "Verify Cleaner",
                                  color: AppStyles.BlacklightTextcolor,
                                  fontSize: 11,
                                ))
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/business 1.png",
                              height: 25,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Flexible(
                                child: Textwidget(
                                  text: "Liability Insured",
                                  color: AppStyles.BlacklightTextcolor,
                                  fontSize: 11,
                                ))
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              "assets/icons/licenseIcon.png",
                              height: 25,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Flexible(
                                child: Textwidget(
                                  text: "Licensed  ",
                                  color: AppStyles.BlacklightTextcolor,
                                  fontSize: 11,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Textwidget(
                    text: "Reviews",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  Row(
                    children: [
                      RatingBar.builder(
                        ignoreGestures: true,
                        itemSize: 17,
                        initialRating:controller.ratting.value == "" ?0.0: double.parse(controller.ratting.value),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 0.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: AppStyles.StarIconColor,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Textwidget(
                        text: controller.ratting.value,
                      ),
                      const Spacer(),
                      Textwidget(
                        text: "${controller.review.value} Reviews",
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 18,
                        color: AppStyles.BlacklightTextcolor,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      thickness: 1.5,
                      color: AppStyles.deviderColor,
                      height: 0,
                    ),
                  ),
                  Textwidget(
                    text: "Information",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textwidget(
                        text: "Location:",
                      ),
                      const SizedBox(width: 10,),
                      Flexible(
                        child: Textwidget(
                          maxLines: 5,
                          text: controller.location.value,
                          color: AppStyles.GraylightTextColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Textwidget(
                        text: "Distance",
                      ),
                      Textwidget(
                        text: "-",
                        color: AppStyles.GraylightTextColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Textwidget(
                        text: "Airnests works",
                      ),
                      Textwidget(
                        text: controller.airWork.value,
                        color: AppStyles.GraylightTextColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Textwidget(
                  //       text: "Member since",
                  //     ),
                  //     Textwidget(
                  //       text: "April 2022",
                  //       color: AppStyles.GraylightTextColor,
                  //     ),
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      thickness: 1.5,
                      color: AppStyles.deviderColor,
                      height: 0,
                    ),
                  ),
                  // Textwidget(
                  //   text: "Message from cleaner",
                  //   fontSize: 16,
                  //   fontWeight: FontWeight.w700,
                  // ),
                  // Textwidget(
                  //   maxLines: 100,
                  //   text:
                  //   "Elit scelerisque mauris pellentesque pulvinar pellentesque habitant morbi tristique. Tortor posuere ac ut consequat semper viverra nam libero justo. Mauris commodo quis imperdiet massa tincidunt nunc pulvinar sapien et. Aliquam purus sit amet luctus venenatis lectus magna fringilla urna. Purus sit amet luctus venenatis lectus. Nunc aliquet bibendum enim facilisis. Pretium viverra suspendisse potenti nullam ac tortor vitae.",
                  //   color: AppStyles.BlacklightTextcolor,
                  //   fontSize: 13,
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  Card(
                    color: AppStyles.TextformfeildOutlineColo,
                    elevation: 0.2,
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: Textwidget(
                                    text: "Payment Info",
                                    fontSize: 16,
                                  )),
                              Flexible(
                                  child: Textwidget(
                                    text: "\$${controller.servicePrice.value}",
                                    fontSize: 16,
                                  )),
                            ],
                          ),
                          // Textwidget(
                          //   text: "per project + fees",
                          //   fontSize: 14,
                          //   color: AppStyles.BlacklightTextcolor,
                          // ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: Textwidget(
                                    text: "Platform Fee (${controller.platformFee.value}%)",
                                    fontSize: 14,
                                  )),
                              Flexible(
                                  child: Textwidget(
                                    text: "\$${controller.totalPlatformFee.value}",
                                    fontSize: 14,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: Textwidget(
                                    text: "Total price",
                                    fontSize: 14,
                                  )),
                              Flexible(
                                  child: Textwidget(
                                    text: "\$${controller.totalPrice.value}",
                                    fontSize: 14,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),),
      bottomNavigationBar: Obx(()=> Visibility(
        visible:           controller.isLoading.isFalse,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              Expanded(
                  child: MyButton(
                text: "Aceept Bid",
                onPressed: () {

                  controller.acceptRejectBidRequestApi("1");
                  // Get.toNamed(Routes.BOOKING_SUMMARY);
                },
                color: AppStyles.appThemeColor,
                TextColor: AppStyles.backgroundColor,
              )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: MyButton(
                text: "Reject Bid",
                onPressed: () {

                  controller.acceptRejectBidRequestApi("2");
                },
                color: AppStyles.GraylightTextColor,
                TextColor: AppStyles.backgroundColor,
              ))
            ],
          ),
        ),
      ),
      ));
  }
}
