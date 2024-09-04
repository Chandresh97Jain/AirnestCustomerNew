import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/app/modules/AddRequirementCleaner/controllers/add_requirement_cleaner_controller.dart';
import 'package:power_maids/app/modules/ExtraworkAddScreen/controllers/extrawork_add_screen_controller.dart';
import 'package:power_maids/app/modules/ExtraworkAddScreen/priceforairbnb_dynamic_ui.dart';
import 'package:power_maids/app/routes/app_pages.dart';


class ExtraworkAddScreenView extends GetView<ExtraworkAddScreenController> {
  const ExtraworkAddScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AddRequirementCleanerController addRequirementCleanerController = Get.put(AddRequirementCleanerController());
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
          // text: controller.title.value,
          text: "Add Addtional Services",
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: false,
      ),
      body: Obx(() => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 5, bottom: 10),
              child: Textwidget(
                maxLines: 5,
                text: "Do you need some extras?",
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            controller.isLoading.isTrue
            ?SizedBox(
              height: MediaQuery.of(context).size.height/3,
              child: Center(
                child: ShowLoader.isLoadingProgress(controller.isLoading.value),
              ),
            )
            :ListView.builder(
                itemCount: controller.extraServiceList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (buildContext, index) {
                  final itemName = 'Item $index';
                  var extraSlist = controller.extraServiceList[index];

                  return InkWell(
                    onTap: () {
                      controller.toggleItemSelection(extraSlist.id.toString());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                Obx(() => controller.isItemSelected(extraSlist.id.toString())
                                    ? Container(
                                  height: 34.5,
                                  width: 34.5,
                                  decoration: BoxDecoration(
                                      color: AppStyles.appThemeColor),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/icons/L.png",
                                      height: 15,
                                    ),
                                  ),
                                )
                                    : Image.asset(
                                  "assets/icons/notselectedicon.png",
                                  height: 35,
                                )),
                                const SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                  child: Textwidget(
                                    text: extraSlist.title,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Textwidget(
                            text:
                            "+\$${extraSlist.price} Price ",
                          )
                        ],
                      ),
                    ),
                  );
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Textwidget(
                      maxLines: 5,
                      text: "Price for ${controller.serviceName.value}",
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Divider(
                    endIndent: 12,
                    indent: 12,
                    thickness: 0.8,
                  ),

                  if(controller.serviceId.value == "1" || controller.serviceId.value == "2" || controller.serviceId.value == "4")
                    ListView.builder(
                        itemCount: addRequirementCleanerController.serviceLableId.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (buildContext, index){
                          // var lable = controller.priceLabels[index];

                          return Padding(
                            padding:
                            const EdgeInsets.only(left: 12, right: 12, bottom: 10),
                            child: PriceforAirbnb(
                                title: addRequirementCleanerController.serviceTitleList[index],
                                totalprice: "\$${addRequirementCleanerController.serviceTotalPriceList[index]}",
                                price: "\$${addRequirementCleanerController.serviceActualPrice[index]}",
                                counttext: addRequirementCleanerController.serviceQtyList[index].toString()),
                          );
                        }
                    )
                  else if(controller.serviceId.value == "3" || controller.serviceId.value == "6")
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5),
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/icons/Vector (3).png",
                            scale: 3,
                            color: AppStyles.appThemeColor,
                          ),
                          const SizedBox(width: 15,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Textwidget(
                                text: "${addRequirementCleanerController.sQft.value} Sq.ft" ,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                              Textwidget(
                                text: "\$${addRequirementCleanerController.totalSqftPrice.value} - ${
                                    addRequirementCleanerController.selectServiceWeeklySqrFeel.value == "0"
                                        ?"Week"
                                        :addRequirementCleanerController.selectServiceWeeklySqrFeel.value == "1"
                                        ?"Bi Week"
                                        :"Month"
                                }",
                                color: AppStyles.appThemeColor,
                              ),
                            ],
                          ),
                        ],
                      )
                    )  // suqer feet
                  else
                    Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image.asset(
                            //   "assets/icons/Vector (5).png",
                            //   scale: 4,
                            //   color: AppStyles.appThemeColor,
                            // ),
                            // SizedBox(width: 5,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Textwidget(
                                      text:addRequirementCleanerController.selectServiceWeeklyHourly.value == "0"
                                          ? "Weekly"
                                      :addRequirementCleanerController.selectServiceWeeklyHourly.value == "1"
                                      ?'Bi Weekly'
                                      :"Monthly",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Textwidget(
                                      text: "\$${addRequirementCleanerController.actualHourlyPrice.value}",
                                      fontSize: 12,
                                      color: AppStyles.appThemeColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Image.asset(
                                      "assets/icons/cancelicon.png",
                                      color: AppStyles.appThemeColor,
                                      scale: 7.5,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Textwidget(
                                      textscalefector: 1,
                                      text: addRequirementCleanerController.hourQty.value,
                                      fontWeight: FontWeight.w700,
                                      color: AppStyles.appThemeColor,
                                      fontSize: 12,
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        Textwidget(
                          text: "\$${addRequirementCleanerController.totalHourlyPrice.value}",
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ],
                    ),
                  )



                  // const Padding(
                  //   padding:
                  //   EdgeInsets.only(left: 12, right: 12, bottom: 10),
                  //   child: PriceforAirbnb(
                  //       title: "Bedroom",
                  //       totalprice: "\$90.00",
                  //       price: "\$30",
                  //       counttext: "3"),
                  // ),
                  // const Padding(
                  //   padding:
                  //   EdgeInsets.only(left: 12, right: 12, bottom: 15),
                  //   child: PriceforAirbnb(
                  //     title: "Bathroom",
                  //     totalprice: "\$80.00",
                  //     price: "\$20",
                  //     counttext: "4",
                  //   ),
                  // )
                ],
              ))
          ],
        ),
      ),),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
        child: MyButton(
            text: "Next",
            onPressed: () {

              log("Total price ---- - - - >>> ${addRequirementCleanerController.totalPayment}");

              var data = {
                // "title": controller.title.toString(),
                // "id": controller.id.toString(),
                "zip_code": controller.zipCode.toString(),
                "user_type": controller.userType.toString(),
                "cleaner_cohost_id": controller.cleanerCohostId.toString(),
                "service_id": controller.serviceId.toString(),
                "service_name": controller.serviceName.toString(),
              };

              Get.toNamed(Routes.ADD_REQUIREMENT_CLEANER_SUMMERY,
                  parameters: data);
            },
            color: AppStyles.appThemeColor,
            TextColor: AppStyles.backgroundColor),
      ),
    );
  }
}
