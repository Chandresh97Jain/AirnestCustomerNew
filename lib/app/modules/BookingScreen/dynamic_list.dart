import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/cached_netword_image.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/nodata_image.dart';
import 'package:power_maids/app/modules/BookingScreen/booking_request_list.dart';
import 'package:power_maids/app/modules/BookingScreen/controllers/booking_screen_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';


class BookingRequestListView extends StatelessWidget {

  final RxList<BookingRequestModel> requestList;

  const BookingRequestListView({super.key,
    required this.requestList,
  });

  @override
  Widget build(BuildContext context) {

    Get.put(BookingScreenController());
   // final controller = BookingScreenController();
    log("controller.booking request == == = = = =${requestList.length}");
    return requestList.isEmpty
      ?NoDataFound(height: MediaQuery.of(context).size.height/2)
      :ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: requestList.length,

        itemBuilder: (buildContext, index) {

          var list = requestList[index];

          Color buttonColor;
          switch (list.status) {
            case "Pending":
              buttonColor = AppStyles.PendingColor;
              break;
            case "Accepted":
              buttonColor = AppStyles.AcceptColor;
              break;
            case "Cancelled":
              buttonColor = Colors.redAccent;
              break;
            case "Completed":
              buttonColor = Colors.teal;
              break;
            default:
              buttonColor = Colors.green; // Default color
            // case "Pending":
            //   buttonColor = AppStyles.PendingColor;
            //   break;
            // case "Complete":
            //   buttonColor = AppStyles.AcceptColor;
            //   break;
            // default:
            //   buttonColor = Colors.green; // Default color
          }

          Color textcolor;
          switch (list.status) {
            case "Pending":
              textcolor = AppStyles.BlackColor;
              break;
            case "Complete":
              textcolor = AppStyles.BlackColor;
              break;
            default:
              textcolor = Colors.black; // Default color
          }


          return InkWell(
            onTap: (){
              var data = {
                'booking_id' : list.id.toString(),
                'status' : list.status.toString(),
              };
              Get.toNamed(Routes.BOOKING_DETAIL,parameters: data);
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              child: Column(
                children: [
                  Row(
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
                                child: LoadingImage(image: list.avatar,fit: BoxFit.fill,)
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
                                    text: list.cleanerName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: RatingBar.builder(
                                          ignoreGestures: true,
                                          itemSize: 13,
                                          initialRating: list.rating.isEmpty?0.0:double.parse(list.rating.toString()),
                                          // initialRating: 3.4,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding:  const EdgeInsets.symmetric(
                                              horizontal: 0.0),
                                          itemBuilder: (context, _) => const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            log(rating.toString());
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Flexible(
                                        child: Textwidget(
                                          text: "(${list.review} Review)",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Textwidget(
                                        text: list.bookingDate+", ",
                                        fontSize: 11,
                                        color: AppStyles.GrayTextColor,
                                      ),
                                      Textwidget(
                                        text: list.bookingTime,
                                        fontSize: 11,
                                        color: AppStyles.GrayTextColor,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          RoundedButton(
                            text: list.status,
                            onPressed: () {},
                            color: buttonColor,
                            textcolor: textcolor,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Textwidget(
                            text: "\$${list.price}",
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ],
                      )
                    ],
                  ),
                  const
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1,
                    height: 0,
                    color: AppStyles.deviderColor,
                  )
                ],
              ),
            ),
          );
        });
  }
}

class BookingPreview extends StatelessWidget {
  final RxList<BookingRequestModel> hestoryList;


  const BookingPreview({super.key,
    required this.hestoryList,

  });

  @override
  Widget build(BuildContext context) {
    Get.put(BookingScreenController());
   // final controller = BookingScreenController();
    return hestoryList.isEmpty
        ?NoDataFound(height: MediaQuery.of(context).size.height/2)
        :ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: hestoryList.length,
        itemBuilder: (buildContext, index) {

          var historyList = hestoryList[index];

          Color buttonColor;
          switch (historyList.status) {

            case "Pending":
              buttonColor = AppStyles.PendingColor;
              break;
            case "Accepted":
              buttonColor = AppStyles.AcceptColor;
              break;
            case "Cancelled":
              buttonColor = Colors.redAccent;
              break;
            case "Completed":
              buttonColor = Colors.teal;
              break;
            default:
              buttonColor = Colors.green; // Default color

            // case "Canceled":
            //   buttonColor = AppStyles.appThemelightColor;
            //   break;
            // case "Accept":
            //   buttonColor = AppStyles.AcceptColor;
            //   break;
            // default:
            //   buttonColor = Colors.green; // Default color
          }

          Color textcolor;
          switch (historyList.status) {
            case "Canceled":
              textcolor = AppStyles.backgroundColor;
              break;
            case "Accept":
              textcolor = AppStyles.BlackColor;
              break;
            default:
              textcolor = Colors.black; // Default color
          }

          return InkWell(
            onTap: (){
              var data = {
                'booking_id' : historyList.id.toString(),
                'status' : historyList.status.toString(),

              };
              Get.toNamed(Routes.BOOKING_DETAIL,parameters: data);

            },
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                              child:  LoadingImage(image: historyList.avatar,fit: BoxFit.fill,)
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Textwidget(
                                text: historyList.cleanerName,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                              Textwidget(
                                text: historyList.bookingDate,
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                              ),
                              Textwidget(
                                text: historyList.bookingTime,
                                fontSize: 11,
                                color: AppStyles.GrayTextColor,
                              )
                            ],
                          )
                        ],
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            RoundedButton(
                              text: historyList.status,
                              onPressed: () {},
                              color: buttonColor,
                              textcolor: textcolor,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Textwidget(
                              text: "30 min before",
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1,
                    height: 0,
                    color: AppStyles.deviderColor,
                  )
                ],
              ),
            ),
          );
        });
  }


}
