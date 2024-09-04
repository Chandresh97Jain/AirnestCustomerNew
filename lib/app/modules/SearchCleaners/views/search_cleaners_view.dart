import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/cached_netword_image.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/textformfield_ui_global.dart';
import 'package:power_maids/app/modules/SearchCleaners/controllers/search_cleaners_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';

class SearchCleanersView extends GetView<SearchCleanersController> {
  const SearchCleanersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppStyles.backgroundColor,
        title: AppbarWithBackButton(
          text: 'Search Cleners/Co-host',
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: false,
      ),
      body: Obx(()=> Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: TextFieldDesignedOutline(

              onChanged: (value) async{
                controller.searchTextController.clear();

                 controller.searchTextController.text = value;
               await controller.fetchSearchCleanerApi();

                },
              controller: controller.searchTextController,
              prefixIcon: Image.asset(
                "assets/icons/SearchIcon.png",
                scale: 3.5,
              ),
              hintText: "Search nearby cleaners or co-hosts",
              keyboardType: TextInputType.text,
            ),
          ),

          controller.isLoadingSearch.isFalse?


          Expanded(
            child: Visibility(
              visible: controller.searchCleanerList.isNotEmpty,
              replacement: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/hand-wash-svgrepo-com 1.png",
                        scale: 5,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Textwidget(
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        text: "No Cleaners/Co-host found",
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      )
                    ],
                  ),),
              child: ListView.builder(

                  shrinkWrap: true,
                  itemCount: controller.searchCleanerList.length,
                 // physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (buildContext, index) {
                    var searchCleanerList =
                    controller.searchCleanerList[index];
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

                            String id = searchCleanerList.role == 1
                                ? "0"
                                : "1";
                            String title =
                            searchCleanerList.role == 1
                                ? "Cleaner"
                                : "Co-Host";

                            var data = {
                              "id": id,
                              "title": title,
                              "cleaner_cohost_id":
                              searchCleanerList.id.toString(),
                              "user_type":
                              searchCleanerList.role.toString(),
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
                                                  image: searchCleanerList
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
                                                  text: searchCleanerList
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
                                                      double.parse(searchCleanerList
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
                                                      ("${searchCleanerList.review} Review"),
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
                                                  searchCleanerList
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
                                                          text: searchCleanerList
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
                                            searchCleanerList.id
                                                .toString()),
                                        icon: Image.asset(
                                          controller.isFavorite[
                                          searchCleanerList
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
                  }),
            ),
          ): Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              ShowLoader.isLoadingProgress(controller.isLoadingSearch.value)
            ],),
          )

        ],
      ),
      ));
  }
}
