import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/ratingbar_global.dart';
import 'package:power_maids/app/modules/TrackYourcleanerScreen/controllers/track_yourcleaner_screen_controller.dart';

class TrackYourcleanerScreenView
    extends GetView<TrackYourcleanerScreenController> {
  const TrackYourcleanerScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color activeColor = Colors.green;
    Color? inactiveColor = Colors.grey[300];
    return Obx(() => WillPopScope(
      onWillPop: () async {
        Get.back(result: true);
        // Your custom back button handling logic
        return true; // Return true to allow popping, false to prevent
      },      child: Scaffold(
            backgroundColor: AppStyles.backgroundColor,
            appBar: AppBar(
              surfaceTintColor: AppStyles.backgroundColor,
              titleSpacing: 5,
              toolbarHeight: 70,
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: AppStyles.backgroundColor,
              title: AppbarWithBackButton(
                text: 'Booking Tracking',
                onPressed: () {
                  Get.back(result: true);
                },
              ),
              centerTitle: false,
            ),
            body: controller.isLoading.isFalse
                ? Visibility(
                    visible: controller.bookingList.isNotEmpty,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 10),
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
                                      text: controller.bookingList[0].address,
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
                                          child: CachedNetworkImage(
                                            imageUrl: ApiService.imageURL +
                                                controller.bookingList[0].avatar,
                                            fit: BoxFit.fill,
                                          ),
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
                                              text: controller
                                                  .bookingList[0].cleanerName,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                            ),
                                            Textwidget(
                                              text:
                                                  "\$${controller.bookingList[0].price.toString()}",
                                            ),
                                            Row(
                                              children: [
                                                const RatingBarGlobal(
                                                  initialRating: 3.5,
                                                  //  initialRating: double.tryParse(controller.bookingList[0].rating.toString()) ?? 0.0,
                                                  ignoreGestures: true,
                                                ),
                                                Flexible(
                                                  child: Textwidget(
                                                    text:
                                                        "(${controller.bookingList[0].review.toString()} Review)",
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
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
                              text: "Date",
                            ),
                            Textwidget(
                              text: controller.bookingList[0].date.toString(),
                              fontWeight: FontWeight.w700,
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            //--------- STATUS----------//

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(
                                                color: controller.bookingList[0].cleanerReachedHome.isEmpty? inactiveColor :  activeColor ?? Colors.pink,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Flexible(
                                            child: Textwidget(
                                              fontSize: 16,
                                              text: "Cleaner Reached Property",
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      flex: 0,
                                      child: Textwidget(
                                          fontSize: 16,
                                            text: controller.bookingList[0].cleanerReachedHome,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6),
                                      child: SizedBox(
                                        width: 2,
                                        height: 60,
                                        // height: widget.orderTitleAndDateList != null &&
                                        //     widget.orderTitleAndDateList!.isNotEmpty
                                        //     ? widget.orderTitleAndDateList!.length * 46
                                        //     : 60,
                                        child: RotatedBox(
                                          quarterTurns: 1,
                                          child: LinearProgressIndicator(
                                            // value: controller?.value ?? 0.0,
                                            backgroundColor: controller.bookingList[0].cleanerStartedWork.isEmpty? inactiveColor : activeColor ?? Colors.grey[300],
                                            color: controller.bookingList[0].cleanerStartedWork.isEmpty? inactiveColor :  activeColor ?? Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(
                                                color: controller.bookingList[0].cleanerStartedWork.isEmpty? inactiveColor : activeColor ?? Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Flexible(
                                            child: Textwidget(
                                              fontSize: 16,
                                              text: "Cleaner Started Project",
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Textwidget(
                                        fontSize: 16,
                                        text: controller.bookingList[0].cleanerStartedWork,
                                        color: Colors.grey),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6),
                                      child: SizedBox(
                                        width: 2,
                                        height: 60,
                                        // height: widget.orderTitleAndDateList != null &&
                                        //     widget.orderTitleAndDateList!.isNotEmpty
                                        //     ? widget.orderTitleAndDateList!.length * 46
                                        //     : 60,
                                        child: RotatedBox(
                                          quarterTurns: 1,
                                          child: LinearProgressIndicator(
                                            // value: controller?.value ?? 0.0,
                                            backgroundColor: controller.bookingList[0].cleanerCompletedWork.isEmpty? inactiveColor : activeColor ?? Colors.grey[300],
                                            color: controller.bookingList[0].cleanerCompletedWork.isEmpty? inactiveColor :  activeColor ?? Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(
                                                color: controller.bookingList[0].cleanerCompletedWork.isEmpty? inactiveColor : activeColor ?? Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Flexible(
                                            child: Textwidget(
                                              fontSize: 16,
                                              text: "Completed Project",
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Textwidget(
                                        fontSize: 16,
                                        text: controller.bookingList[0].cleanerCompletedWork,
                                        color: Colors.grey),
                                  ],
                                ),
                              ],
                            ),

                            //--------- STATUS----------//

                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     Row(
                            //       children: [
                            //         Container(
                            //           height: 15,
                            //           width: 15,
                            //           decoration: BoxDecoration(
                            //               color: (widget.status?.name == Status.shipped.name ||
                            //                   widget.status?.name ==
                            //                       Status.outOfDelivery.name ||
                            //                   widget.status?.name ==
                            //                       Status.delivered.name) &&
                            //                   isFirst == true
                            //                   ? widget.activeColor ?? Colors.green
                            //                   : widget.inActiveColor ?? Colors.grey[300],
                            //               borderRadius: BorderRadius.circular(50)),
                            //         ),
                            //         const SizedBox(
                            //           width: 20,
                            //         ),
                            //         Text.rich(
                            //           TextSpan(
                            //             children: [
                            //               TextSpan(
                            //                   text: "Shipped ",
                            //                   style: widget.headingTitleStyle ??
                            //                       const TextStyle(
                            //                           fontSize: 16, fontWeight: FontWeight.bold)),
                            //               TextSpan(
                            //                 text: "Fri, 28th Mar '22",
                            //                 style: widget.headingDateTextStyle ??
                            //                     const TextStyle(fontSize: 16, color: Colors.grey),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     Row(
                            //       children: [
                            //         Padding(
                            //           padding: const EdgeInsets.only(left: 6),
                            //           child: SizedBox(
                            //             width: 2,
                            //             height: widget.shippedTitleAndDateList != null &&
                            //                 widget.shippedTitleAndDateList!.isNotEmpty
                            //                 ? widget.shippedTitleAndDateList!.length * 56
                            //                 : 60,
                            //             child: RotatedBox(
                            //               quarterTurns: 1,
                            //               child: LinearProgressIndicator(
                            //                 value: controller2?.value ?? 0.0,
                            //                 backgroundColor:
                            //                 widget.inActiveColor ?? Colors.grey[300],
                            //                 color: isFirst == true
                            //                     ? widget.activeColor ?? Colors.green
                            //                     : widget.inActiveColor ?? Colors.grey[300],
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //         const SizedBox(
                            //           width: 30,
                            //         ),
                            //         Expanded(
                            //           child: ListView.separated(
                            //               shrinkWrap: true,
                            //               padding: EdgeInsets.zero,
                            //               itemBuilder: (context, index) {
                            //                 return Column(
                            //                   mainAxisAlignment: MainAxisAlignment.start,
                            //                   crossAxisAlignment: CrossAxisAlignment.start,
                            //                   children: [
                            //                     Text(
                            //                       widget.shippedTitleAndDateList?[index].title ??
                            //                           "",
                            //                       style: widget.subTitleTextStyle ??
                            //                           const TextStyle(fontSize: 14),
                            //                     ),
                            //                     const SizedBox(
                            //                       height: 4,
                            //                     ),
                            //                     Text(
                            //                       widget.shippedTitleAndDateList?[index].date ?? "",
                            //                       style: widget.subDateTextStyle ??
                            //                           TextStyle(
                            //                               fontSize: 14, color: Colors.grey[300]),
                            //                     )
                            //                   ],
                            //                 );
                            //               },
                            //               separatorBuilder: (context, index) {
                            //                 return const SizedBox(
                            //                   height: 4,
                            //                 );
                            //               },
                            //               itemCount: widget.shippedTitleAndDateList != null &&
                            //                   widget.shippedTitleAndDateList!.isNotEmpty
                            //                   ? widget.shippedTitleAndDateList!.length
                            //                   : 0),
                            //         )
                            //       ],
                            //     ),
                            //   ],
                            // ),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     Row(
                            //       children: [
                            //         Container(
                            //           height: 15,
                            //           width: 15,
                            //           decoration: BoxDecoration(
                            //               color:
                            //               (widget.status?.name == Status.outOfDelivery.name ||
                            //                   widget.status?.name ==
                            //                       Status.delivered.name) &&
                            //                   isSecond == true
                            //                   ? widget.activeColor ?? Colors.green
                            //                   : widget.inActiveColor ?? Colors.grey[300],
                            //               borderRadius: BorderRadius.circular(50)),
                            //         ),
                            //         const SizedBox(
                            //           width: 20,
                            //         ),
                            //         Text.rich(
                            //           TextSpan(
                            //             children: [
                            //               TextSpan(
                            //                   text: "Out of delivery ",
                            //                   style: widget.headingTitleStyle ??
                            //                       const TextStyle(
                            //                           fontSize: 16, fontWeight: FontWeight.bold)),
                            //               TextSpan(
                            //                 text: "Fri, 29th Mar '22",
                            //                 style: widget.headingDateTextStyle ??
                            //                     const TextStyle(fontSize: 16, color: Colors.grey),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     Row(
                            //       children: [
                            //         Padding(
                            //           padding: const EdgeInsets.only(left: 6),
                            //           child: SizedBox(
                            //             width: 2,
                            //             height: widget.outOfDeliveryTitleAndDateList != null &&
                            //                 widget.outOfDeliveryTitleAndDateList!.isNotEmpty
                            //                 ? widget.outOfDeliveryTitleAndDateList!.length * 56
                            //                 : 60,
                            //             child: RotatedBox(
                            //               quarterTurns: 1,
                            //               child: LinearProgressIndicator(
                            //                 value: controller3?.value ?? 0.0,
                            //                 backgroundColor:
                            //                 widget.inActiveColor ?? Colors.grey[300],
                            //                 color: isSecond == true
                            //                     ? widget.activeColor ?? Colors.green
                            //                     : widget.inActiveColor ?? Colors.grey[300],
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //         const SizedBox(
                            //           width: 30,
                            //         ),
                            //         Expanded(
                            //           child: ListView.separated(
                            //               shrinkWrap: true,
                            //               padding: EdgeInsets.zero,
                            //               itemBuilder: (context, index) {
                            //                 return Column(
                            //                   mainAxisAlignment: MainAxisAlignment.start,
                            //                   crossAxisAlignment: CrossAxisAlignment.start,
                            //                   children: [
                            //                     Text(
                            //                       widget.outOfDeliveryTitleAndDateList?[index]
                            //                           .title ??
                            //                           "",
                            //                       style: widget.subTitleTextStyle ??
                            //                           const TextStyle(fontSize: 14),
                            //                     ),
                            //                     const SizedBox(
                            //                       height: 4,
                            //                     ),
                            //                     Text(
                            //                       widget.outOfDeliveryTitleAndDateList?[index]
                            //                           .date ??
                            //                           "",
                            //                       style: widget.subDateTextStyle ??
                            //                           TextStyle(
                            //                               fontSize: 14, color: Colors.grey[300]),
                            //                     )
                            //                   ],
                            //                 );
                            //               },
                            //               separatorBuilder: (context, index) {
                            //                 return const SizedBox(
                            //                   height: 4,
                            //                 );
                            //               },
                            //               itemCount: widget.outOfDeliveryTitleAndDateList != null &&
                            //                   widget.outOfDeliveryTitleAndDateList!.isNotEmpty
                            //                   ? widget.outOfDeliveryTitleAndDateList!.length
                            //                   : 0),
                            //         )
                            //       ],
                            //     ),
                            //   ],
                            // ),
                            // OrderTracker(
                            //   status: Status.delivered,
                            //   activeColor: AppStyles.appThemeColor,
                            //   inActiveColor: Colors.grey[300],
                            //   //  orderTitleAndDateList: orderList,
                            //   // shippedTitleAndDateList: shippedList,
                            //   // outOfDeliveryTitleAndDateList: outOfDeliveryList,
                            //   // deliveredTitleAndDateList: deliveredList,
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
                            //   fontSize: 15,
                            //   fontWeight: FontWeight.w700,
                            //   text: "Please Give Rating",
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     RatingBar.builder(
                            //       itemSize: 30,
                            //       initialRating: 3,
                            //       minRating: 1,
                            //       direction: Axis.horizontal,
                            //       allowHalfRating: true,
                            //       itemCount: 5,
                            //       itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                            //       itemBuilder: (context, _) => Icon(
                            //         Icons.star,
                            //         color: AppStyles.StarIconColor,
                            //       ),
                            //       onRatingUpdate: (rating) {
                            //        // print(rating);
                            //       },
                            //     ),
                            //     Flexible(
                            //       child: TextButton(
                            //           onPressed: () {},
                            //           child: Textwidget(
                            //             textscalefector: 1,
                            //             color: AppStyles.appThemeColor,
                            //             fontWeight: FontWeight.w700,
                            //
                            //             text: "Submit Rating",
                            //           )),
                            //     )
                            //   ],
                            // ),

                          ],
                        ),
                      ),
                    ),
                  )
                : ShowLoader.isLoadingProgress(controller.isLoading.value),
          ),
    ));
  }
}
