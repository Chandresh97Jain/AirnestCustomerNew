import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/cached_netword_image.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/nodata_image.dart';
import 'package:power_maids/app/modules/MaidDetails/controllers/maid_details_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';
import 'About_maid.dart';
import 'review_maid.dart';

class MaidDetailsView extends GetView<MaidDetailsController> {
  const MaidDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaidDetailsController controllerDetail = Get.put(MaidDetailsController());
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Obx(
              () => controllerDetail.isLoading.isTrue
                  ? ShowLoader.isLoadingProgress(
                  controllerDetail.isLoading.value)
                  : NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                      sliver: SliverAppBar(
                        automaticallyImplyLeading: false,
                        // backgroundColor: Colors.white,
                        titleSpacing: 0,
                        surfaceTintColor: AppStyles.backgroundColor,
                        leadingWidth: MediaQuery.of(context).size.width,
                        leading: Padding(
                          padding: const EdgeInsets.only(
                              top:20, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                surfaceTintColor: AppStyles.backgroundColor,
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(Icons.arrow_back),
                                ),
                              ),
                            ],
                          ),
                        ),
                        pinned: true,
                        floating: true,
                        stretch: false,
                        snap: true,
                        expandedHeight: 360.0,
                        bottom: TabBar(
                          indicatorColor: AppStyles.appThemeColor,
                          labelColor: AppStyles.appThemeColor,
                          tabs: [
                            Textwidget(
                              textscalefector: 1,
                              text: "About",
                            ),
                            Textwidget(
                              textscalefector: 1,
                              text: "Services",
                            ),
                            Textwidget(
                              textscalefector: 1,
                              text: "Contact",
                            ),
                            Textwidget(
                              textscalefector: 1,
                              text: "Review",
                            ),
                          ],
                        ),
                        flexibleSpace: Scaffold(
                          body: FlexibleSpaceBar(
                            background: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Container(
                                  color: Colors.white,
                                  width:
                                  MediaQuery.of(context).size.width,
                                  height: 600,
                                  child: Column(
                                    children: [
                                      Stack(
                                        alignment: Alignment.bottomLeft,
                                        children: [
                                          SizedBox(
                                              width: MediaQuery.of(context).size.width,
                                              height: 220,
                                              child: CachedNetworkImage(
                                                placeholder: (context, url) => LinearProgressIndicator(
                                                  // value: controller.value,
                                                  semanticsLabel: 'Linear progress indicator',
                                                  color: AppStyles.appThemeColor.withOpacity(0.8),
                                                  backgroundColor:AppStyles.appThemeColor.withOpacity(0.4),
                                                ),
                                                imageUrl: ApiService.imageURL + controller.bgImage.toString(),
                                                fit: BoxFit.fitWidth,
                                                errorWidget: (context, url, error) => const SizedBox(),
                                              )
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 60, left: 15, right: 15),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 110,
                                                width: 110,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(width: 2, color: AppStyles.appThemeColor)),
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(50),
                                                    child: LoadingImage(
                                                      image: controllerDetail.profileImage.value,
                                                      fit: BoxFit.cover,
                                                    )),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 20, left: 15),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Textwidget(
                                                      text: controllerDetail.cleanerCoHostName.value,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        RatingBar.builder(
                                                          ignoreGestures:
                                                          true,
                                                          itemSize: 13,
                                                          initialRating:
                                                          1,
                                                          // initialRating: ,
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
                                                          const Icon(
                                                            Icons.star,
                                                            color: Colors
                                                                .amber,
                                                          ),
                                                          onRatingUpdate:
                                                              (rating) {},
                                                        ),
                                                        const SizedBox(
                                                          width: 3,
                                                        ),
                                                        Textwidget(
                                                          text: "(${controllerDetail.basicDetails['review']} Review)",
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ],
                                                    ),
                                                    Visibility(
                                                        visible: controllerDetail.id.value == "0",
                                                        child: Row(
                                                          children: [
                                                            Image.asset(
                                                              "assets/icons/insurance.png",
                                                              scale: 25,
                                                            ),
                                                            const SizedBox(
                                                              width: 3,
                                                            ),
                                                            Textwidget(
                                                              text:
                                                              "Verified",
                                                              color: AppStyles
                                                                  .GrayTextColor,
                                                              fontSize:
                                                              11,
                                                            )
                                                          ],
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              var data = {
                                                'remote_firebase_id': controllerDetail.basicDetails['firebase_id'].toString(),
                                                'remote_user_id': controllerDetail.basicDetails['id'].toString(),
                                                'other_user_name': "${controllerDetail.basicDetails['firstname']} ${controllerDetail.basicDetails['lastname']}",
                                              };
                                              Get.toNamed(Routes.CHAT_SCREEN, parameters: data);
                                            },
                                            icon: Container(
                                              decoration: BoxDecoration(shape: BoxShape.circle, color: AppStyles.appThemeColor),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Center(
                                                    child: Image.asset(
                                                      "assets/icons/chat-dots.png",
                                                      height: 30,
                                                    )),
                                              ),
                                            ),
                                          )
                                          // IconButton(
                                          //     onPressed: () {
                                          //       Share.share('Check out this');
                                          //     },
                                          //     icon: Image.asset(
                                          //       "assets/icons/refer.png",
                                          //       scale: 20,
                                          //     )
                                          // )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Obx(() => controllerDetail.id.value == "1"
                                          ? Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/icons/badge_certificate.png",
                                                  scale: 5,
                                                ),
                                                Flexible(
                                                    child:
                                                    Textwidget(
                                                      text:
                                                      "Certified Host",
                                                      fontWeight:
                                                      FontWeight
                                                          .w700,
                                                    ))
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .end,
                                              children: [
                                                Image.asset(
                                                  "assets/icons/Frame .png",
                                                  scale: 5,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Flexible(
                                                    child:
                                                    Textwidget(
                                                      text:
                                                      "95% Job Success",
                                                      fontWeight:
                                                      FontWeight
                                                          .w700,
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                          : Textwidget(
                                        textAlign: TextAlign.center,
                                        maxLines: 5,
                                        text: "Book a maid of your choice according to your needs!",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            centerTitle: true,

                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: SafeArea(
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 80),
                            child: AboutScreen(
                              about: controllerDetail.about.value,
                              photoList: controllerDetail.photoList.value,
                              website: controllerDetail.basicDetails['website'] ?? "",
                              business: controllerDetail.basicDetails['business_name'] ?? "",
                            ),
                          ),
                        ),
                        SingleChildScrollView(child: Padding(padding:
                            const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 80,
                                  ),
                                  if (controllerDetail.serviceList.isEmpty)
                                    NoDataFound(height: MediaQuery.of(context).size.height / 4)
                                  else
                                    Textwidget(
                                      text: "Services",
                                      fontWeight: FontWeight.w700,
                                    ),

                                  if (controllerDetail.isSelectService.value == true)
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // services
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: controllerDetail.serviceIdArray.length,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (buildContext, index) {
                                              var serviceList = controllerDetail.serviceIdArray[index];
                                              var serviceName = controllerDetail.serviceNameArray[index];

                                              log("serviceList name   -----😱  $serviceList");

                                              Color boxBorderColor;

                                              if (controllerDetail.serviceId.value == serviceList.toString()) {
                                                boxBorderColor = AppStyles.appThemeColor;
                                              } else {
                                                boxBorderColor = AppStyles.grediantblacklightcolor;
                                              }

                                              if (serviceList == 1 || serviceList == 2 || serviceList == 4) {
                                                if (serviceList == 1) {
                                                  return Container(
                                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      // color:box_color,
                                                        border: Border.all(color: boxBorderColor),
                                                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                                                    child: ExpansionTile(
                                                      onExpansionChanged:
                                                          (bool expanded) {},
                                                      expandedAlignment:
                                                      Alignment.topLeft,
                                                      tilePadding:
                                                      EdgeInsets.zero,
                                                      title: Textwidget(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        text: serviceName,
                                                      ),
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            controllerDetail
                                                                .standardArray1
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : Textwidget(
                                                              text:
                                                              "Standard",
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700,
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            controllerDetail
                                                                .standardArray1
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : ListView
                                                                .builder(
                                                                itemCount: controllerDetail
                                                                    .standardArray1
                                                                    .length,
                                                                shrinkWrap:
                                                                true,
                                                                physics:
                                                                const NeverScrollableScrollPhysics(),
                                                                itemBuilder:
                                                                    (buildContext,
                                                                    index2) {
                                                                  var standardList =
                                                                  controllerDetail.standardArray1[index2];
                                                                  return Padding(
                                                                    padding:
                                                                    const EdgeInsets.symmetric(vertical: 8.0),
                                                                    child:
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Flexible(
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  standardList.title == "Per Bedroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bedroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : standardList.title == "Per Bathroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bathroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : Image.asset(
                                                                                    "assets/icons/price.png",
                                                                                    height: 20,
                                                                                    color: AppStyles.appThemeColor,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 6,
                                                                                  ),
                                                                                  Flexible(
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Textwidget(
                                                                                          text: standardList.title,
                                                                                          fontWeight: FontWeight.w700,
                                                                                          fontSize: 13,
                                                                                        ),
                                                                                        // Textwidget(
                                                                                        //   text: "Price per Bed",
                                                                                        //   color:
                                                                                        //   AppStyles.appThemeColor,
                                                                                        //   fontSize: 11,
                                                                                        // )
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Textwidget(
                                                                              text: "\$${standardList.price}",
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 13,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                            controllerDetail
                                                                .standardArray1
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : const Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                  5),
                                                              child:
                                                              Divider(),
                                                            ),
                                                            controllerDetail
                                                                .deepArray1
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : Textwidget(
                                                              text:
                                                              "Deep",
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700,
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            controllerDetail
                                                                .deepArray1
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : ListView
                                                                .builder(
                                                                itemCount: controllerDetail
                                                                    .deepArray1
                                                                    .length,
                                                                shrinkWrap:
                                                                true,
                                                                physics:
                                                                const NeverScrollableScrollPhysics(),
                                                                itemBuilder:
                                                                    (buildContext,
                                                                    index2) {
                                                                  var deepList =
                                                                  controllerDetail.deepArray1[index2];
                                                                  return Padding(
                                                                    padding:
                                                                    const EdgeInsets.symmetric(vertical: 8.0),
                                                                    child:
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Flexible(
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  deepList.title == "Per Bedroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bedroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : deepList.title == "Per Bathroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bathroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : Image.asset(
                                                                                    "assets/icons/price.png",
                                                                                    height: 20,
                                                                                    color: AppStyles.appThemeColor,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 6,
                                                                                  ),
                                                                                  Flexible(
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Textwidget(
                                                                                          text: deepList.title,
                                                                                          fontWeight: FontWeight.w700,
                                                                                          fontSize: 13,
                                                                                        ),
                                                                                        // Textwidget(
                                                                                        //   text: "Price per Bed",
                                                                                        //   color:
                                                                                        //   AppStyles.appThemeColor,
                                                                                        //   fontSize: 11,
                                                                                        // )
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Textwidget(
                                                                              text: "\$${deepList.price}",
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 13,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                } else if (serviceList == 2) {
                                                  return Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      // color:box_color,
                                                        border: Border.all(
                                                            color:
                                                            boxBorderColor),
                                                        borderRadius:
                                                        const BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                10))),
                                                    child: ExpansionTile(
                                                      onExpansionChanged:
                                                          (bool expanded) {},
                                                      expandedAlignment:
                                                      Alignment.topLeft,
                                                      tilePadding:
                                                      EdgeInsets.zero,
                                                      title: Textwidget(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        text: serviceName,
                                                      ),
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            controllerDetail
                                                                .standardArray2
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : Textwidget(
                                                              text:
                                                              "Standard",
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700,
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            controllerDetail
                                                                .standardArray2
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : ListView
                                                                .builder(
                                                                itemCount: controllerDetail
                                                                    .standardArray2
                                                                    .length,
                                                                shrinkWrap:
                                                                true,
                                                                physics:
                                                                const NeverScrollableScrollPhysics(),
                                                                itemBuilder:
                                                                    (buildContext,
                                                                    index2) {
                                                                  var standardList =
                                                                  controllerDetail.standardArray2[index2];
                                                                  return Padding(
                                                                    padding:
                                                                    const EdgeInsets.symmetric(vertical: 8.0),
                                                                    child:
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Flexible(
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  standardList.title == "Per Bedroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bedroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : standardList.title == "Per Bathroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bathroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : Image.asset(
                                                                                    "assets/icons/price.png",
                                                                                    height: 20,
                                                                                    color: AppStyles.appThemeColor,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 6,
                                                                                  ),
                                                                                  Flexible(
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Textwidget(
                                                                                          text: standardList.title,
                                                                                          fontWeight: FontWeight.w700,
                                                                                          fontSize: 13,
                                                                                        ),
                                                                                        // Textwidget(
                                                                                        //   text: "Price per Bed",
                                                                                        //   color:
                                                                                        //   AppStyles.appThemeColor,
                                                                                        //   fontSize: 11,
                                                                                        // )
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Textwidget(
                                                                              text: "\$${standardList.price}",
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 13,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                            controllerDetail
                                                                .standardArray2
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : const Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                  5),
                                                              child:
                                                              Divider(),
                                                            ),
                                                            controllerDetail
                                                                .deepArray2
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : Textwidget(
                                                              text:
                                                              "Deep",
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700,
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            controllerDetail
                                                                .deepArray2
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : ListView
                                                                .builder(
                                                                itemCount: controllerDetail
                                                                    .deepArray2
                                                                    .length,
                                                                shrinkWrap:
                                                                true,
                                                                physics:
                                                                const NeverScrollableScrollPhysics(),
                                                                itemBuilder:
                                                                    (buildContext,
                                                                    index2) {
                                                                  var deepList =
                                                                  controllerDetail.deepArray2[index2];
                                                                  return Padding(
                                                                    padding:
                                                                    const EdgeInsets.symmetric(vertical: 8.0),
                                                                    child:
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Flexible(
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  deepList.title == "Per Bedroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bedroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : deepList.title == "Per Bathroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bathroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : Image.asset(
                                                                                    "assets/icons/price.png",
                                                                                    height: 20,
                                                                                    color: AppStyles.appThemeColor,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 6,
                                                                                  ),
                                                                                  Flexible(
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Textwidget(
                                                                                          text: deepList.title,
                                                                                          fontWeight: FontWeight.w700,
                                                                                          fontSize: 13,
                                                                                        ),
                                                                                        // Textwidget(
                                                                                        //   text: "Price per Bed",
                                                                                        //   color:
                                                                                        //   AppStyles.appThemeColor,
                                                                                        //   fontSize: 11,
                                                                                        // )
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Textwidget(
                                                                              text: "\$${deepList.price}",
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 13,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                } else {
                                                  return Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      // color:box_color,
                                                        border: Border.all(
                                                            color:
                                                            boxBorderColor),
                                                        borderRadius:
                                                        const BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                10))),
                                                    child: ExpansionTile(
                                                      onExpansionChanged:
                                                          (bool expanded) {},
                                                      expandedAlignment:
                                                      Alignment.topLeft,
                                                      tilePadding:
                                                      EdgeInsets.zero,
                                                      title: Textwidget(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        text: serviceName,
                                                      ),
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            controllerDetail
                                                                .standardArray4
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : Textwidget(
                                                              text:
                                                              "Standard",
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700,
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            controllerDetail
                                                                .standardArray4
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : ListView
                                                                .builder(
                                                                itemCount: controllerDetail
                                                                    .standardArray4
                                                                    .length,
                                                                shrinkWrap:
                                                                true,
                                                                physics:
                                                                const NeverScrollableScrollPhysics(),
                                                                itemBuilder:
                                                                    (buildContext,
                                                                    index2) {
                                                                  var standardList =
                                                                  controllerDetail.standardArray4[index2];
                                                                  return Padding(
                                                                    padding:
                                                                    const EdgeInsets.symmetric(vertical: 8.0),
                                                                    child:
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Flexible(
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  standardList.title == "Per Bedroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bedroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : standardList.title == "Per Bathroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bathroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : Image.asset(
                                                                                    "assets/icons/price.png",
                                                                                    height: 20,
                                                                                    color: AppStyles.appThemeColor,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 6,
                                                                                  ),
                                                                                  Flexible(
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Textwidget(
                                                                                          text: standardList.title,
                                                                                          fontWeight: FontWeight.w700,
                                                                                          fontSize: 13,
                                                                                        ),
                                                                                        // Textwidget(
                                                                                        //   text: "Price per Bed",
                                                                                        //   color:
                                                                                        //   AppStyles.appThemeColor,
                                                                                        //   fontSize: 11,
                                                                                        // )
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Textwidget(
                                                                              text: "\$${standardList.price}",
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 13,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                            controllerDetail
                                                                .standardArray4
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : const Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                  5),
                                                              child:
                                                              Divider(),
                                                            ),
                                                            controllerDetail
                                                                .deepArray4
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : Textwidget(
                                                              text:
                                                              "Deep",
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700,
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            controllerDetail
                                                                .deepArray4
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : ListView
                                                                .builder(
                                                                itemCount: controllerDetail
                                                                    .deepArray4
                                                                    .length,
                                                                shrinkWrap:
                                                                true,
                                                                physics:
                                                                const NeverScrollableScrollPhysics(),
                                                                itemBuilder:
                                                                    (buildContext,
                                                                    index2) {
                                                                  var deepList =
                                                                  controllerDetail.deepArray4[index2];
                                                                  return Padding(
                                                                    padding:
                                                                    const EdgeInsets.symmetric(vertical: 8.0),
                                                                    child:
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Flexible(
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  deepList.title == "Per Bedroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bedroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : deepList.title == "Per Bathroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bathroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : Image.asset(
                                                                                    "assets/icons/price.png",
                                                                                    height: 20,
                                                                                    color: AppStyles.appThemeColor,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 6,
                                                                                  ),
                                                                                  Flexible(
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Textwidget(
                                                                                          text: deepList.title,
                                                                                          fontWeight: FontWeight.w700,
                                                                                          fontSize: 13,
                                                                                        ),
                                                                                        // Textwidget(
                                                                                        //   text: "Price per Bed",
                                                                                        //   color:
                                                                                        //   AppStyles.appThemeColor,
                                                                                        //   fontSize: 11,
                                                                                        // )
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Textwidget(
                                                                              text: "\$${deepList.price}",
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 13,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                }
                                              } else if (serviceList == 3) {
                                                // Office Space/Shops  // Squer feet
                                                return controllerDetail
                                                    .sqFtListStatus.isFalse
                                                    ? const SizedBox()
                                                    : Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5),
                                                  padding:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  decoration:
                                                  BoxDecoration(
                                                      border:
                                                      Border.all(
                                                        color: controllerDetail
                                                            .serviceId
                                                            .value ==
                                                            serviceList
                                                                .toString()
                                                            ? AppStyles
                                                            .appThemeColor
                                                            : AppStyles
                                                            .grediantblacklightcolor,
                                                      ),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .all(
                                                          Radius.circular(
                                                              10))),
                                                  child: ExpansionTile(
                                                    onExpansionChanged:
                                                        (bool
                                                    expanded) {},
                                                    expandedAlignment:
                                                    Alignment.topLeft,
                                                    tilePadding:
                                                    EdgeInsets.zero,
                                                    title: Textwidget(
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      text: serviceName,
                                                    ),
                                                    children: [
                                                      // weekly
                                                      controllerDetail
                                                          .weeklyList
                                                          .isEmpty
                                                          ? const SizedBox()
                                                          : Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                            children: [
                                                              Image.asset(
                                                                "assets/icons/Vector (3).png",
                                                                scale:
                                                                4,
                                                              ),
                                                              const SizedBox(
                                                                width:
                                                                10,
                                                              ),
                                                              Textwidget(
                                                                text:
                                                                "Weekly",
                                                                color:
                                                                AppStyles.appThemeColor,
                                                                fontWeight:
                                                                FontWeight.w700,
                                                                fontSize:
                                                                13,
                                                              )
                                                            ],
                                                          ),
                                                          ListView.builder(
                                                              itemCount: controllerDetail.weeklyList.length,
                                                              shrinkWrap: true,
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              itemBuilder: (buildContext, index) {
                                                                return Padding(
                                                                  padding: const EdgeInsets.only(left: 28, right: 10, top: 5),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Textwidget(
                                                                        text: "${controllerDetail.weeklyList[index].squareFeet} sq ft",
                                                                      ),
                                                                      Textwidget(
                                                                        text: "\$${controllerDetail.weeklyList[index].servicePrice}",
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                          const Divider()
                                                        ],
                                                      ),
                                                      // bi_weekly
                                                      controllerDetail
                                                          .biWeeklyList
                                                          .isEmpty
                                                          ? const SizedBox()
                                                          : Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                            children: [
                                                              Image
                                                                  .asset(
                                                                "assets/icons/Vector (3).png",
                                                                scale:
                                                                4,
                                                              ),
                                                              const SizedBox(
                                                                width:
                                                                10,
                                                              ),
                                                              Textwidget(
                                                                text:
                                                                "Bi Weekly",
                                                                color:
                                                                AppStyles.appThemeColor,
                                                                fontWeight:
                                                                FontWeight.w700,
                                                                fontSize:
                                                                13,
                                                              )
                                                            ],
                                                          ),
                                                          ListView.builder(
                                                              itemCount: controllerDetail.biWeeklyList.length,
                                                              shrinkWrap: true,
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              itemBuilder: (buildContext, index) {
                                                                return Padding(
                                                                  padding: const EdgeInsets.only(left: 28, right: 10, top: 5),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Textwidget(
                                                                        text: "${controllerDetail.biWeeklyList[index].squareFeet} sq ft",
                                                                      ),
                                                                      Textwidget(
                                                                        text: "\$${controllerDetail.biWeeklyList[index].servicePrice}",
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                          const Divider()
                                                        ],
                                                      ),
                                                      //monthly
                                                      controllerDetail
                                                          .monthlyList
                                                          .isEmpty
                                                          ? const SizedBox()
                                                          : Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                            children: [
                                                              Image
                                                                  .asset(
                                                                "assets/icons/Vector (3).png",
                                                                scale:
                                                                4,
                                                              ),
                                                              const SizedBox(
                                                                width:
                                                                10,
                                                              ),
                                                              Textwidget(
                                                                text:
                                                                "Monthly",
                                                                color:
                                                                AppStyles.appThemeColor,
                                                                fontWeight:
                                                                FontWeight.w700,
                                                                fontSize:
                                                                13,
                                                              )
                                                            ],
                                                          ),
                                                          ListView.builder(
                                                              itemCount: controllerDetail.monthlyList.length,
                                                              shrinkWrap: true,
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              itemBuilder: (buildContext, index) {
                                                                return Padding(
                                                                  padding: const EdgeInsets.only(left: 28, right: 10, top: 5),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Textwidget(
                                                                        text: "${controllerDetail.monthlyList[index].squareFeet} sq ft",
                                                                      ),
                                                                      Textwidget(
                                                                        text: "\$${controllerDetail.monthlyList[index].servicePrice}",
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                          const Divider()
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              } else if (serviceList == 5) {
                                                // Mis cellaneous // per hour
                                                return controllerDetail
                                                    .houryListStatus.isFalse
                                                    ? const SizedBox()
                                                    : Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5),
                                                  padding:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  decoration:
                                                  BoxDecoration(
                                                      border:
                                                      Border.all(
                                                        color: controllerDetail
                                                            .serviceId
                                                            .value ==
                                                            serviceList
                                                                .toString()
                                                            ? AppStyles
                                                            .appThemeColor
                                                            : AppStyles
                                                            .grediantblacklightcolor,
                                                      ),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .all(
                                                          Radius.circular(
                                                              10))),
                                                  child: ExpansionTile(
                                                    onExpansionChanged:
                                                        (bool
                                                    expanded) {},
                                                    expandedAlignment:
                                                    Alignment.topLeft,
                                                    tilePadding:
                                                    EdgeInsets.zero,
                                                    title: Textwidget(
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      text: serviceName,
                                                    ),
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            top: 5,
                                                            bottom:
                                                            5),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Row(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Image
                                                                    .asset(
                                                                  "assets/icons/Vector (5).png",
                                                                  scale:
                                                                  4,
                                                                ),
                                                                const SizedBox(
                                                                  width:
                                                                  10,
                                                                ),
                                                                Textwidget(
                                                                  text:
                                                                  "Weekly",
                                                                  color: AppStyles
                                                                      .appThemeColor,
                                                                  fontWeight:
                                                                  FontWeight.w700,
                                                                  fontSize:
                                                                  13,
                                                                )
                                                              ],
                                                            ),
                                                            ListView.builder(
                                                                itemCount: controllerDetail.weeklyListH.length,
                                                                shrinkWrap: true,
                                                                physics: const NeverScrollableScrollPhysics(),
                                                                itemBuilder: (buildContext, index) {
                                                                  return Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left: 28,
                                                                        right: 10,
                                                                        top: 5),
                                                                    child:
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Flexible(
                                                                          child: Textwidget(
                                                                            text: "Hourly ( Minimum 2 hours services )",
                                                                            fontSize: 13,
                                                                          ),
                                                                        ),
                                                                        Textwidget(
                                                                          text: "\$${controllerDetail.weeklyListH[index].servicePrice}",
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                            const Divider()
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            top: 5,
                                                            bottom:
                                                            5),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Row(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Image
                                                                    .asset(
                                                                  "assets/icons/Vector (5).png",
                                                                  scale:
                                                                  4,
                                                                ),
                                                                const SizedBox(
                                                                  width:
                                                                  10,
                                                                ),
                                                                Textwidget(
                                                                  text:
                                                                  "Bi Weekly",
                                                                  color: AppStyles
                                                                      .appThemeColor,
                                                                  fontWeight:
                                                                  FontWeight.w700,
                                                                  fontSize:
                                                                  13,
                                                                )
                                                              ],
                                                            ),
                                                            ListView.builder(
                                                                itemCount: controllerDetail.biWeeklyListH.length,
                                                                shrinkWrap: true,
                                                                physics: const NeverScrollableScrollPhysics(),
                                                                itemBuilder: (buildContext, index) {
                                                                  return Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left: 28,
                                                                        right: 10,
                                                                        top: 5),
                                                                    child:
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Flexible(
                                                                          child: Textwidget(
                                                                            text: "Hourly ( Minimum 2 hours services )",
                                                                            fontSize: 13,
                                                                          ),
                                                                        ),
                                                                        Textwidget(
                                                                          text: "\$${controllerDetail.biWeeklyListH[index].servicePrice}",
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                            const Divider()
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            top: 5,
                                                            bottom:
                                                            5),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Row(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Image
                                                                    .asset(
                                                                  "assets/icons/Vector (5).png",
                                                                  scale:
                                                                  4,
                                                                ),
                                                                const SizedBox(
                                                                  width:
                                                                  10,
                                                                ),
                                                                Textwidget(
                                                                  text:
                                                                  "Monthly",
                                                                  color: AppStyles
                                                                      .appThemeColor,
                                                                  fontWeight:
                                                                  FontWeight.w700,
                                                                  fontSize:
                                                                  13,
                                                                )
                                                              ],
                                                            ),
                                                            ListView.builder(
                                                                itemCount: controllerDetail.monthlyListH.length,
                                                                shrinkWrap: true,
                                                                physics: const NeverScrollableScrollPhysics(),
                                                                itemBuilder: (buildContext, index) {
                                                                  return Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left: 28,
                                                                        right: 10,
                                                                        top: 5),
                                                                    child:
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Flexible(
                                                                          child: Textwidget(
                                                                            text: "Hourly ( Minimum 2 hours services )",
                                                                            fontSize: 13,
                                                                          ),
                                                                        ),
                                                                        Textwidget(
                                                                          text: "\$${controllerDetail.monthlyListH[index].servicePrice}",
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                            const Divider()
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                // Squer feet for cohost
                                                return controllerDetail
                                                    .sqFtListStatus.isFalse
                                                    ? const SizedBox()
                                                    : Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5),
                                                  padding:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  decoration:
                                                  BoxDecoration(
                                                      border:
                                                      Border.all(
                                                        color: controllerDetail
                                                            .serviceId
                                                            .value ==
                                                            serviceList
                                                                .toString()
                                                            ? AppStyles
                                                            .appThemeColor
                                                            : AppStyles
                                                            .grediantblacklightcolor,
                                                      ),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .all(
                                                          Radius.circular(
                                                              10))),
                                                  child: ExpansionTile(
                                                    onExpansionChanged:
                                                        (bool
                                                    expanded) {},
                                                    expandedAlignment:
                                                    Alignment.topLeft,
                                                    tilePadding:
                                                    EdgeInsets.zero,
                                                    title: Textwidget(
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      text: serviceName,
                                                    ),
                                                    children: [
                                                      // weekly
                                                      controllerDetail
                                                          .weeklyList
                                                          .isEmpty
                                                          ? const SizedBox()
                                                          : Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                            children: [
                                                              Image
                                                                  .asset(
                                                                "assets/icons/Vector (3).png",
                                                                scale:
                                                                4,
                                                              ),
                                                              const SizedBox(
                                                                width:
                                                                10,
                                                              ),
                                                              Textwidget(
                                                                text:
                                                                "Weekly",
                                                                color:
                                                                AppStyles.appThemeColor,
                                                                fontWeight:
                                                                FontWeight.w700,
                                                                fontSize:
                                                                13,
                                                              )
                                                            ],
                                                          ),
                                                          ListView.builder(
                                                              itemCount: controllerDetail.weeklyList.length,
                                                              shrinkWrap: true,
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              itemBuilder: (buildContext, index) {
                                                                return Padding(
                                                                  padding: const EdgeInsets.only(left: 28, right: 10, top: 5),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Textwidget(
                                                                        text: "${controllerDetail.weeklyList[index].squareFeet} sq ft",
                                                                      ),
                                                                      Textwidget(
                                                                        text: "\$${controllerDetail.weeklyList[index].servicePrice}",
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                          const Divider()
                                                        ],
                                                      ),
                                                      // bi_weekly
                                                      controllerDetail
                                                          .biWeeklyList
                                                          .isEmpty
                                                          ? const SizedBox()
                                                          : Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                            children: [
                                                              Image
                                                                  .asset(
                                                                "assets/icons/Vector (3).png",
                                                                scale:
                                                                4,
                                                              ),
                                                              const SizedBox(
                                                                width:
                                                                10,
                                                              ),
                                                              Textwidget(
                                                                text:
                                                                "Bi Weekly",
                                                                color:
                                                                AppStyles.appThemeColor,
                                                                fontWeight:
                                                                FontWeight.w700,
                                                                fontSize:
                                                                13,
                                                              )
                                                            ],
                                                          ),
                                                          ListView.builder(
                                                              itemCount: controllerDetail.biWeeklyList.length,
                                                              shrinkWrap: true,
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              itemBuilder: (buildContext, index) {
                                                                return Padding(
                                                                  padding: const EdgeInsets.only(left: 28, right: 10, top: 5),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Textwidget(
                                                                        text: "${controllerDetail.biWeeklyList[index].squareFeet} sq ft",
                                                                      ),
                                                                      Textwidget(
                                                                        text: "\$${controllerDetail.biWeeklyList[index].servicePrice}",
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                          const Divider()
                                                        ],
                                                      ),
                                                      //monthly
                                                      controllerDetail
                                                          .monthlyList
                                                          .isEmpty
                                                          ? const SizedBox()
                                                          : Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                            children: [
                                                              Image
                                                                  .asset(
                                                                "assets/icons/Vector (3).png",
                                                                scale:
                                                                4,
                                                              ),
                                                              const SizedBox(
                                                                width:
                                                                10,
                                                              ),
                                                              Textwidget(
                                                                text:
                                                                "Monthly",
                                                                color:
                                                                AppStyles.appThemeColor,
                                                                fontWeight:
                                                                FontWeight.w700,
                                                                fontSize:
                                                                13,
                                                              )
                                                            ],
                                                          ),
                                                          ListView.builder(
                                                              itemCount: controllerDetail.monthlyList.length,
                                                              shrinkWrap: true,
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              itemBuilder: (buildContext, index) {
                                                                return Padding(
                                                                  padding: const EdgeInsets.only(left: 28, right: 10, top: 5),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Textwidget(
                                                                        text: "${controllerDetail.monthlyList[index].squareFeet} sq ft",
                                                                      ),
                                                                      Textwidget(
                                                                        text: "\$${controllerDetail.monthlyList[index].servicePrice}",
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                          const Divider()
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            })
                                      ],
                                    )
                                  else
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        // services
                                        Obx(() => ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: controllerDetail
                                                .serviceIdArray.length,
                                            physics:
                                            const NeverScrollableScrollPhysics(),
                                            itemBuilder: (buildContext, index) {
                                              var serviceList = controllerDetail
                                                  .serviceIdArray[index];
                                              var serviceName = controllerDetail
                                                  .serviceNameArray[index];

                                              log("serviceList name   -----😱  $serviceList");

                                              Color boxBorderColor;

                                              if (controllerDetail
                                                  .serviceId.value ==
                                                  serviceList.toString()) {
                                                boxBorderColor =
                                                    AppStyles.appThemeColor;
                                              } else {
                                                boxBorderColor = AppStyles
                                                    .grediantblacklightcolor;
                                              }

                                              if (serviceList == 1 || serviceList == 2 || serviceList == 4) {
                                                if (serviceList == 1) {
                                                  return Obx(() => Container(
                                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                                    padding:
                                                    const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    decoration:
                                                    BoxDecoration(
                                                      // color:box_color,
                                                        border:
                                                        Border.all(
                                                          color: controllerDetail
                                                              .serviceId
                                                              .value ==
                                                              serviceList
                                                                  .toString()
                                                              ? AppStyles
                                                              .appThemeColor
                                                              : AppStyles
                                                              .grediantblacklightcolor,
                                                        ),
                                                        borderRadius:
                                                        const BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                10))),
                                                    child: ExpansionTile(
                                                      onExpansionChanged:
                                                          (bool expanded) {
                                                        controllerDetail
                                                            .serviceId
                                                            .value =
                                                            serviceList
                                                                .toString();
                                                        controllerDetail
                                                            .serviceName
                                                            .value =
                                                            serviceName
                                                                .toString();

                                                        log("service_id - =- = -= - =- = -= ${controllerDetail.serviceId.value}");
                                                        log("service_name - =- = -= - =- = -= ${controllerDetail.serviceName.value}");
                                                      },
                                                      expandedAlignment:
                                                      Alignment.topLeft,
                                                      tilePadding:
                                                      EdgeInsets.zero,
                                                      title: Textwidget(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        text: serviceName,
                                                      ),
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            controllerDetail
                                                                .standardArray1
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : Textwidget(
                                                              text:
                                                              "Standard",
                                                              fontWeight:
                                                              FontWeight.w700,
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            controllerDetail
                                                                .standardArray1
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : ListView.builder(
                                                                itemCount: controllerDetail.standardArray1.length,
                                                                shrinkWrap: true,
                                                                physics: const NeverScrollableScrollPhysics(),
                                                                itemBuilder: (buildContext, index2) {
                                                                  var standardList =
                                                                  controllerDetail.standardArray1[index2];
                                                                  return Padding(
                                                                    padding:
                                                                    const EdgeInsets.symmetric(vertical: 8.0),
                                                                    child:
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Flexible(
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  standardList.title == "Per Bedroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bedroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : standardList.title == "Per Bathroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bathroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : Image.asset(
                                                                                    "assets/icons/price.png",
                                                                                    height: 20,
                                                                                    color: AppStyles.appThemeColor,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 6,
                                                                                  ),
                                                                                  Flexible(
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Textwidget(
                                                                                          text: standardList.title,
                                                                                          fontWeight: FontWeight.w700,
                                                                                          fontSize: 13,
                                                                                        ),
                                                                                        // Textwidget(
                                                                                        //   text: "Price per Bed",
                                                                                        //   color:
                                                                                        //   AppStyles.appThemeColor,
                                                                                        //   fontSize: 11,
                                                                                        // )
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Textwidget(
                                                                              text: "\$${standardList.price}",
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 13,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                            controllerDetail
                                                                .standardArray1
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : const Padding(
                                                              padding:
                                                              EdgeInsets.symmetric(vertical: 5),
                                                              child:
                                                              Divider(),
                                                            ),
                                                            controllerDetail
                                                                .deepArray1
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : Textwidget(
                                                              text:
                                                              "Deep",
                                                              fontWeight:
                                                              FontWeight.w700,
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            controllerDetail
                                                                .deepArray1
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : ListView.builder(
                                                                itemCount: controllerDetail.deepArray1.length,
                                                                shrinkWrap: true,
                                                                physics: const NeverScrollableScrollPhysics(),
                                                                itemBuilder: (buildContext, index2) {
                                                                  var deepList =
                                                                  controllerDetail.deepArray1[index2];
                                                                  return Padding(
                                                                    padding:
                                                                    const EdgeInsets.symmetric(vertical: 8.0),
                                                                    child:
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Flexible(
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  deepList.title == "Per Bedroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bedroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : deepList.title == "Per Bathroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bathroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : Image.asset(
                                                                                    "assets/icons/price.png",
                                                                                    height: 20,
                                                                                    color: AppStyles.appThemeColor,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 6,
                                                                                  ),
                                                                                  Flexible(
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Textwidget(
                                                                                          text: deepList.title,
                                                                                          fontWeight: FontWeight.w700,
                                                                                          fontSize: 13,
                                                                                        ),
                                                                                        // Textwidget(
                                                                                        //   text: "Price per Bed",
                                                                                        //   color:
                                                                                        //   AppStyles.appThemeColor,
                                                                                        //   fontSize: 11,
                                                                                        // )
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Textwidget(
                                                                              text: "\$${deepList.price}",
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 13,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ));
                                                } else if (serviceList == 2) {
                                                  return Obx(() => Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 5),
                                                    padding:
                                                    const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    decoration:
                                                    BoxDecoration(
                                                      // color:box_color,
                                                        border:
                                                        Border.all(
                                                          color: controllerDetail
                                                              .serviceId
                                                              .value ==
                                                              serviceList
                                                                  .toString()
                                                              ? AppStyles
                                                              .appThemeColor
                                                              : AppStyles
                                                              .grediantblacklightcolor,
                                                        ),
                                                        borderRadius:
                                                        const BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                10))),
                                                    child: ExpansionTile(
                                                      onExpansionChanged:
                                                          (bool expanded) {
                                                        controllerDetail
                                                            .serviceId
                                                            .value =
                                                            serviceList
                                                                .toString();
                                                        controllerDetail
                                                            .serviceName
                                                            .value =
                                                            serviceName
                                                                .toString();

                                                        log("service_id - =- = -= - =- = -= ${controllerDetail.serviceId.value}");
                                                        log("service_name - =- = -= - =- = -= ${controllerDetail.serviceName.value}");
                                                      },
                                                      expandedAlignment:
                                                      Alignment.topLeft,
                                                      tilePadding:
                                                      EdgeInsets.zero,
                                                      title: Textwidget(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        text: serviceName,
                                                      ),
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            controllerDetail
                                                                .standardArray2
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : Textwidget(
                                                              text:
                                                              "Standard",
                                                              fontWeight:
                                                              FontWeight.w700,
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            controllerDetail
                                                                .standardArray2
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : ListView.builder(
                                                                itemCount: controllerDetail.standardArray2.length,
                                                                shrinkWrap: true,
                                                                physics: const NeverScrollableScrollPhysics(),
                                                                itemBuilder: (buildContext, index2) {
                                                                  var standardList =
                                                                  controllerDetail.standardArray2[index2];
                                                                  return Padding(
                                                                    padding:
                                                                    const EdgeInsets.symmetric(vertical: 8.0),
                                                                    child:
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Flexible(
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  standardList.title == "Per Bedroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bedroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : standardList.title == "Per Bathroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bathroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : Image.asset(
                                                                                    "assets/icons/price.png",
                                                                                    height: 20,
                                                                                    color: AppStyles.appThemeColor,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 6,
                                                                                  ),
                                                                                  Flexible(
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Textwidget(
                                                                                          text: standardList.title,
                                                                                          fontWeight: FontWeight.w700,
                                                                                          fontSize: 13,
                                                                                        ),
                                                                                        // Textwidget(
                                                                                        //   text: "Price per Bed",
                                                                                        //   color:
                                                                                        //   AppStyles.appThemeColor,
                                                                                        //   fontSize: 11,
                                                                                        // )
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Textwidget(
                                                                              text: "\$${standardList.price}",
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 13,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                            controllerDetail
                                                                .standardArray2
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : const Padding(
                                                              padding:
                                                              EdgeInsets.symmetric(vertical: 5),
                                                              child:
                                                              Divider(),
                                                            ),
                                                            controllerDetail
                                                                .deepArray2
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : Textwidget(
                                                              text:
                                                              "Deep",
                                                              fontWeight:
                                                              FontWeight.w700,
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            controllerDetail
                                                                .deepArray2
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : ListView.builder(
                                                                itemCount: controllerDetail.deepArray2.length,
                                                                shrinkWrap: true,
                                                                physics: const NeverScrollableScrollPhysics(),
                                                                itemBuilder: (buildContext, index2) {
                                                                  var deepList =
                                                                  controllerDetail.deepArray2[index2];
                                                                  return Padding(
                                                                    padding:
                                                                    const EdgeInsets.symmetric(vertical: 8.0),
                                                                    child:
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Flexible(
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  deepList.title == "Per Bedroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bedroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : deepList.title == "Per Bathroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bathroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : Image.asset(
                                                                                    "assets/icons/price.png",
                                                                                    height: 20,
                                                                                    color: AppStyles.appThemeColor,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 6,
                                                                                  ),
                                                                                  Flexible(
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Textwidget(
                                                                                          text: deepList.title,
                                                                                          fontWeight: FontWeight.w700,
                                                                                          fontSize: 13,
                                                                                        ),
                                                                                        // Textwidget(
                                                                                        //   text: "Price per Bed",
                                                                                        //   color:
                                                                                        //   AppStyles.appThemeColor,
                                                                                        //   fontSize: 11,
                                                                                        // )
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Textwidget(
                                                                              text: "\$${deepList.price}",
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 13,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ));
                                                } else {
                                                  return Obx(() => Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 5),
                                                    padding:
                                                    const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    decoration:
                                                    BoxDecoration(
                                                      // color:box_color,
                                                        border:
                                                        Border.all(
                                                          color: controllerDetail
                                                              .serviceId
                                                              .value ==
                                                              serviceList
                                                                  .toString()
                                                              ? AppStyles
                                                              .appThemeColor
                                                              : AppStyles
                                                              .grediantblacklightcolor,
                                                        ),
                                                        borderRadius:
                                                        const BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                10))),
                                                    child: ExpansionTile(
                                                      onExpansionChanged:
                                                          (bool expanded) {
                                                        controllerDetail
                                                            .serviceId
                                                            .value =
                                                            serviceList
                                                                .toString();
                                                        controllerDetail
                                                            .serviceName
                                                            .value =
                                                            serviceName
                                                                .toString();

                                                        log("service_id - =- = -= - =- = -= ${controllerDetail.serviceId.value}");
                                                        log("service_name - =- = -= - =- = -= ${controllerDetail.serviceName.value}");
                                                      },
                                                      expandedAlignment:
                                                      Alignment.topLeft,
                                                      tilePadding:
                                                      EdgeInsets.zero,
                                                      title: Textwidget(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        text: serviceName,
                                                      ),
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            controllerDetail
                                                                .standardArray4
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : Textwidget(
                                                              text:
                                                              "Standard",
                                                              fontWeight:
                                                              FontWeight.w700,
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            controllerDetail
                                                                .standardArray4
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : ListView.builder(
                                                                itemCount: controllerDetail.standardArray4.length,
                                                                shrinkWrap: true,
                                                                physics: const NeverScrollableScrollPhysics(),
                                                                itemBuilder: (buildContext, index2) {
                                                                  var standardList =
                                                                  controllerDetail.standardArray4[index2];
                                                                  return Padding(
                                                                    padding:
                                                                    const EdgeInsets.symmetric(vertical: 8.0),
                                                                    child:
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Flexible(
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  standardList.title == "Per Bedroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bedroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : standardList.title == "Per Bathroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bathroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : Image.asset(
                                                                                    "assets/icons/price.png",
                                                                                    height: 20,
                                                                                    color: AppStyles.appThemeColor,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 6,
                                                                                  ),
                                                                                  Flexible(
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Textwidget(
                                                                                          text: standardList.title,
                                                                                          fontWeight: FontWeight.w700,
                                                                                          fontSize: 13,
                                                                                        ),
                                                                                        // Textwidget(
                                                                                        //   text: "Price per Bed",
                                                                                        //   color:
                                                                                        //   AppStyles.appThemeColor,
                                                                                        //   fontSize: 11,
                                                                                        // )
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Textwidget(
                                                                              text: "\$${standardList.price}",
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 13,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                            controllerDetail
                                                                .standardArray4
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : const Padding(
                                                              padding:
                                                              EdgeInsets.symmetric(vertical: 5),
                                                              child:
                                                              Divider(),
                                                            ),
                                                            controllerDetail
                                                                .deepArray4
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : Textwidget(
                                                              text:
                                                              "Deep",
                                                              fontWeight:
                                                              FontWeight.w700,
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            controllerDetail
                                                                .deepArray4
                                                                .isEmpty
                                                                ? const SizedBox()
                                                                : ListView.builder(
                                                                itemCount: controllerDetail.deepArray4.length,
                                                                shrinkWrap: true,
                                                                physics: const NeverScrollableScrollPhysics(),
                                                                itemBuilder: (buildContext, index2) {
                                                                  var deepList =
                                                                  controllerDetail.deepArray4[index2];
                                                                  return Padding(
                                                                    padding:
                                                                    const EdgeInsets.symmetric(vertical: 8.0),
                                                                    child:
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Flexible(
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  deepList.title == "Per Bedroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bedroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : deepList.title == "Per Bathroom"
                                                                                      ? Image.asset(
                                                                                    "assets/icons/bathroom.png",
                                                                                    scale: 4,
                                                                                  )
                                                                                      : Image.asset(
                                                                                    "assets/icons/price.png",
                                                                                    height: 20,
                                                                                    color: AppStyles.appThemeColor,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 6,
                                                                                  ),
                                                                                  Flexible(
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Textwidget(
                                                                                          text: deepList.title,
                                                                                          fontWeight: FontWeight.w700,
                                                                                          fontSize: 13,
                                                                                        ),
                                                                                        // Textwidget(
                                                                                        //   text: "Price per Bed",
                                                                                        //   color:
                                                                                        //   AppStyles.appThemeColor,
                                                                                        //   fontSize: 11,
                                                                                        // )
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Textwidget(
                                                                              text: "\$${deepList.price}",
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 13,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ));
                                                }
                                              } else if (serviceList == 3) {
                                                // Office Space/Shops  // Squer feet
                                                return controllerDetail
                                                    .sqFtListStatus.isFalse
                                                    ? const SizedBox()
                                                    : Obx(() => Container(
                                                  margin:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5),
                                                  padding:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      horizontal:
                                                      10),
                                                  decoration:
                                                  BoxDecoration(
                                                      border: Border
                                                          .all(
                                                        color: controllerDetail.serviceId.value ==
                                                            serviceList
                                                                .toString()
                                                            ? AppStyles
                                                            .appThemeColor
                                                            : AppStyles
                                                            .grediantblacklightcolor,
                                                      ),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .all(
                                                          Radius.circular(
                                                              10))),
                                                  child: ExpansionTile(
                                                    onExpansionChanged:
                                                        (bool
                                                    expanded) {
                                                      controllerDetail
                                                          .serviceId
                                                          .value =
                                                          serviceList
                                                              .toString();
                                                      controllerDetail
                                                          .serviceName
                                                          .value =
                                                          serviceName
                                                              .toString();

                                                      log("service_id - =- = -= - =- = -= ${controllerDetail.serviceId.value}");
                                                      log("service_name - =- = -= - =- = -= ${controllerDetail.serviceName.value}");
                                                      log("service_id - =- = -= - =- = -= ${controllerDetail.serviceId.value}");
                                                      log("service_name - =- = -= - =- = -= ${controllerDetail.serviceName.value}");
                                                    },
                                                    expandedAlignment:
                                                    Alignment
                                                        .topLeft,
                                                    tilePadding:
                                                    EdgeInsets.zero,
                                                    title: Textwidget(
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight
                                                          .w700,
                                                      text: serviceName,
                                                    ),
                                                    children: [
                                                      // weekly
                                                      controllerDetail
                                                          .weeklyList
                                                          .isEmpty
                                                          ? const SizedBox()
                                                          : Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                            children: [
                                                              Image.asset(
                                                                "assets/icons/Vector (3).png",
                                                                scale: 4,
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Textwidget(
                                                                text: "Weekly",
                                                                color: AppStyles.appThemeColor,
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 13,
                                                              )
                                                            ],
                                                          ),
                                                          ListView.builder(
                                                              itemCount: controllerDetail.weeklyList.length,
                                                              shrinkWrap: true,
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              itemBuilder: (buildContext, index) {
                                                                return Padding(
                                                                  padding: const EdgeInsets.only(left: 28, right: 10, top: 5),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Textwidget(
                                                                        text: "${controllerDetail.weeklyList[index].squareFeet} sq ft",
                                                                      ),
                                                                      Textwidget(
                                                                        text: "\$${controllerDetail.weeklyList[index].servicePrice}",
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                          const Divider()
                                                        ],
                                                      ),
                                                      // bi_weekly
                                                      controllerDetail
                                                          .biWeeklyList
                                                          .isEmpty
                                                          ? const SizedBox()
                                                          : Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                            children: [
                                                              Image.asset(
                                                                "assets/icons/Vector (3).png",
                                                                scale: 4,
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Textwidget(
                                                                text: "Bi Weekly",
                                                                color: AppStyles.appThemeColor,
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 13,
                                                              )
                                                            ],
                                                          ),
                                                          ListView.builder(
                                                              itemCount: controllerDetail.biWeeklyList.length,
                                                              shrinkWrap: true,
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              itemBuilder: (buildContext, index) {
                                                                return Padding(
                                                                  padding: const EdgeInsets.only(left: 28, right: 10, top: 5),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Textwidget(
                                                                        text: "${controllerDetail.biWeeklyList[index].squareFeet} sq ft",
                                                                      ),
                                                                      Textwidget(
                                                                        text: "\$${controllerDetail.biWeeklyList[index].servicePrice}",
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                          const Divider()
                                                        ],
                                                      ),
                                                      //monthly
                                                      controllerDetail
                                                          .monthlyList
                                                          .isEmpty
                                                          ? const SizedBox()
                                                          : Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                            children: [
                                                              Image.asset(
                                                                "assets/icons/Vector (3).png",
                                                                scale: 4,
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Textwidget(
                                                                text: "Monthly",
                                                                color: AppStyles.appThemeColor,
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 13,
                                                              )
                                                            ],
                                                          ),
                                                          ListView.builder(
                                                              itemCount: controllerDetail.monthlyList.length,
                                                              shrinkWrap: true,
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              itemBuilder: (buildContext, index) {
                                                                return Padding(
                                                                  padding: const EdgeInsets.only(left: 28, right: 10, top: 5),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Textwidget(
                                                                        text: "${controllerDetail.monthlyList[index].squareFeet} sq ft",
                                                                      ),
                                                                      Textwidget(
                                                                        text: "\$${controllerDetail.monthlyList[index].servicePrice}",
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                          const Divider()
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                              } else if (serviceList == 5) {
                                                // Mis cellaneous // per hour
                                                return controllerDetail
                                                    .houryListStatus.isFalse
                                                    ? const SizedBox()
                                                    : Obx(() => Container(
                                                  margin:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5),
                                                  padding:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      horizontal:
                                                      10),
                                                  decoration:
                                                  BoxDecoration(
                                                      border: Border
                                                          .all(
                                                        color: controllerDetail.serviceId.value ==
                                                            serviceList
                                                                .toString()
                                                            ? AppStyles
                                                            .appThemeColor
                                                            : AppStyles
                                                            .grediantblacklightcolor,
                                                      ),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .all(
                                                          Radius.circular(
                                                              10))),
                                                  child: ExpansionTile(
                                                    onExpansionChanged:
                                                        (bool
                                                    expanded) {
                                                      controllerDetail
                                                          .serviceId
                                                          .value =
                                                          serviceList
                                                              .toString();
                                                      controllerDetail
                                                          .serviceName
                                                          .value =
                                                          serviceName
                                                              .toString();

                                                      log("service_id - =- = -= - =- = -= ${controllerDetail.serviceId.value}");
                                                      log("service_name - =- = -= - =- = -= ${controllerDetail.serviceName.value}");
                                                      log("service_id - =- = -= - =- = -= ${controllerDetail.serviceId.value}");
                                                      log("service_name - =- = -= - =- = -= ${controllerDetail.serviceName.value}");
                                                    },
                                                    expandedAlignment:
                                                    Alignment
                                                        .topLeft,
                                                    tilePadding:
                                                    EdgeInsets.zero,
                                                    title: Textwidget(
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight
                                                          .w700,
                                                      text: serviceName,
                                                    ),
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            top: 5,
                                                            bottom:
                                                            5),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Row(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Image
                                                                    .asset(
                                                                  "assets/icons/Vector (5).png",
                                                                  scale:
                                                                  4,
                                                                ),
                                                                const SizedBox(
                                                                  width:
                                                                  10,
                                                                ),
                                                                Textwidget(
                                                                  text:
                                                                  "Weekly",
                                                                  color:
                                                                  AppStyles.appThemeColor,
                                                                  fontWeight:
                                                                  FontWeight.w700,
                                                                  fontSize:
                                                                  13,
                                                                )
                                                              ],
                                                            ),
                                                            ListView.builder(
                                                                itemCount: controllerDetail.weeklyListH.length,
                                                                shrinkWrap: true,
                                                                physics: const NeverScrollableScrollPhysics(),
                                                                itemBuilder: (buildContext, index) {
                                                                  return Padding(
                                                                    padding: const EdgeInsets.only(
                                                                        left: 28,
                                                                        right: 10,
                                                                        top: 5),
                                                                    child:
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Flexible(
                                                                          child: Textwidget(
                                                                            text: "Hourly ( Minimum 2 hours services )",
                                                                            fontSize: 13,
                                                                          ),
                                                                        ),
                                                                        Textwidget(
                                                                          text: "\$${controllerDetail.weeklyListH[index].servicePrice}",
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                            const Divider()
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            top: 5,
                                                            bottom:
                                                            5),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Row(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Image
                                                                    .asset(
                                                                  "assets/icons/Vector (5).png",
                                                                  scale:
                                                                  4,
                                                                ),
                                                                const SizedBox(
                                                                  width:
                                                                  10,
                                                                ),
                                                                Textwidget(
                                                                  text:
                                                                  "Bi Weekly",
                                                                  color:
                                                                  AppStyles.appThemeColor,
                                                                  fontWeight:
                                                                  FontWeight.w700,
                                                                  fontSize:
                                                                  13,
                                                                )
                                                              ],
                                                            ),
                                                            ListView.builder(
                                                                itemCount: controllerDetail.biWeeklyListH.length,
                                                                shrinkWrap: true,
                                                                physics: const NeverScrollableScrollPhysics(),
                                                                itemBuilder: (buildContext, index) {
                                                                  return Padding(
                                                                    padding: const EdgeInsets.only(
                                                                        left: 28,
                                                                        right: 10,
                                                                        top: 5),
                                                                    child:
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Flexible(
                                                                          child: Textwidget(
                                                                            text: "Hourly ( Minimum 2 hours services )",
                                                                            fontSize: 13,
                                                                          ),
                                                                        ),
                                                                        Textwidget(
                                                                          text: "\$${controllerDetail.biWeeklyListH[index].servicePrice}",
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                            const Divider()
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            top: 5,
                                                            bottom:
                                                            5),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Row(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Image
                                                                    .asset(
                                                                  "assets/icons/Vector (5).png",
                                                                  scale:
                                                                  4,
                                                                ),
                                                                const SizedBox(
                                                                  width:
                                                                  10,
                                                                ),
                                                                Textwidget(
                                                                  text:
                                                                  "Monthly",
                                                                  color:
                                                                  AppStyles.appThemeColor,
                                                                  fontWeight:
                                                                  FontWeight.w700,
                                                                  fontSize:
                                                                  13,
                                                                )
                                                              ],
                                                            ),
                                                            ListView.builder(
                                                                itemCount: controllerDetail.monthlyListH.length,
                                                                shrinkWrap: true,
                                                                physics: const NeverScrollableScrollPhysics(),
                                                                itemBuilder: (buildContext, index) {
                                                                  return Padding(
                                                                    padding: const EdgeInsets.only(
                                                                        left: 28,
                                                                        right: 10,
                                                                        top: 5),
                                                                    child:
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Flexible(
                                                                          child: Textwidget(
                                                                            text: "Hourly ( Minimum 2 hours services )",
                                                                            fontSize: 13,
                                                                          ),
                                                                        ),
                                                                        Textwidget(
                                                                          text: "\$${controllerDetail.monthlyListH[index].servicePrice}",
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                            const Divider()
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                              } else {
                                                // Squer feet for cohost
                                                return controllerDetail
                                                    .sqFtListStatus.isFalse
                                                    ? const SizedBox()
                                                    : Obx(() => Container(
                                                  margin:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5),
                                                  padding:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      horizontal:
                                                      10),
                                                  decoration:
                                                  BoxDecoration(
                                                      border: Border
                                                          .all(
                                                        color: controllerDetail.serviceId.value ==
                                                            serviceList
                                                                .toString()
                                                            ? AppStyles
                                                            .appThemeColor
                                                            : AppStyles
                                                            .grediantblacklightcolor,
                                                      ),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .all(
                                                          Radius.circular(
                                                              10))),
                                                  child: ExpansionTile(
                                                    onExpansionChanged:
                                                        (bool
                                                    expanded) {
                                                      controllerDetail
                                                          .serviceId
                                                          .value =
                                                          serviceList
                                                              .toString();
                                                      controllerDetail
                                                          .serviceName
                                                          .value =
                                                          serviceName
                                                              .toString();

                                                      log("service_id - =- = -= - =- = -= ${controllerDetail.serviceId.value}");
                                                      log("service_name - =- = -= - =- = -= ${controllerDetail.serviceName.value}");
                                                      log("service_id - =- = -= - =- = -= ${controllerDetail.serviceId.value}");
                                                      log("service_name - =- = -= - =- = -= ${controllerDetail.serviceName.value}");
                                                    },
                                                    expandedAlignment:
                                                    Alignment
                                                        .topLeft,
                                                    tilePadding:
                                                    EdgeInsets.zero,
                                                    title: Textwidget(
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight
                                                          .w700,
                                                      text: serviceName,
                                                    ),
                                                    children: [
                                                      // weekly
                                                      controllerDetail
                                                          .weeklyList
                                                          .isEmpty
                                                          ? const SizedBox()
                                                          : Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                            children: [
                                                              Image.asset(
                                                                "assets/icons/Vector (3).png",
                                                                scale: 4,
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Textwidget(
                                                                text: "Weekly",
                                                                color: AppStyles.appThemeColor,
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 13,
                                                              )
                                                            ],
                                                          ),
                                                          ListView.builder(
                                                              itemCount: controllerDetail.weeklyList.length,
                                                              shrinkWrap: true,
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              itemBuilder: (buildContext, index) {
                                                                return Padding(
                                                                  padding: const EdgeInsets.only(left: 28, right: 10, top: 5),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Textwidget(
                                                                        text: "${controllerDetail.weeklyList[index].squareFeet} sq ft",
                                                                      ),
                                                                      Textwidget(
                                                                        text: "\$${controllerDetail.weeklyList[index].servicePrice}",
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                          const Divider()
                                                        ],
                                                      ),
                                                      // bi_weekly
                                                      controllerDetail
                                                          .biWeeklyList
                                                          .isEmpty
                                                          ? const SizedBox()
                                                          : Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                            children: [
                                                              Image.asset(
                                                                "assets/icons/Vector (3).png",
                                                                scale: 4,
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Textwidget(
                                                                text: "Bi Weekly",
                                                                color: AppStyles.appThemeColor,
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 13,
                                                              )
                                                            ],
                                                          ),
                                                          ListView.builder(
                                                              itemCount: controllerDetail.biWeeklyList.length,
                                                              shrinkWrap: true,
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              itemBuilder: (buildContext, index) {
                                                                return Padding(
                                                                  padding: const EdgeInsets.only(left: 28, right: 10, top: 5),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Textwidget(
                                                                        text: "${controllerDetail.biWeeklyList[index].squareFeet} sq ft",
                                                                      ),
                                                                      Textwidget(
                                                                        text: "\$${controllerDetail.biWeeklyList[index].servicePrice}",
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                          const Divider()
                                                        ],
                                                      ),
                                                      //monthly
                                                      controllerDetail
                                                          .monthlyList
                                                          .isEmpty
                                                          ? const SizedBox()
                                                          : Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                            children: [
                                                              Image.asset(
                                                                "assets/icons/Vector (3).png",
                                                                scale: 4,
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Textwidget(
                                                                text: "Monthly",
                                                                color: AppStyles.appThemeColor,
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 13,
                                                              )
                                                            ],
                                                          ),
                                                          ListView.builder(
                                                              itemCount: controllerDetail.monthlyList.length,
                                                              shrinkWrap: true,
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              itemBuilder: (buildContext, index) {
                                                                return Padding(
                                                                  padding: const EdgeInsets.only(left: 28, right: 10, top: 5),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Textwidget(
                                                                        text: "${controllerDetail.monthlyList[index].squareFeet} sq ft",
                                                                      ),
                                                                      Textwidget(
                                                                        text: "\$${controllerDetail.monthlyList[index].servicePrice}",
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                          const Divider()
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                              }
                                            }))
                                      ],
                                    ),
                                ],
                              ),
                            )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black12),
                              child: Center(
                                child: Transform.scale(
                                  scale: 0.9,
                                  child: Image.asset(
                                    "assets/icons/chat-dots.png",
                                    color: AppStyles.appThemeColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Textwidget(
                              text:
                              "Let`s talk with ${controllerDetail.id.value == "1" ? "Co-host" : "Cleaner"}",
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                            InkWell(
                              onTap: () {
                                var data = {
                                  'remote_firebase_id': controllerDetail
                                      .basicDetails['firebase_id']
                                      .toString(),
                                  'remote_user_id': controllerDetail
                                      .basicDetails['id']
                                      .toString(),
                                  'other_user_name':
                                  "${controllerDetail.basicDetails['firstname']} ${controllerDetail.basicDetails['lastname']}",
                                };
                                Get.toNamed(Routes.CHAT_SCREEN,
                                    parameters: data);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Textwidget(
                                  text: "Chat Us",
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                  color: AppStyles.appThemeColor,
                                  fontWeight: FontWeight.w500,
                                  decorationColor: AppStyles.appThemeColor,
                                ),
                              ),
                            )
                          ],
                        ),
                        SingleChildScrollView(
                            child: ReviewScreen(
                              reviewlist: controllerDetail.reviewListt,
                            ))
                      ],
                    )),
              ),
        ),),
        bottomNavigationBar: Obx(() => controllerDetail.isLoading.isTrue
            ? const SizedBox()
            : Padding(
          padding: const EdgeInsets.only(
              left: 10, right: 10, bottom: 5, top: 5),
          child: MyButton(
            text: 'Continue',
            onPressed: () {
              var data = {
                "title": controllerDetail.title.toString(),
                "id": controllerDetail.id.toString(),
                "zip_code":
                controllerDetail.basicDetails['zipcode'].toString(),
                "cleaner_cohost_id":
                controllerDetail.cleanerCohostId.value.toString(),
                "user_type": controllerDetail.userType.value.toString(),
                "service_id":
                controllerDetail.serviceId.value.toString(),
                "service_name":
                controllerDetail.serviceName.value.toString(),
              };

              if (controllerDetail.serviceId.value.isEmpty) {
                ToastClass.showToast(
                  'Please select any service',
                );
              } else {
                Get.toNamed(
                  Routes.ADD_REQUIREMENT_CLEANER,
                  parameters: data,
                );

                // if (controllerDetail.id.value == "0") {
                //   Get.toNamed(Routes.ADD_REQUIREMENT_CLEANER, parameters: data,);
                //   print("------------------- Cleaner ---------------------");
                // } else {
                //   Get.toNamed(Routes.ADD_REQUIREMENT_COHOST, parameters: data,);
                //   print("------------------- Co-Host ---------------------");
                // }
              }
            },
            color: AppStyles.appThemeColor,
            TextColor: AppStyles.backgroundColor,
          ),
        ))
    );
  }
}
