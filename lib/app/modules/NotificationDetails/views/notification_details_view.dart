import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/modules/NotificationDetails/controllers/notification_details_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';


class NotificationDetailsView extends GetView<NotificationDetailsController> {
  const NotificationDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyles.backgroundColor,

        appBar: AppBar(
          surfaceTintColor: AppStyles.backgroundColor,
          titleSpacing: 5,
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          elevation: 1,
          backgroundColor: AppStyles.backgroundColor,
          title: AppbarWithBackButton(
            text: '1555 N Rand Rd, Palatine',
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "assets/images/bookingRequest1.png",
                                fit: BoxFit.fill,
                              ),
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
                                  maxLines: 2,
                                  text: "Damirah Johnson",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                                Textwidget(
                                  text: "\$90.00 Per Hours",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                                Row(
                                  children: [
                                    RatingBar.builder(
                                      ignoreGestures: true,
                                      itemSize: 13,
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding:
                                          const EdgeInsets.symmetric(horizontal: 0.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {

                                       },
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Textwidget(
                                      text: "(126 Review)",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Get.toNamed(Routes.CHAT_SCREEN);
                        },
                        icon: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppStyles.appThemeColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              "assets/icons/Chat_Conversation.png",
                              height: 22,
                            ),
                          ),
                        ))
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Textwidget(
                          text: "Date and Time",
                          color: AppStyles.GrayTextColor,
                        ),
                        Textwidget(
                          text: "Monday, Oct 24",
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                        Textwidget(
                          text: "10:00 AM",
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                      color: AppStyles.GrayTextColor,
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
                ),
                const SizedBox(
                  height: 10,
                ),
                Textwidget(
                  text: "Price Details",
                  color: AppStyles.GrayTextColor,
                ),
                Textwidget(
                  text: "\$14/Hours",
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Textwidget(
                      text: "\$90 + 2 hours",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    Textwidget(
                      text: "\$180.00",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ],
                ),
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
                      text: "\$5.00",
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
                      fontSize: 14,
                    ),
                    Textwidget(
                      text: "\$185.00",
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: OutlineButton(
                        tectcolor: AppStyles.appThemeColor,
                        bordercolor: AppStyles.appThemeColor,
                        text: 'Reject',
                        onPressed: () {},
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: MyButton(
                        text: "Approved",
                        onPressed: () {},
                        color: AppStyles.appThemeColor,
                        TextColor: AppStyles.backgroundColor,
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
