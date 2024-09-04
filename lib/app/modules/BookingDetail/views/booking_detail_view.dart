import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/cached_netword_image.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/app/modules/BookingDetail/controllers/booking_detail_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';

class BookingDetailView extends GetView<BookingDetailController> {
  const BookingDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyles.backgroundColor,
        appBar: AppBar(
          surfaceTintColor: AppStyles.backgroundColor,
          titleSpacing: 5,
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: AppStyles.backgroundColor,
          title: AppbarWithBackButton(
            text: 'Booking Summary',
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: false,
        ),
        body: Obx(
          () => Stack(
            children: [
              controller.isLoading.isTrue
                  ? ShowLoader.isLoadingProgress(controller.isLoading.value)
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Textwidget(
                                  text: "Date and Time",
                                  color: AppStyles.GrayTextColor,
                                ),
                                Textwidget(
                                  text:
                                      controller.bookingSummary['booking_date'],
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                                Textwidget(
                                  text:
                                      controller.bookingSummary['booking_time'],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 1,
                              height: 0,
                              color: AppStyles.deviderColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: LoadingImage(
                                          image: controller
                                                  .bookingSummary['avatar'] ??
                                              "",
                                          fit: BoxFit.fill)),
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
                                        text: "Housekeeper",
                                        color: AppStyles.GrayTextColor,
                                      ),
                                      Textwidget(
                                        text: controller
                                            .bookingSummary['cleaner_name'],
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                      Textwidget(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        maxLines: 50,
                                        text: controller
                                            .bookingSummary['description'],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Divider(
                              thickness: 1,
                              height: 0,
                              color: AppStyles.deviderColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Textwidget(
                                  text: "Billing To",
                                  color: AppStyles.GrayTextColor,
                                ),
                                Textwidget(
                                  text:
                                      "${controller.fName.value} ${controller.lName.value}",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                                Textwidget(
                                  text: controller.address.value,
                                  maxLines: 15,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 1,
                              height: 0,
                              color: AppStyles.deviderColor,
                            ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // Textwidget(
                            //   text: "Price Details",
                            //   color: AppStyles.GrayTextColor,
                            // ),
                            // Textwidget(
                            //   text: "\$14/Hours",
                            //   fontWeight: FontWeight.w700,
                            //   fontSize: 15,
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Textwidget(
                            //       text: "\$7 + 2 hours",
                            //       fontWeight: FontWeight.w400,
                            //       fontSize: 14,
                            //       color: AppStyles.appThemeColor,
                            //     ),
                            //     Textwidget(
                            //       text: "\$14.00",
                            //       fontWeight: FontWeight.w400,
                            //       fontSize: 14,
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Textwidget(
                                  text: "Processing Fee",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                                Textwidget(
                                  text: "\$${controller.bookingSummary['admin_commission']}",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 1,
                              height: 0,
                              color: AppStyles.deviderColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Textwidget(
                                  text: "Total Price",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                                Textwidget(
                                  text:
                                      "\$${controller.bookingSummary['price']}",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 1,
                              height: 0,
                              color: AppStyles.deviderColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            Textwidget(
                              text: "Paid By Card",
                              fontWeight: FontWeight.w700,
                              fontSize: 15.5,
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Textwidget(
                                        text: "Bank of name",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      Textwidget(
                                        text: controller
                                            .bookingSummary['card_number'],
                                        color: AppStyles.GrayTextColor,
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  "assets/images/mastercard.png",
                                  scale: 2.5,
                                )
                              ],
                            ),

                            const SizedBox(
                              height: 30,
                            ),

                            Visibility(
                              visible: controller.status.value.toString() ==
                                  "Completed",
                              child: Center(
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      var data = {
                                        'booking_id': controller.bookingId.value
                                            .toString(),
                                        'cleaner_name': controller
                                            .bookingSummary['cleaner_name']
                                            .toString(),
                                        'cleaner_image': controller
                                            .bookingSummary['avatar']
                                            .toString(),
                                        'description': controller
                                            .bookingSummary['description']
                                            .toString(),
                                        'booking_date': controller
                                            .bookingSummary['booking_date']
                                            .toString(),
                                      };

                                      Get.toNamed(Routes.WRITEREVIEW,
                                          parameters: data);
                                    },
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppStyles.appThemeColor),
                                      child: const Center(
                                          child: Text(
                                        "Write a Review",
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            fontFamily: "JosefinSans",
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      )),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () => controller.isLoading.isTrue
              ? ShowLoader.isLoadingProgress(controller.isLoading.value)
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: MyButton(
                    text: "Track Project",
                    color: AppStyles.appThemeColor,
                    TextColor: AppStyles.backgroundColor,
                    onPressed: () {
                      var data = {
                        "booking_id": controller.bookingId.toString()
                      };

                      Get.toNamed(Routes.TRACK_YOURCLEANER_SCREEN,
                              parameters: data)!
                          .then((value) {
                        if (value == true) {
                          // Perform the refresh action here
                          controller.bookingSummaryApi(
                              controller.bookingId.value.toString());
                        }
                      });

                    },
                  ),
                ),
        ));
  }
}
