import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/cached_netword_image.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/app/modules/RecommendedViewAll/controllers/recommended_view_all_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';

class RecommendedViewAllView extends GetView<RecommendedViewAllController> {
  const RecommendedViewAllView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 5,
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: AppStyles.backgroundColor,
          title: AppbarWithBackButton(
            text: 'Recommended',
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: false,
        ),
        body: Obx(() => Stack(
              children: [
                controller.isLoading.isTrue
                    ? ShowLoader.isLoadingProgress(controller.isLoading.value)
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.recommendedList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (buildContext, index) {
                                  var recommendedList =
                                      controller.recommendedList[index];
                                  final itemName = 'Item $index';

                                  return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 5,
                                          bottom: 5),
                                      child: InkWell(
                                        onTap: () {
                                          // role 1-cleaner, 2-cohost

                                          String id = recommendedList.role == 1
                                              ? "0"
                                              : "1";
                                          String title =
                                              recommendedList.role == 1
                                                  ? "Cleaner"
                                                  : "Co-Host";

                                          var data = {
                                            "id": id,
                                            "title": title,
                                            "cleaner_cohost_id": recommendedList.id.toString(),
                                            "user_type": recommendedList.role.toString(),
                                          };

                                          Get.toNamed(Routes.MAID_DETAILS,
                                              parameters: data,
                                              arguments: false);
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          margin: EdgeInsets.zero,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color:
                                                    AppStyles.backgroundColor,
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 80,
                                                          width: 85,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: LoadingImage(
                                                                fit:
                                                                    BoxFit.fill,
                                                                image: recommendedList
                                                                    .avatar
                                                                    .toString()),
                                                          ),
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
                                                              Textwidget(
                                                                text: recommendedList
                                                                    .cleanerName,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 15,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  RatingBar
                                                                      .builder(
                                                                    ignoreGestures:
                                                                        true,
                                                                    itemSize:
                                                                        13,
                                                                    initialRating:
                                                                        double.parse(recommendedList
                                                                            .rating
                                                                            .toString()),
                                                                    minRating:
                                                                        1,
                                                                    direction: Axis
                                                                        .horizontal,
                                                                    allowHalfRating:
                                                                        true,
                                                                    itemCount:
                                                                        5,
                                                                    itemPadding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            0.0),
                                                                    itemBuilder:
                                                                        (context,
                                                                                _) =>
                                                                            Icon(
                                                                      Icons
                                                                          .star,
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
                                                                    text:
                                                                        ("${recommendedList.review} Review"),
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  )
                                                                ],
                                                              ),
                                                              Visibility(
                                                                visible:
                                                                    recommendedList
                                                                        .address
                                                                        .isNotEmpty,
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Image.asset(
                                                                      "assets/icons/locationIcon1.png",
                                                                      height:
                                                                          18,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 3,
                                                                    ),
                                                                    Flexible(
                                                                      child:
                                                                          Textwidget(
                                                                        maxLines:
                                                                            2,
                                                                        text: recommendedList
                                                                            .address,
                                                                      ),
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
                                                  Obx(
                                                    () => IconButton(
                                                      onPressed: () => controller
                                                          .toggleFavorite(
                                                              recommendedList.id
                                                                  .toString()),
                                                      icon: Image.asset(
                                                        controller.isFavorite[
                                                                    recommendedList
                                                                        .id
                                                                        .toString()] ==
                                                                true
                                                            ? 'assets/icons/likeed.png'
                                                            : 'assets/icons/unlike.png',
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
              ],
            )));
  }
}
