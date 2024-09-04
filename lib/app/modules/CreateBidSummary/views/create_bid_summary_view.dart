import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/app/modules/CreateBidSummary/controllers/create_bid_summary_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';


class CreateBidSummaryView extends GetView<CreateBidSummaryController> {
  const CreateBidSummaryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyles.backgroundColor,
        appBar: AppBar(
          titleSpacing: 5,
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          surfaceTintColor: AppStyles.backgroundColor,
          elevation: 0,
          backgroundColor: AppStyles.backgroundColor,
          title: AppbarWithBackButton(
            text: "Summary",
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: false,
        ),
        body: Obx(() {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: AppStyles.appThemeColor.withOpacity(0.8)),
                        ),
                        child: Textwidget(
                          text: controller.serviceName.value,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppStyles.appThemeColor.withOpacity(0.8),
                        ),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              text: controller.summaryList['address'] ,
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                      Divider(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Textwidget(
                                        text: "Property Size ",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/icons/home01.png",
                                            scale: 4.5,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Flexible(
                                            child: Textwidget(
                                              maxLines: 5,
                                              text: controller.summaryList['property_size'],
                                              fontSize: 13,
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Textwidget(
                                        text: "Services",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      Textwidget(
                                        maxLines: 5,
                                        text: controller.summaryList['service_type'],
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
                        height: MediaQuery.of(context).size.height / 25,
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
                            text: controller.summaryList['property_date'],
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
                            text: controller.summaryList['property_time'],
                            fontSize: 13,
                          )
                        ],
                      ),
                      Divider(
                        height: MediaQuery.of(context).size.height / 25,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                text: controller.summaryList['description'],
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
              ),
              controller.isLoading.isTrue
                  ?ShowLoader.isLoadingProgress(controller.isLoading.value)
                  : const SizedBox()
            ],
          );
        }),
        bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
          child: MyButton(
              text: "Submit",
              onPressed: () {
                Get.toNamed(Routes.CONGRATS_SCREEN);
              },
              color: AppStyles.appThemeColor,
              TextColor: AppStyles.backgroundColor),
        ));
  }
}
