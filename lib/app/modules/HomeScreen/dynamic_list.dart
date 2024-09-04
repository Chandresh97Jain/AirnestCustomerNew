import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/cached_netword_image.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/modules/CreateBidForCleanerAndCohost/model/service_list_model.dart';
import 'package:power_maids/app/modules/HomeScreen/controllers/home_screen_controller.dart';
import 'package:power_maids/app/modules/HomeScreen/home_models.dart';
import 'package:power_maids/app/routes/app_pages.dart';
import 'package:shimmer/shimmer.dart';

class WhatareyouLokingListView extends StatelessWidget {
  final RxList<ServicesListModel> serviceList;
  final double height;
  final double imageheight;
  final double imagewidth;
  final bool isLoading;

  const WhatareyouLokingListView({
    super.key,
    required this.height,
    required this.imageheight,
    required this.imagewidth,
    required this.serviceList,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenController());
    final controller = HomeScreenController();
    return SizedBox(
      height: height,
      child: isLoading == true
          ? Shimmer.fromColors(
              baseColor: AppStyles.appThemeColor.withOpacity(0.3),
              highlightColor: AppStyles.appThemeColor,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                padding: const EdgeInsets.only(left: 10, right: 10),
                itemBuilder: (BuildContext context, int index) {
                  // var servise = service_list[index];

                  // print("service_list --  --  - ${servise.icon}");
                  return Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      height: imageheight,
                      width: imagewidth,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(
                        fit: StackFit.loose,
                        alignment: Alignment.bottomLeft,
                        children: [
                          SizedBox(
                              height: imageheight,
                              width: imagewidth,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ShaderMask(
                                    blendMode: BlendMode
                                        .srcATop, // Choose a blend mode that suits your needs
                                    shaderCallback: (Rect bounds) {
                                      return LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          AppStyles.grediantblackcolor,
                                        ], // Specify your gradient colors
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ).createShader(bounds);
                                    },
                                    child: Image.asset('')),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Textwidget(
                              text: "   ",
                              color: AppStyles.backgroundColor,
                              maxLines: 50,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : Obx(() => ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: serviceList.length,
        padding: const EdgeInsets.only(left: 10, right: 10),
        itemBuilder: (BuildContext context, int index) {
          var servise = serviceList[index];

          print("service_list --  --  - ${servise.icon}");

          return Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: SizedBox(
              height: imageheight,
              width: imagewidth,
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.bottomLeft,
                children: [
                  SizedBox(
                      height: imageheight,
                      width: imagewidth,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ShaderMask(
                            blendMode: BlendMode
                                .srcATop, // Choose a blend mode that suits your needs
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  AppStyles.grediantblackcolor,
                                ], // Specify your gradient colors
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ).createShader(bounds);
                            },
                            child: LoadingImage(
                                image: servise.icon, fit: BoxFit.fill)),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Textwidget(
                      text: servise.title,
                      color: AppStyles.backgroundColor,
                      maxLines: 50,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),)
    );
  }
}

class NearByMaidListView extends StatelessWidget {
  final double height;
  final double circulavtarheight;
  final bool isLoading;
  final RxList<NearByListModel> nearBylist;

  const NearByMaidListView(
      {super.key,
      required this.height,
      required this.circulavtarheight,
      required this.isLoading,
      required this.nearBylist});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: isLoading == true
          ? Shimmer.fromColors(
              baseColor: AppStyles.appThemeColor.withOpacity(0.4),
              highlightColor: AppStyles.appThemeColor.withOpacity(0.8),
              enabled: true,
              child: SizedBox(
                height: 40,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        itemBuilder: (BuildContext context, int index) {
                          // var nearby = nearBylist[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Container(
                                  height: circulavtarheight,
                                  width: circulavtarheight,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(

                                        color: AppStyles.appThemeColor,
                                      )),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Flexible(
                                  child: Container(
                                    color: AppStyles.appThemeColor,
                                    child: SizedBox(
                                      width: 100,
                                      child: Textwidget(
                                        maxLines: 2,
                                        text: "",
                                        fontSize: 12,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Flexible(
                                  child: Container(
                                    height: 15,
                                    color: AppStyles.appThemeColor,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: AppStyles.StarIconColor,
                                          size: 15,
                                        ),
                                        Textwidget(text: '   ')
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ))
          : ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: nearBylist.length,
              padding: const EdgeInsets.only(left: 10, right: 10),
              itemBuilder: (BuildContext context, int index) {
                var nearby = nearBylist[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: InkWell(
                    onTap: () {
                      
                      // role 1-cleaner, 2-cohost

                      String id = nearby.role == 1 ? "0" : "1";
                      String title = nearby.role == 1 ? "Cleaner" : "Co-Host";

                      var data = {
                        "id": id,
                        "title": title,
                        "cleaner_cohost_id": nearby.id.toString(),
                        "user_type": nearby.role.toString(),
                      };

                      Get.toNamed(Routes.MAID_DETAILS,
                          parameters: data, arguments: false);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: circulavtarheight,
                          width: circulavtarheight,
                          decoration:
                                BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppStyles.appThemeColor)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: LoadingImage(
                                image: nearby.avatar,
                                fit: BoxFit.fill,
                              )),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Flexible(
                          child: SizedBox(
                            width: 100,
                            child: Textwidget(
                              maxLines: 2,
                              text: nearby.cleanerName,
                              fontSize: 12,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: AppStyles.StarIconColor,
                                size: 15,
                              ),
                              Textwidget(text: nearby.rating.toString())
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class RecommendedListView extends StatelessWidget {
  final List items;
  final List title;
  final double height;
  final double imageheight;
  final double imagewidth;

  RecommendedListView({
    required this.height,
    required this.imageheight,
    required this.imagewidth,
    required this.items,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,

      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: const EdgeInsets.only(left: 10, right: 10),
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: Row(
            children: [
              Container(


                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
              ),
              Column(
                children: [
                  Textwidget(
                    text: "tittle",
                  ),
                  // Row(children: [
                  //
                  // ],)
                ],
              )
            ],
          ));
        },
      ),
    );
  }
}

class RecommendedList extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? favoriteonPressed;
  final String? maidName;
  final double? initialRating;
  final String? tottalreview;
  final String? location;
  final String? maidImage;
  final String? maidPricehorly;
  final String? favoriteiconImage;

  const RecommendedList(
      {Key? key,
      this.onPressed,
      this.maidName,
      this.initialRating,
      this.tottalreview,
      this.location,
      this.maidImage,
      this.maidPricehorly,
      this.favoriteonPressed,
      this.favoriteiconImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
              color: AppStyles.backgroundColor,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                              fit: BoxFit.fill, image: maidImage.toString()),
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
                              text: maidName.toString(),
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                            Row(
                              children: [
                                RatingBar.builder(
                                  ignoreGestures: true,
                                  itemSize: 13,
                                  initialRating: initialRating!.toDouble(),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 0.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: AppStyles.StarIconColor,
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Textwidget(
                                  text: tottalreview,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                )
                              ],
                            ),
                            Row(
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
                                    text: location,
                                  ),
                                )
                              ],
                            ),
                            Textwidget(
                              text: "\$${maidPricehorly}Hr",
                              fontWeight: FontWeight.w700,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                IconButton(
                    onPressed: favoriteonPressed,
                    icon: Image.asset(
                      favoriteiconImage.toString(),
                      height: 20,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
