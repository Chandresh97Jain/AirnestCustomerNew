import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/modules/PaymentSuccessfulScreen/controllers/payment_successful_screen_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';


class PaymentSuccessfulScreenView
    extends GetView<PaymentSuccessfulScreenController> {
  const PaymentSuccessfulScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyles.appThemeColor,
        body: Obx(() => SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  Textwidget(
                    maxLines: 50,
                    textAlign: TextAlign.center,
                    text: "Payment Successful Please enjoy our service",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppStyles.backgroundColor,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Image.asset(
                    "assets/icons/right.png",
                    scale: 2,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Textwidget(
                    maxLines: 50,
                    textAlign: TextAlign.center,
                    text:
                    "Your payment is currently being processed. You will receve a notification with payment confirmation.",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppStyles.backgroundColor,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Textwidget(
                    maxLines: 50,
                    textAlign: TextAlign.center,
                    text: "Booking ID: #${controller.bookingId.value}",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppStyles.backgroundColor,
                  ),
                  TextButton(
                    onPressed: () {
                      var data = {
                        'booking_id' : controller.bookingId.value.toString()
                      };
                      Get.toNamed(Routes.TRACK_YOURCLEANER_SCREEN,parameters: data);
                    },
                    child: Textwidget(
                      maxLines: 50,
                      textAlign: TextAlign.center,
                      text: "View my booking",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppStyles.backgroundColor,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  OutlineButton(
                    tectcolor: AppStyles.backgroundColor,
                    bordercolor: AppStyles.backgroundColor,
                    onPressed: () {
                      Get.offAllNamed(Routes.DESHBOARD);
                    },
                    text: "Go to Home",
                  )
                ],
              ),
            ),
          ),
        ))
    );
  }
}
