import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/modules/ReviewBookingDetail/controllers/review_booking_detail_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';


class ReviewBookingDetailView extends GetView<ReviewBookingDetailController> {
  const ReviewBookingDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 15,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: AppStyles.backgroundColor,
        title: AppbarWithBackButton(
          text: 'Review Booking Detail',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                text: "Housekeeper",
                                color: AppStyles.GrayTextColor,
                              ),
                              Textwidget(
                                text: "Damirah Johnson",
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                              Textwidget(
                                fontWeight: FontWeight.w200,
                                maxLines: 50,
                                text:
                                    "Residential Deep Cleaning 6+ bed/bath- hourly rate (min 5 hours), Short Term Rental 1 Bed 1 Bath, One Time 3 Bed3 Bath, One Time 4 Bed 4 Bath",
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 18,
                    color: AppStyles.GrayTextColor,
                  )
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
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Textwidget(
                          text: "My Address",
                          color: AppStyles.GrayTextColor,
                        ),
                        Textwidget(
                          maxLines: 5,
                          text: "San Francisco, California",
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                        Textwidget(
                          text: "Home",
                        ),
                      ],
                    ),
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
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Textwidget(
                    text: "\$7 + 2 hours",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  Textwidget(
                    text: "\$14.00",
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
                    fontSize: 15,
                  ),
                  Textwidget(
                    text: "\$19.00",
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(  bottom: 8, top:30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyButtonwithIcon(
                      text: 'Pay with link',
                      onPressed: () {},
                      color: AppStyles.buttonwithIconcolor,

                      Textcolor: AppStyles.BlackColor,
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        const Expanded(child: Divider(
                          color: Colors.black,
                          thickness: 1,
                          endIndent: 20,
                          indent: 100,

                        )),
                        Textwidget(text: "OR",fontWeight: FontWeight.w700,),

                        const Expanded(child: Divider(
                          color: Colors.black,
                          thickness: 1,
                          endIndent: 100,
                          indent: 20,

                        )),

                      ],),
                  const   SizedBox(height: 15,),

                    MyButton(
                      onPressed: () {
                        Get.toNamed(Routes.BOOKING_SUMMARY);
                      },
                      text: "Proceed To Payment",
                      color: AppStyles.appThemeColor, TextColor: AppStyles.backgroundColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
     );
  }
}
