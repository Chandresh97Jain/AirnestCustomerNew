import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/app/modules/AddRequirementCleaner/controllers/add_requirement_cleaner_controller.dart';
import 'package:power_maids/app/modules/AddRequirementCleanerSummery/controllers/add_requirement_cleaner_summery_controller.dart';
import 'package:power_maids/app/modules/ExtraworkAddScreen/priceforairbnb_dynamic_ui.dart';



class AddRequirementCleanerSummeryView extends GetView<AddRequirementCleanerSummeryController> {
  const AddRequirementCleanerSummeryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AddRequirementCleanerController addRequirementCleanerController =  Get.put(AddRequirementCleanerController());
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
        body:Obx(() => Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            text: addRequirementCleanerController.googleMapService.addressController.value.text,
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),


                    if(controller.serviceId.value == "1" || controller.serviceId.value == "2" || controller.serviceId.value == "4")
                     SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: addRequirementCleanerController.serviceLableId.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (buildContext, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                            width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Divider(
                                    height: MediaQuery.of(context).size.height / 25,
                                  ),
                                  Textwidget(
                                    text: addRequirementCleanerController.serviceTitleList[index],
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  Row(
                                    children: [
                                      addRequirementCleanerController.serviceTitleList[index] == "Per Bedroom"
                                          ? Image.asset(
                                        "assets/icons/bedroom.png",
                                        scale: 4,
                                      )
                                          : addRequirementCleanerController.serviceTitleList[index] == "Per Bathroom"
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
                                        width: 5,
                                      ),
                                      Flexible(
                                        child: Textwidget(
                                          text: addRequirementCleanerController.serviceQtyList[index].toString(),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                    else if(controller.serviceId.value == "3")
                      const SizedBox()
                    else
                      const SizedBox(),

                    // Expanded(
                    //   child: Row(
                    //     children: [
                    //       Flexible(
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Textwidget(
                    //               text: "Bedroom",
                    //               fontSize: 15,
                    //               fontWeight: FontWeight.w700,
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Image.asset(
                    //                   "assets/icons/bedroom.png",
                    //                   scale: 4.5,
                    //                 ),
                    //                 const SizedBox(
                    //                   width: 5,
                    //                 ),
                    //                 Flexible(
                    //                   child: Textwidget(
                    //                     text: "03",
                    //                     fontSize: 13,
                    //                   ),
                    //                 )
                    //               ],
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Expanded(
                    //   child: Row(
                    //     children: [
                    //       Flexible(
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Textwidget(
                    //               text: "Bathroom ",
                    //               fontSize: 15,
                    //               fontWeight: FontWeight.w700,
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Image.asset(
                    //                   "assets/icons/bathroom.png",
                    //                   scale: 4.5,
                    //                 ),
                    //                 const SizedBox(
                    //                   width: 5,
                    //                 ),
                    //                 Flexible(
                    //                   child: Textwidget(
                    //                     text: "04",
                    //                     fontSize: 13,
                    //                   ),
                    //                 )
                    //               ],
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
                                            text: addRequirementCleanerController.propertySizeSQFT.toString(),
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
                                      text: "Supplies ",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          "assets/icons/cleaner01.png",
                                          scale: 4.5,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Flexible(
                                          child: Textwidget(
                                            maxLines: 5,
                                            text: "Provided by Customer",
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
                          text: DateFormat('d MMM, yyyy').format(addRequirementCleanerController.selectedDate.value!),
                          // text: addRequirementCleanerController.selectedDate.toString(),
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
                          text: controller.formatTimeOfDay(addRequirementCleanerController.selectedTime.value),
                          // text: addRequirementCleanerController.selectedTime,
                          fontSize: 13,
                        )
                      ],
                    ),
                    Divider(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    Textwidget(
                      maxLines: 50,
                      text: "Add a note below about any special requirements",
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
                              text: addRequirementCleanerController.needsTextController.text,
                              fontSize: 13,
                            )),
                      ],
                    ),
                    const SizedBox(height: 10,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Textwidget(
                          maxLines: 5,
                          text: "Price for ${addRequirementCleanerController.serviceName.value}",
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                        const Divider(

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

                      ],) ,

                    const Divider(
                      height: 10,
                    ),
                    const SizedBox(height: 10,),
                    // Textwidget(
                    //   maxLines: 50,
                    //   text: "Some extras works",
                    //   fontSize: 15,
                    //   fontWeight: FontWeight.w700,
                    // ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // GridView.builder(
                    //     shrinkWrap: true,
                    //     itemCount: controller.someextraworklist.length,
                    //     physics: const NeverScrollableScrollPhysics(),
                    //     gridDelegate: (const SliverGridDelegateWithFixedCrossAxisCount(
                    //         crossAxisSpacing: 10,
                    //         crossAxisCount: 2, childAspectRatio: 4)),
                    //     itemBuilder: (buildContext, index) {
                    //       return Textwidget(
                    //         textscalefector: 1,
                    //         fontWeight: FontWeight.w300,
                    //         fontSize: 13.5,
                    //         maxLines: 2,
                    //         text: controller.someextraworklist[index],
                    //       );
                    //     })
                  ],
                ),
              ),
            ),
            ShowLoader.isLoadingProgress(controller.isLoading.value)
          ],
        ),),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
          child: MyButton(
              text: "Submit",
              onPressed: () {
                if(controller.serviceId.value == "1" || controller.serviceId.value == "2" || controller.serviceId.value == "4"){
                  controller.cleanerPropertyAddApiForSD();
                }else if(controller.serviceId.value == "3" || controller.serviceId.value == "6"){
                  controller.cleanerPropertyAddApiForSqrFet();
                }else{
                  controller.cleanerPropertyAddApiForHourly();
                }
              },
              color: AppStyles.appThemeColor,
              TextColor: AppStyles.backgroundColor),
        ));
  }
}
