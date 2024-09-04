import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:power_maids/Utils/cached_netword_image.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/modules/LocationScreen/controllers/location_screen_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';

class LocationScreenView extends GetView<LocationScreenController> {
  const LocationScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 1,
          backgroundColor: AppStyles.backgroundColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: IconButton(
                  padding: const EdgeInsets.only(left: 0),
                  onPressed: () {},
                  icon: Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Get.back();
                        },
                        icon: Card(
                            margin: EdgeInsets.zero,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppStyles.backgroundColor),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(Icons.arrow_back),
                              ),
                            )),
                      ),
                      // Image.asset("assets/icons/locationIcon.png", height: 25),
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
                        Get.toNamed(Routes.SEARCH_CLEANERS);
                      },
                      icon: Image.asset(
                        "assets/icons/SearchIcon.png",
                        height: 23,
                      )),
                  // IconButton(
                  //     padding: EdgeInsets.zero,
                  //     onPressed: () {
                  //       Get.toNamed(Routes.FILTER_SCREEN);
                  //     },
                  //     icon: Image.asset(
                  //       "assets/icons/filtericon.png",
                  //       height: 23,
                  //     )),
                  // IconButton(
                  //     padding: EdgeInsets.zero,
                  //     onPressed: () {
                  //       Get.toNamed(Routes.CLEANER_BIDS_LIST);
                  //     },
                  //     icon: Image.asset(
                  //       "assets/icons/HealthIcons.png",
                  //       height: 23,
                  //     )),
                ],
              )
            ],
          ),
          centerTitle: true,
        ),
        body: Obx(
          () => Stack(
            children: [
              controller.currentLocation == null
                  ? const Center(child: CircularProgressIndicator())
                  : GoogleMap(
                      onMapCreated: controller.onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: controller.currentLocation.value ??
                            controller.initialCameraPosition,
                        zoom: 15.0,
                      ),
                      markers: controller.markers.toSet(),
                      myLocationEnabled: true,
                    ),
              Positioned(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: controller.isLoading.isTrue
                      ? const SizedBox()
                      : SizedBox(
                          height: 120,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.nearByMaid.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (buildContext, index) {
                              var nearMaids = controller.nearByMaid[index];
                              final itemName = 'Item $index';

                              bool fav;
                              if (nearMaids.isFavorite == 0) {
                                fav = false;
                              } else {
                                fav = true;
                              }

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: InkWell(
                                  onTap: () {
                                    // role 1-cleaner, 2-cohost
                                    String id = nearMaids.role == 1 ? "0" : "1";
                                    String title = nearMaids.role == 1
                                        ? "Cleaner"
                                        : "Co-Host";

                                    var data = {
                                      "id": id,
                                      "title": title,
                                      "cleaner_cohost_id":
                                          nearMaids.id.toString(),
                                      "user_type": nearMaids.role.toString(),
                                    };
                                    Get.toNamed(Routes.MAID_DETAILS,
                                        parameters: data, arguments: false);
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.zero,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8, // Set a fixed width or relative to screen width
                                      decoration: BoxDecoration(
                                        color: AppStyles.backgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 80,
                                              width: 85,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: LoadingImage(
                                                  fit: BoxFit.fill,
                                                  image: nearMaids.avatar
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Textwidget(
                                                    text: nearMaids.cleanerName,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15,
                                                  ),
                                                  Row(
                                                    children: [
                                                      RatingBar.builder(
                                                        ignoreGestures: true,
                                                        itemSize: 13,
                                                        initialRating: double
                                                            .parse(nearMaids
                                                                .rating
                                                                .toString()),
                                                        minRating: 1,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    0.0),
                                                        itemBuilder:
                                                            (context, _) =>
                                                                Icon(
                                                          Icons.star,
                                                          color: AppStyles
                                                              .StarIconColor,
                                                        ),
                                                        onRatingUpdate:
                                                            (rating) {},
                                                      ),
                                                      const SizedBox(width: 3),
                                                      Textwidget(
                                                        text:
                                                            "${nearMaids.review} Review",
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/icons/locationIcon1.png",
                                                        height: 18,
                                                      ),
                                                      const SizedBox(width: 3),
                                                      Expanded(
                                                        child: Textwidget(
                                                          text:
                                                              nearMaids.address,
                                                          // overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Obx(
                                              () => IconButton(
                                                onPressed: () => controller
                                                    .toggleFavorite(controller
                                                        .nearByMaid[index].id
                                                        .toString()),
                                                icon: Image.asset(
                                                  controller.isFavorite[
                                                              controller
                                                                  .nearByMaid[
                                                                      index]
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
                                ),
                              );
                            },
                          ),
                        ),
                ),
              )

              // controller.currentLocation.value == null
              // ?SizedBox()
              // :Positioned(
              //   top : 100,
              //   child: Align(
              //     alignment: Alignment.center,
              //     child: ShowLoader.isLoadingProgress(controller.isLoading.value),
              //   ),
              // )
            ],
          ),
        ));
  }
}
