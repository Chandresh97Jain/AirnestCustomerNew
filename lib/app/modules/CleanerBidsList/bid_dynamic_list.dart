import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/nodata_image.dart';
import 'package:power_maids/app/routes/app_pages.dart';
import 'bid_list_model.dart';
import 'controllers/cleaner_bids_list_controller.dart';

class BidListCleaner extends StatelessWidget {
  final RxList<BidListModel> clenerbidlist;

  BidListCleaner({
    super.key,
    required this.clenerbidlist,
  });

  final CleanerBidsListController controller =
      Get.put(CleanerBidsListController());

  @override
  Widget build(BuildContext context) {
    log("controller.booking request == == = = = =${clenerbidlist.length}");
    return Obx(() => clenerbidlist.isEmpty
        ? NoDataFound(height: MediaQuery.of(context).size.height / 2)
        : Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemCount: clenerbidlist.length,
              shrinkWrap: true,
              // physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (buildContext, index) {
                var bidlist = clenerbidlist[index];
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 20),
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.zero,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppStyles.backgroundColor),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap:
                              bidlist.status == "2"
                                  ?(){
                                showModalBottomSheet(
                                    elevation: 0,
                                    backgroundColor: AppStyles
                                        .OnbordingBodybackgroundColor,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (builder) {
                                      return SingleChildScrollView(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisSize:
                                            MainAxisSize.min,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Textwidget(
                                                text: "Your Summary",
                                                color: AppStyles
                                                    .appThemeColor,
                                                fontSize: 18,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Textwidget(
                                                text: "Address",
                                                fontSize: 15,
                                                fontWeight:
                                                FontWeight.w700,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Image.asset(
                                                    "assets/icons/locationIcons.png",
                                                    scale: 4.5,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Flexible(
                                                    child: Textwidget(
                                                      maxLines: 50,
                                                      text: bidlist
                                                          .summary[0]
                                                          .address,
                                                      fontSize: 13,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Divider(
                                                height:
                                                MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                    25,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Flexible(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Textwidget(
                                                                text:
                                                                "Property Size ",
                                                                fontSize:
                                                                15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w700,
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Image
                                                                      .asset(
                                                                    "assets/icons/home01.png",
                                                                    scale:
                                                                    4.5,
                                                                  ),
                                                                  const SizedBox(
                                                                    width:
                                                                    5,
                                                                  ),
                                                                  Flexible(
                                                                    child:
                                                                    Textwidget(
                                                                      maxLines:
                                                                      5,
                                                                      text:
                                                                      bidlist.summary[0].propertySize,
                                                                      fontSize:
                                                                      13,
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Flexible(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Textwidget(
                                                                text:
                                                                "Services",
                                                                fontSize:
                                                                15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w700,
                                                              ),
                                                              Textwidget(
                                                                maxLines:
                                                                5,
                                                                text: bidlist
                                                                    .serviceTitle,
                                                                fontSize:
                                                                13,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(
                                                height:
                                                MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                    25,
                                              ),
                                              Textwidget(
                                                text: "Date and Time",
                                                fontSize: 15,
                                                fontWeight:
                                                FontWeight.w700,
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/icons/calandericon.png",
                                                    scale: 4.5,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Textwidget(
                                                    text: bidlist
                                                        .summary[0]
                                                        .bookingData
                                                        .toString(),
                                                    fontSize: 13,
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Image.asset(
                                                    "assets/icons/clockIcon.png",
                                                    scale: 3.5,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Textwidget(
                                                    text: bidlist
                                                        .summary[0]
                                                        .bookingTime
                                                        .toString(),
                                                    fontSize: 13,
                                                  )
                                                ],
                                              ),
                                              Divider(
                                                height:
                                                MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                    25,
                                              ),
                                              Textwidget(
                                                maxLines: 50,
                                                text: "Your Needs",
                                                fontSize: 15,
                                                fontWeight:
                                                FontWeight.w700,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Image.asset(
                                                    "assets/icons/describeicon.png",
                                                    scale: 4,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Flexible(
                                                      child: Textwidget(
                                                        maxLines: 100,
                                                        text: bidlist
                                                            .summary[0]
                                                            .description,
                                                        fontSize: 13,
                                                      )),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Divider(
                                                height: 0,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }
                                  :() {
                                var data = {
                                  "bid_id": bidlist.id.toString(),
                                  "address": bidlist.address
                                };
          
                                Get.toNamed(Routes.NEW_CLEANER_BIDS_LIST,
                                    parameters: data);
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              "assets/icons/IconforHome.png",
                                              height: 30,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Textwidget(
                                                    maxLines: 3,
                                                    text: bidlist.address,
                                                    fontWeight:
                                                        FontWeight.w400,
                                                  ),
                                                  Textwidget(
                                                    text: bidlist.created,
                                                    fontSize: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      bidlist.status == "2"
                                      ?Container(
                                        width: 80,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(18),
                                            color: AppStyles.AcceptColor
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                          child: Center(
                                              child: Text(
                                                textScaleFactor: 1,
                                                "Completed",
                                                style: TextStyle(
                                                    fontFamily: "JosefinSans",
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 10),
                                              )),
                                        ),
                                      )
                                      :Row(
                                        children: [
                                          Container(
                                            height: 25,
                                            width: 70,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color:
                                                    AppStyles.appThemeColor),
                                            child: Center(
                                              child: Textwidget(
                                                text: bidlist.totalBid
                                                    .toString(),
                                                color:
                                                    AppStyles.backgroundColor,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            size: 20,
                                            color:
                                                AppStyles.GraylightTextColor,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Divider(
                                    height: 0,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        elevation: 0,
                                        backgroundColor: AppStyles
                                            .OnbordingBodybackgroundColor,
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (builder) {
                                          return SingleChildScrollView(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Column(
                                                mainAxisSize:
                                                    MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Textwidget(
                                                    text: "Your Summary",
                                                    color: AppStyles
                                                        .appThemeColor,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Textwidget(
                                                    text: "Address",
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Image.asset(
                                                        "assets/icons/locationIcons.png",
                                                        scale: 4.5,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Flexible(
                                                        child: Textwidget(
                                                          maxLines: 50,
                                                          text: bidlist
                                                              .summary[0]
                                                              .address,
                                                          fontSize: 13,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Divider(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Flexible(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Textwidget(
                                                                    text:
                                                                        "Property Size ",
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                  Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        "assets/icons/home01.png",
                                                                        scale:
                                                                            4.5,
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Flexible(
                                                                        child:
                                                                            Textwidget(
                                                                          maxLines:
                                                                              5,
                                                                          text:
                                                                              bidlist.summary[0].propertySize,
                                                                          fontSize:
                                                                              13,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Flexible(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Textwidget(
                                                                    text:
                                                                        "Services",
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                  Textwidget(
                                                                    maxLines:
                                                                        5,
                                                                    text: bidlist
                                                                        .serviceTitle,
                                                                    fontSize:
                                                                        13,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                  ),
                                                  Textwidget(
                                                    text: "Date and Time",
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/icons/calandericon.png",
                                                        scale: 4.5,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Textwidget(
                                                        text: bidlist
                                                            .summary[0]
                                                            .bookingData
                                                            .toString(),
                                                        fontSize: 13,
                                                      ),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Image.asset(
                                                        "assets/icons/clockIcon.png",
                                                        scale: 3.5,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Textwidget(
                                                        text: bidlist
                                                            .summary[0]
                                                            .bookingTime
                                                            .toString(),
                                                        fontSize: 13,
                                                      )
                                                    ],
                                                  ),
                                                  Divider(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                  ),
                                                  Textwidget(
                                                    maxLines: 50,
                                                    text: "Your Needs",
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Image.asset(
                                                        "assets/icons/describeicon.png",
                                                        scale: 4,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Flexible(
                                                          child: Textwidget(
                                                        maxLines: 100,
                                                        text: bidlist
                                                            .summary[0]
                                                            .description,
                                                        fontSize: 13,
                                                      )),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Divider(
                                                    height: 0,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Textwidget(
                                          text: "View your summary",
                                          color: AppStyles.GraylightTextColor,
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          color: AppStyles.GraylightTextColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                bidlist.status == "0" || bidlist.status == "1" || bidlist.status == "3"
                                    ? IconButton(
                                        onPressed: () {
                                          controller.deleteCleanerBidApi(bidlist.id.toString(), index);
                                        },
                                        icon: Row(
                                          children: [
                                            Image.asset(
                                              "assets/icons/deleteIcon.png",
                                              height: 15,
                                            ),
                                            Textwidget(
                                              text: "Delete",
                                              color: AppStyles
                                                  .GraylightTextColor,
                                            )
                                          ],
                                        ))
                                    : const SizedBox(),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}

class BidListCoHost extends StatelessWidget {
  final RxList<BidListModel> cohostbidlist;

  BidListCoHost({
    super.key,
    required this.cohostbidlist,
  });

  final CleanerBidsListController controller =
      Get.find<CleanerBidsListController>();

  @override
  Widget build(BuildContext context) {
    log("controller.booking request == == = = = =${cohostbidlist.length}");
    return Obx(() => cohostbidlist.isEmpty
        ? NoDataFound(height: MediaQuery.of(context).size.height / 2)
        : Expanded(
          child: ListView.builder(
              itemCount: cohostbidlist.length,
              shrinkWrap: true,
              // physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (buildContext, index) {
                var bidlist = cohostbidlist[index];
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.zero,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppStyles.backgroundColor),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap:
                              bidlist.status == "2"
                                  ?(){
                                showModalBottomSheet(
                                    elevation: 0,
                                    backgroundColor: AppStyles
                                        .OnbordingBodybackgroundColor,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (builder) {
                                      return SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Textwidget(
                                                text: "Your Summary",
                                                color:
                                                AppStyles.appThemeColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Textwidget(
                                                text: "Address",
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    "assets/icons/locationIcons.png",
                                                    scale: 4.5,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Flexible(
                                                    child: Textwidget(
                                                      maxLines: 50,
                                                      text: bidlist
                                                          .summary[0].address,
                                                      fontSize: 13,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Divider(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                    25,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Flexible(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Textwidget(
                                                                text:
                                                                "Property Size ",
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w700,
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Image.asset(
                                                                    "assets/icons/home01.png",
                                                                    scale:
                                                                    4.5,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Flexible(
                                                                    child:
                                                                    Textwidget(
                                                                      maxLines:
                                                                      5,
                                                                      text: bidlist
                                                                          .summary[0]
                                                                          .propertySize,
                                                                      fontSize:
                                                                      13,
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Flexible(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Textwidget(
                                                                text:
                                                                "Services",
                                                                fontSize: 15,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w700,
                                                              ),
                                                              Textwidget(
                                                                maxLines: 5,
                                                                text: bidlist
                                                                    .serviceTitle,
                                                                fontSize: 13,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                    25,
                                              ),
                                              Textwidget(
                                                text: "Date and Time",
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/icons/calandericon.png",
                                                    scale: 4.5,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Textwidget(
                                                    text: bidlist.summary[0]
                                                        .bookingData
                                                        .toString(),
                                                    fontSize: 13,
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Image.asset(
                                                    "assets/icons/clockIcon.png",
                                                    scale: 3.5,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Textwidget(
                                                    text: bidlist.summary[0]
                                                        .bookingTime
                                                        .toString(),
                                                    fontSize: 13,
                                                  )
                                                ],
                                              ),
                                              Divider(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                    25,
                                              ),
                                              Textwidget(
                                                maxLines: 50,
                                                text: "Your Needs",
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    "assets/icons/describeicon.png",
                                                    scale: 4,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Flexible(
                                                      child: Textwidget(
                                                        maxLines: 100,
                                                        text: bidlist.summary[0]
                                                            .description,
                                                        fontSize: 13,
                                                      )),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Divider(
                                                height: 0,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }
                                  :() {
                                var data = {
                                  "bid_id": bidlist.id.toString(),
                                  "address": bidlist.address
                                };
                                Get.toNamed(Routes.NEW_CLEANER_BIDS_LIST,
                                    parameters: data);
                              },
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              "assets/icons/IconforHome.png",
                                              height: 30,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Textwidget(
                                                    maxLines: 5,
                                                    text: bidlist.address,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  Textwidget(
                                                    text: bidlist.created,
                                                    fontSize: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      bidlist.status == "2"
                                          ?Container(
                                        width: 80,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(18),
                                            color: AppStyles.AcceptColor
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                          child: Center(
                                              child: Text(
                                                textScaleFactor: 1,
                                                "Completed",
                                                style: TextStyle(
                                                    fontFamily: "JosefinSans",
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 10),
                                              )),
                                        ),
                                      )
                                          : Row(
                                        children: [
                                          Container(
                                            height: 25,
                                            width: 70,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: AppStyles.appThemeColor),
                                            child: Center(
                                              child: Textwidget(
                                                text: bidlist.totalBid.toString(),
                                                color: AppStyles.backgroundColor,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            size: 20,
                                            color: AppStyles.GraylightTextColor,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Divider(
                                    height: 0,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        elevation: 0,
                                        backgroundColor: AppStyles
                                            .OnbordingBodybackgroundColor,
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (builder) {
                                          return SingleChildScrollView(
                                            child: Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Textwidget(
                                                    text: "Your Summary",
                                                    color:
                                                        AppStyles.appThemeColor,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Textwidget(
                                                    text: "Address",
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Image.asset(
                                                        "assets/icons/locationIcons.png",
                                                        scale: 4.5,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Flexible(
                                                        child: Textwidget(
                                                          maxLines: 50,
                                                          text: bidlist
                                                              .summary[0].address,
                                                          fontSize: 13,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Divider(
                                                    height: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        25,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Flexible(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Textwidget(
                                                                    text:
                                                                        "Property Size ",
                                                                    fontSize: 15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                  Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Image.asset(
                                                                        "assets/icons/home01.png",
                                                                        scale:
                                                                            4.5,
                                                                      ),
                                                                      const SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      Flexible(
                                                                        child:
                                                                            Textwidget(
                                                                          maxLines:
                                                                              5,
                                                                          text: bidlist
                                                                              .summary[0]
                                                                              .propertySize,
                                                                          fontSize:
                                                                              13,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Flexible(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Textwidget(
                                                                    text:
                                                                        "Services",
                                                                    fontSize: 15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                  Textwidget(
                                                                    maxLines: 5,
                                                                    text: bidlist
                                                                        .serviceTitle,
                                                                    fontSize: 13,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(
                                                    height: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        25,
                                                  ),
                                                  Textwidget(
                                                    text: "Date and Time",
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/icons/calandericon.png",
                                                        scale: 4.5,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Textwidget(
                                                        text: bidlist.summary[0]
                                                            .bookingData
                                                            .toString(),
                                                        fontSize: 13,
                                                      ),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Image.asset(
                                                        "assets/icons/clockIcon.png",
                                                        scale: 3.5,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Textwidget(
                                                        text: bidlist.summary[0]
                                                            .bookingTime
                                                            .toString(),
                                                        fontSize: 13,
                                                      )
                                                    ],
                                                  ),
                                                  Divider(
                                                    height: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        25,
                                                  ),
                                                  Textwidget(
                                                    maxLines: 50,
                                                    text: "Your Needs",
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Image.asset(
                                                        "assets/icons/describeicon.png",
                                                        scale: 4,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Flexible(
                                                          child: Textwidget(
                                                        maxLines: 100,
                                                        text: bidlist.summary[0]
                                                            .description,
                                                        fontSize: 13,
                                                      )),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Divider(
                                                    height: 0,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Row(
                                    children: [
                                      Textwidget(
                                        text: "View your summary",
                                        color: AppStyles.GraylightTextColor,
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        color: AppStyles.GraylightTextColor,
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                bidlist.status == "0" || bidlist.status == "1" || bidlist.status == "3"
                                    ?   IconButton(
                                    onPressed: () {
                                      controller.deleteCoHostBidApi(
                                          bidlist.id.toString(), index);
                                    },
                                    icon: Row(
                                      children: [
                                        Image.asset(
                                          "assets/icons/deleteIcon.png",
                                          height: 15,
                                        ),
                                        Textwidget(
                                          text: "Delete",
                                          color: AppStyles.GraylightTextColor,
                                        )
                                      ],
                                    ))
                                    : const SizedBox(),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}
