import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/cached_netword_image.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/nodata_image.dart';
import 'package:power_maids/app/modules/MyFavourite/controllers/my_favourite_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';


class MyFavouriteView extends GetView<MyFavouriteController> {
  const MyFavouriteView({Key? key}) : super(key: key);
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
            text: 'Favourite',
            onPressed: () {
              Get.back();

            },
          ),
          centerTitle: false,
        ),
        body: Obx(() =>  Stack(
          children: [
            controller.isLoading.isTrue
            ?ShowLoader.isLoadingProgress(controller.isLoading.value)
            :controller.favList.isEmpty
            ?Column(
              children: [
                NoDataFound(height: MediaQuery.of(context).size.height/1.5,),
              ],
            )
            :Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.favList.length,
                      itemBuilder: (buildContext, index) {
                        var favourite = controller.favList[index];

                        var recommendedList = controller.favList[index];

                        return InkWell(
                          onTap: () {

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



                           // Get.toNamed(Routes.MAID_DETAILS);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 0, bottom: 0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 85,
                                            width: 85,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: AppStyles.appThemeColor),
                                              borderRadius:
                                              BorderRadius.circular(50),
                                            ),
                                            child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(50),
                                                child: LoadingImage(image: favourite.avatar, fit: BoxFit.fill)
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Textwidget(
                                                  text: favourite.cleanerName,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15,
                                                ),
                                                Row(
                                                  children: [
                                                    RatingBar.builder(
                                                      ignoreGestures: true,
                                                      itemSize: 13,
                                                      initialRating: double.parse(favourite.rating.toString()),
                                                      minRating: 1,
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemPadding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 0.0),
                                                      itemBuilder: (context, _) =>
                                                          Icon(
                                                            Icons.star,
                                                            color:
                                                            AppStyles.StarIconColor,
                                                          ),
                                                      onRatingUpdate: (rating) {},
                                                    ),
                                                    const SizedBox(
                                                      width: 3,
                                                    ),
                                                    Flexible(
                                                      child: Textwidget(
                                                        text: "(${favourite.review} Review)",
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      "assets/icons/locationIcon1.png",
                                                      height: 18,
                                                    ),
                                                    const SizedBox(
                                                      width: 3,
                                                    ),
                                                    Flexible(
                                                      child: Textwidget(
                                                        maxLines: 2,
                                                        text: favourite.address,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
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

                                        // IconButton(
                                        //     onPressed: () {
                                        //       controller.faviouriteUnfaviourite(favourite.id.toString());
                                        //     },
                                        //     icon: CircleAvatar(
                                        //       backgroundColor:
                                        //       AppStyles.appThemealtralightColor,
                                        //       child: Image.asset(
                                        //         "assets/icons/likeed.png",
                                        //         height: 18,
                                        //       ),
                                        //     )),
                                        // Textwidget(
                                        //   text: "\$15.00Hr",
                                        //   fontWeight: FontWeight.w700,
                                        // )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  height: 0,
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ],
        ))
    );
  }
}
