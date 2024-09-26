import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/cached_netword_image.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/modules/HomeScreen/controllers/home_screen_controller.dart';
import 'package:power_maids/app/modules/HomeScreen/dynamic_list.dart';
import 'package:power_maids/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreenView extends GetView<HomeScreenController> {
  const HomeScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          backgroundColor: AppStyles.backgroundColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: IconButton(
                  padding: const EdgeInsets.only(left: 10),
                  onPressed: () {},
                  icon: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/icons/locationIcon.png", height: 25),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Textwidget(
                                text: controller.address.value,
                                fontSize: 15,
                                maxLines: 2,
                                // overflow: TextOverflow.ellipsis, // Handle overflow
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Get.toNamed(Routes.MAKE_ACCOUNT_WITH_SCREEN,
                          arguments: false);
                    },
                    icon:
                        Image.asset("assets/icons/SearchIcon.png", height: 23),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      var data = {
                        'address': controller.address.value,
                        'latitude': controller.lat.value,
                        'longitude': controller.lng.value,
                      };
                      Get.toNamed(Routes.LOCATION_SCREEN, parameters: data);
                    },
                    icon: Image.asset("assets/icons/Iconone.png", height: 23),
                  ),
                  // Uncomment this block if needed
                  // IconButton(
                  //   padding: EdgeInsets.zero,
                  //   onPressed: () {
                  //     // Get.toNamed(Routes.CLEANER_BIDS_LIST);
                  //   },
                  //   icon: Image.asset("assets/icons/HealthIcons.png", height: 23),
                  // ),
                ],
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Obx(
          () => SmartRefresher(
            enablePullDown: true,
            footer: const ClassicFooter(
              loadStyle: LoadStyle.HideAlways,
              completeDuration: Duration(milliseconds: 500),
            ),
            header: WaterDropMaterialHeader(
                backgroundColor: AppStyles.appThemeColor,
                color: Colors
                    .white), // Customize the refresh indicator (you can use other built-in or custom indicators)
            controller: controller.refreshController,
            enablePullUp: true,
            onRefresh: () async {
              await controller.refrshApi();
              await Future.delayed(const Duration(milliseconds: 1000));
              if (true) controller.refreshController.refreshCompleted();
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.isLoading.isTrue
                      ? Shimmer.fromColors(
                          baseColor: AppStyles.appThemeColor.withOpacity(0.4),
                          highlightColor:
                              AppStyles.appThemeColor.withOpacity(0.8),
                          enabled: true,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  color: AppStyles.appThemeColor,
                                  child: Textwidget(
                                    text: controller.greeting.value,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  color: AppStyles.appThemeColor,
                                  child: Textwidget(
                                    text:
                                        "Hi ${controller.firstname.value + " " + controller.lastname.value}",
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  color: AppStyles.appThemeColor,
                                  child: Textwidget(
                                    text: "What are you looking for?",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Textwidget(
                                text: controller.greeting.value,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                              Textwidget(
                                text:
                                    "Hi ${controller.firstname.value + " " + controller.lastname.value}",
                                fontSize: 15,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Textwidget(
                                text: "What are you looking for?",
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),

                WhatareyouLokingListView(
                  height: 200,
                  serviceList: controller.serviceList,
                  imageheight: 200,
                  imagewidth: 200,
                  isLoading: controller.isLoading.value,
                ),

                controller.isLoading.isTrue
                    ? Shimmer.fromColors(
                  baseColor: AppStyles.appThemeColor.withOpacity(0.4),
                  highlightColor:
                  AppStyles.appThemeColor.withOpacity(0.8),
                  enabled: true,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Container(
                      width: Get.width,
                      color: AppStyles.appThemeColor,
                      child: Textwidget(
                        text: "Near by Cleaner and Co-host",
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
                    : Visibility(

                  visible: controller.nearByMaid.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Textwidget(
                      text: "Near by Cleaner and Co-host",
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                Visibility(
                  visible: controller.nearByMaid.isNotEmpty,

                  child: NearByMaidListView(
                    height: 170,
                    nearBylist: controller.nearByMaid,

                    circulavtarheight: 80,
                    isLoading: controller.isLoading.value,
                  ),
                ),

                controller.isLoading.isTrue
                    ? Shimmer.fromColors(
                  baseColor: AppStyles.appThemeColor.withOpacity(0.4),
                  highlightColor:
                  AppStyles.appThemeColor.withOpacity(0.8),
                  enabled: true,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Container(
                      width: Get.width,
                      color: AppStyles.appThemeColor,
                      child: Textwidget(
                        text: "Near by Cleaner and Co-host",
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
                    : Padding(
                  padding: const EdgeInsets.only(left: 15, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Textwidget(
                        text: "Recommended",
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                      IconButton(
                          hoverColor: AppStyles.appThemelightColor,
                          onPressed: () {
                            Get.toNamed(Routes.RECOMMENDED_VIEW_ALL);
                          },
                          icon: Textwidget(
                            text: "View All",
                          ))
                    ],
                  ),
                ),
                controller.isLoading.isTrue
                    ? Shimmer.fromColors(
                    baseColor: AppStyles.appThemeColor.withOpacity(0.4),
                    highlightColor:
                    AppStyles.appThemeColor.withOpacity(0.8),
                    enabled: true,
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 5,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (buildContext, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5,
                                      right: 5,
                                      top: 5,
                                      bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 80,
                                              width: 85,
                                              decoration: BoxDecoration(
                                                color: AppStyles
                                                    .appThemeColor,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10),
                                              ),
                                              child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(10),
                                                  child: Image.asset("")),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Container(
                                                    color: AppStyles
                                                        .appThemeColor,
                                                    child: Textwidget(
                                                      text:
                                                      "               ",
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      RatingBar.builder(
                                                        ignoreGestures:
                                                        true,
                                                        itemSize: 13,
                                                        initialRating:
                                                        1.1,
                                                        minRating: 1,
                                                        direction: Axis
                                                            .horizontal,
                                                        allowHalfRating:
                                                        true,
                                                        itemCount: 5,
                                                        itemPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            0.0),
                                                        itemBuilder:
                                                            (context,
                                                            _) =>
                                                            Icon(
                                                              Icons.star,
                                                              color: AppStyles
                                                                  .StarIconColor,
                                                            ),
                                                        onRatingUpdate:
                                                            (rating) {},
                                                      ),
                                                      const SizedBox(
                                                        width: 3,
                                                      ),
                                                      Textwidget(
                                                        text: ("     "),
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    color: AppStyles
                                                        .appThemeColor,
                                                    child: Row(
                                                      children: [
                                                        Textwidget(
                                                          text:
                                                          "                      ",
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  // Textwidget(
                                                  //   text: "\$${maidPricehorly}Hr",
                                                  //   fontWeight: FontWeight.w700,
                                                  // )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            // controller.Faviourite_Unfaviourite(recommended_list.id.toString());
                                          },
                                          icon: Container(
                                              color:
                                              AppStyles.appThemeColor,
                                              child: Image.asset(
                                                'assets/icons/unlike.png',
                                                height: 20,
                                              ))),
                                    ],
                                  ),
                                ),
                              );
                            })))
                    : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.recommendedList.length > 4
                        ? 3
                        : controller.recommendedList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (buildContext, index) {
                      var recommendedList =
                      controller.recommendedList[index];
                      final itemName = 'Item $index';

                      return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: InkWell(
                            onTap: () {
                              // role 1-cleaner, 2-cohost

                              String id =
                              recommendedList.role == 1 ? "0" : "1";
                              String title = recommendedList.role == 1
                                  ? "Cleaner"
                                  : "Co-Host";

                              var data = {
                                "id": id,
                                "title": title,
                                "cleaner_cohost_id":
                                recommendedList.id.toString(),
                                "user_type":
                                recommendedList.role.toString(),
                              };
                              Get.toNamed(Routes.MAID_DETAILS,
                                  parameters: data, arguments: false);
                            },
                            child:  Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.zero,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppStyles.backgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 80,
                                              width: 85,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: LoadingImage(
                                                  fit: BoxFit.fill,
                                                  image: recommendedList.avatar.toString(),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Textwidget(
                                                    text: recommendedList.cleanerName,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15,
                                                  ),
                                                  Row(
                                                    children: [
                                                      RatingBar.builder(
                                                        ignoreGestures: true,
                                                        itemSize: 13,
                                                        initialRating: double.parse(recommendedList.rating.toString()),
                                                        minRating: 1,
                                                        direction: Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                                                        itemBuilder: (context, _) => Icon(
                                                          Icons.star,
                                                          color: AppStyles.StarIconColor,
                                                        ),
                                                        onRatingUpdate: (rating) {},
                                                      ),
                                                      const SizedBox(width: 3),
                                                      Textwidget(
                                                        text: ("${recommendedList.review} Review"),
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ],
                                                  ),
                                                  Visibility(
                                                    visible: recommendedList.address2.isNotEmpty,
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Image.asset(
                                                          "assets/icons/locationIcon1.png",
                                                          height: 18,
                                                        ),
                                                        const SizedBox(width: 3),
                                                        Flexible(
                                                          child: Textwidget(
                                                            maxLines: 2,
                                                            text: recommendedList.address2,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Textwidget(
                                                  //   text: "\$${maidPricehorly}Hr",
                                                  //   fontWeight: FontWeight.w700,
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Obx(
                                            () => IconButton(
                                          onPressed: () => controller.toggleFavorite(recommendedList.id.toString()),
                                          icon: Image.asset(
                                            controller.isFavorite[recommendedList.id.toString()] == true ? 'assets/icons/likeed.png' : 'assets/icons/unlike.png',
                                            height: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                    })
                ],
              ),
            ),
          ),
        ));
  }
}
