import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/textformfield_ui_global.dart';
import 'package:power_maids/app/modules/AddRequirementCleaner/controllers/add_requirement_cleaner_controller.dart';

class AddRequirementCleanerView
    extends GetView<AddRequirementCleanerController> {
  const AddRequirementCleanerView({Key? key}) : super(key: key);
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
          text: "Add Your Requirement",
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: false,
      ),
      body: Obx(
        () => Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Textwidget(
                      text: "Confirm your property details",
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    // Select my property
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppStyles.TextformfeildOutlineColor,
                              width: 0.7)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Image.asset(
                              "assets/images/property.png",
                              scale: 23,
                              color: AppStyles.appThemeColor,
                            ),
                            Obx(() => Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 25),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          alignment: Alignment.centerLeft,
                                          hint: const Text(
                                            "Select your property (Optional)",
                                            style: TextStyle(
                                              color: Color(0xff5d5d5d),
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              letterSpacing: 0.8,
                                              fontFamily: 'JosefinSans',
                                            ),
                                          ),
                                          value: controller.show2.value == true
                                              ? controller
                                                  .selectPropertyId.value
                                                  .toString()
                                              : null,
                                          icon: controller
                                                      .selectPropertyId.value ==
                                                  null
                                              ? Icon(Icons
                                                  .keyboard_arrow_down_outlined)
                                              : InkWell(
                                                  onTap: () {
                                                    controller
                                                        .propertySizeSQFT_pro
                                                        .value = "";
                                                    controller.selectPropertyId
                                                        .value = null;
                                                    controller
                                                        .googleMapService
                                                        .addressController
                                                        .value
                                                        .text = "";
                                                    controller.googleMapService
                                                        .latitude.value = "";
                                                    controller.googleMapService
                                                        .longitude.value = "";
                                                    controller
                                                        .nameTextController
                                                        .value
                                                        .text = "";
                                                    controller.show.value =
                                                        false;
                                                    controller.show2.value =
                                                        false;
                                                  },
                                                  child: Icon(Icons.close)),
                                          iconSize: 24,
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          underline: Container(),
                                          onChanged: (newValue) {
                                            controller.show2.value = true;
                                            controller.show.value = true;
                                            controller.selectPropertyId.value =
                                                newValue.toString();

                                            log("newValue  --  -- ${newValue.toString()}");
                                          },
                                          items: controller.propertyList
                                              .map((item) {
                                            return DropdownMenuItem<String>(
                                              onTap: () {
                                                controller.show2.value = true;
                                                controller.show.value = true;
                                                controller.propertySizeSQFT_pro
                                                        .value =
                                                    "${item.propertySize.toString()}";
                                                controller
                                                    .googleMapService
                                                    .addressController
                                                    .value
                                                    .text = "${item.address}";
                                                controller
                                                    .googleMapService
                                                    .latitude
                                                    .value = "${item.latitude}";
                                                controller.googleMapService
                                                        .longitude.value =
                                                    "${item.longitude}";
                                                controller
                                                    .nameTextController
                                                    .value
                                                    .text = "${item.name}";

                                                log("property-size --  -- ${controller.propertySizeSQFT_pro.value.toString()}");
                                                log("address --  -- ${item.address.toString()}");
                                                log("name --  -- ${item.name.toString()}");
                                                log("lalitude --  -- ${item.latitude.toString()}");
                                                log("longitude --  -- ${item.longitude.toString()}");

                                                controller.propertySizeSQFT
                                                        .value =
                                                    "${controller.propertySizeSQFT_pro.value}";
                                                var splittext = controller
                                                    .propertySizeSQFT.value!
                                                    .split(' ');
                                                var size = splittext[1];
                                                controller.propertySizeSqrFeet
                                                    .value = size.toString();
                                              },
                                              value: item.id
                                                  .toString(), // Ensure unique value
                                              child: Text(
                                                item.name,
                                                style: const TextStyle(
                                                    fontFamily: "JosefinSans"),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      )),
                                )),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),
                    TextFieldDesignedOutline(
                      enabled: controller.selectPropertyId.value == null
                          ? true
                          : false,
                      controller: controller.nameTextController.value,
                      prefixIcon: SizedBox(
                        width: 10,
                        height: 60,
                        child: Image.asset(
                          "assets/icons/fn.png",
                          scale: 3.5,
                        ),
                      ),
                      hintText: "Property Name",
                      keyboardType: TextInputType.text,
                      maxLength: 30,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(() => TextFieldDesignedOutline(
                          enabled: controller.selectPropertyId.value == null
                              ? true
                              : false,
                          controller: controller
                              .googleMapService.addressController.value,
                          prefixIcon: SizedBox(
                            width: 10,
                            height: 60,
                            child: Image.asset(
                              "assets/icons/addressIcon.png",
                              scale: 3.5,
                            ),
                          ),
                          hintText: "Address",
                          keyboardType: TextInputType.text,
                          maxLength: 100,
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (controller.googleMapService.addressController
                                  .value.text.isEmpty) {
                                controller.googleMapService
                                    .getCurrentLocation();
                              } else {
                                {}
                              }
                            },
                            icon: controller.googleMapService.addressController
                                        .value.text.isEmpty &&
                                    controller
                                            .googleMapService.isFocused.value ==
                                        false
                                ? Textwidget(
                                    text: "Current Location",
                                    color: AppStyles.appThemeColor)
                                : const SizedBox(),
                          ),
                          onChanged: (v) {
                            controller.googleMapService.googlePlacesApi(v);
                            // controller.googleMapService.addressController.value.text = v;
                            if (v.isEmpty) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                          },
                        )),
                    Obx(() => controller.googleMapService.placesList.isEmpty
                        ? const SizedBox()
                        : ListView.builder(
                            itemCount:
                                controller.googleMapService.placesList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(controller.googleMapService
                                    .placesList[index].description),
                                onTap: () {
                                  controller.googleMapService.addressController
                                          .value.text =
                                      controller.googleMapService
                                          .placesList[index].description;
                                  controller.googleMapService.getPlaceDetails(
                                      controller.googleMapService
                                          .placesList[index].placeId
                                          .toString());
                                  controller.googleMapService.placesList
                                      .clear();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                              );
                            },
                          )),
                    const SizedBox(
                      height: 12,
                    ),
                    // property size
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppStyles.TextformfeildOutlineColor,
                              width: 0.7)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Image.asset(
                              "assets/icons/aptIcon.png",
                              scale: 3.5,
                            ),
                            Obx(
                              () => Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 25),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      alignment: Alignment.centerLeft,
                                      hint: const Text("Property size"),
                                      value: controller.show.value == true
                                          ? controller.propertySizeSQFT.value
                                          : null,
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down_outlined),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      underline: Container(),
                                      onChanged: (newValue) {
                                        controller.show.value = true;
                                        controller.propertySizeSQFT.value =
                                            newValue.toString();
                                        controller.coHostServicesPriceApi();

                                        // log("property-ID --  -- ${controller.propertySizeId.value}");
                                      },
                                      items: controller.sqrFeetList.map((item) {
                                        return DropdownMenuItem(
                                          onTap: () {
                                            controller.propertySizeSQFT.value =
                                                "Under ${item.squareFeet} sq. ft";
                                            controller.propertySizeSqrFeet
                                                .value = item.squareFeet;
                                            log("property-size --  -- ${controller.propertySizeSQFT.value}");
                                          },
                                          value:
                                              "Under ${item.squareFeet} sq. ft",
                                          child: Text(
                                            "Under ${item.squareFeet} sq. ft",
                                            style: const TextStyle(
                                                fontFamily: "JosefinSans"),
                                          ),
                                        );
                                      }).toList(),
                                    )),
                              ),
                            )
                            // Obx(
                            //       () => Expanded(
                            //     child: Padding(
                            //       padding: const EdgeInsets.only(left: 15,right: 25),
                            //       child: DropdownButton<String>(
                            //         isExpanded: true,
                            //         alignment: Alignment.centerLeft,
                            //
                            //         hint: Textwidget(
                            //           text: "Property size",
                            //         ),
                            //         padding: EdgeInsets.zero,
                            //         value: controller.property_size.value,
                            //         icon:
                            //         const Icon(Icons.keyboard_arrow_down_outlined),
                            //         iconSize: 24,
                            //         elevation: 16,
                            //         style: const TextStyle(color: Colors.black),
                            //         underline: Container(),
                            //         onChanged: (newValue) {
                            //           controller.property_size.value = newValue!;
                            //         },
                            //         items: controller.options
                            //             .map<DropdownMenuItem<String>>((String value) {
                            //           return DropdownMenuItem<String>(
                            //             value: value,
                            //             child: Text(
                            //               value,
                            //               style: const TextStyle(
                            //                   fontFamily: "JosefinSans"),
                            //             ),
                            //           );
                            //         }).toList(),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Flexible(
                    //       child: Row(
                    //         children: [
                    //           Obx(
                    //                 () => Checkbox(
                    //               activeColor: AppStyles.appThemeColor,
                    //               value: controller.isChecked.value,
                    //               onChanged: (bool? value) {
                    //                 controller.isChecked.value = value ?? false;
                    //               },
                    //             ),
                    //           ),
                    //           Flexible(
                    //             child: Textwidget(
                    //               maxLines: 2,
                    //               textscalefector: 1,
                    //               text: "I don’t know the house size",
                    //               fontWeight: FontWeight.w400,
                    //               fontSize: 14,
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: InkWell(
                              onTap: () {
                                controller.selectDate(context);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: AppStyles.backgroundColor,
                                    border: Border.all(
                                        color:
                                            AppStyles.TextformfeildOutlineColor,
                                        width: 0.7),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13, vertical: 15),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          child: Image.asset(
                                            "assets/icons/calandericon.png",
                                            scale: 4,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Obx(
                                          () {
                                            if (controller.selectedDate.value ==
                                                null) {
                                              return Textwidget(
                                                text: "Date",
                                              );
                                            } else {
                                              return Textwidget(
                                                text: DateFormat('dd-MM-yyyy')
                                                    .format(controller
                                                        .selectedDate.value!),
                                              );
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  ))),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: InkWell(
                              onTap: () {
                                controller.selectTime(context);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: AppStyles.backgroundColor,
                                    border: Border.all(
                                        color:
                                            AppStyles.TextformfeildOutlineColor,
                                        width: 0.7),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13, vertical: 15),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          child: Image.asset(
                                            "assets/icons/clockIcon.png",
                                            scale: 4,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Obx(
                                          () {
                                            if (controller.selectedTime.value ==
                                                null) {
                                              return Textwidget(
                                                text: "Time",
                                              );
                                            } else {
                                              return Textwidget(
                                                text: controller
                                                    .selectedTime.value!
                                                    .format(context),
                                              );
                                            }
                                          },
                                        )

                                        // Obx(() => Textwidget(
                                        //       text:
                                        //           ' ${controller.selectedTime.value.format(context)}',
                                        //     )),
                                      ],
                                    ),
                                  ))),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),

                    if (controller.serviceId.value == "1" ||
                        controller.serviceId.value == "2" ||
                        controller.serviceId.value == "4")
                      controller.isLoading.isTrue
                          ? ShowLoader.isLoadingProgress(
                              controller.isLoading.value)
                          : controller.serviceListDetails.isEmpty
                              ? const SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Textwidget(
                                      text: "What you want service?",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: ListView.builder(
                                          itemCount: 2,
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemBuilder: (buildContext, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: InkWell(
                                                focusColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                splashColor: Colors.transparent,
                                                onTap: () {
                                                  controller
                                                      .selectServiceStandardDeep
                                                      .value = index.toString();
                                                  controller.bedroomQty.value =
                                                      0;
                                                  controller.bathroomQty.value =
                                                      0;
                                                  controller.perHourQty.value =
                                                      0;

                                                  controller.serviceLableId
                                                      .clear();
                                                  controller.serviceTitleList
                                                      .clear();
                                                  controller.serviceQtyList
                                                      .clear();
                                                  controller
                                                      .serviceTotalPriceList
                                                      .clear();
                                                  controller.serviceActualPrice
                                                      .clear();
                                                },
                                                child: Row(
                                                  children: [
                                                    Obx(() => controller
                                                                .selectServiceStandardDeep
                                                                .value ==
                                                            index.toString()
                                                        ? Image.asset(
                                                            "assets/icons/graycirculefill.png",
                                                            height: 25,
                                                          )
                                                        : Image.asset(
                                                            "assets/icons/graycircule.png",
                                                            height: 25,
                                                          )),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Textwidget(
                                                      text: controller
                                                              .serviceTypeList[
                                                          index],
                                                      fontSize: 15,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    Obx(() => controller
                                                .selectServiceStandardDeep
                                                .value ==
                                            "0"
                                        ? ListView.builder(
                                            itemCount:
                                                controller.priceLabels.length,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (buildContext, index) {
                                              var lable =
                                                  controller.priceLabels[index];

                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      lable.text ==
                                                              "Per Bedroom"
                                                          ? Image.asset(
                                                              "assets/icons/bedroom.png",
                                                              scale: 4,
                                                            )
                                                          : lable.text ==
                                                                  "Per Bathroom"
                                                              ? Image.asset(
                                                                  "assets/icons/bathroom.png",
                                                                  scale: 4,
                                                                )
                                                              : Image.asset(
                                                                  "assets/icons/price.png",
                                                                  height: 20,
                                                                  color: AppStyles
                                                                      .appThemeColor,
                                                                ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Textwidget(
                                                            text: lable.text,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Textwidget(
                                                                text:
                                                                    "\$${lable.standardPrice}",
                                                                fontSize: 12,
                                                                color: AppStyles
                                                                    .appThemeColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Image.asset(
                                                                "assets/icons/cancelicon.png",
                                                                color: AppStyles
                                                                    .appThemeColor,
                                                                scale: 7.5,
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Obx(() =>
                                                                  Textwidget(
                                                                    textscalefector:
                                                                        1,
                                                                    text: index ==
                                                                            0
                                                                        ? controller
                                                                            .bedroomQty
                                                                            .value
                                                                            .toString()
                                                                        : index ==
                                                                                1
                                                                            ? controller.bathroomQty.value.toString()
                                                                            : controller.perHourQty.value.toString(),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: AppStyles
                                                                        .appThemeColor,
                                                                    fontSize:
                                                                        12,
                                                                  ))
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Card(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3)),
                                                          color: AppStyles
                                                              .Blacklightbuttoncolor,
                                                          child: IconButton(
                                                              onPressed: () {
                                                                // Decrement quantities and prices based on the selected index
                                                                if (index ==
                                                                    0) {
                                                                  if (controller
                                                                          .bedroomQty
                                                                          .value >
                                                                      0) {
                                                                    controller
                                                                        .bedroomQty
                                                                        .value--;
                                                                    int total = int.parse(lable
                                                                            .standardPrice) *
                                                                        controller
                                                                            .bedroomQty
                                                                            .value;
                                                                    updateServiceListDecrement(
                                                                        index,
                                                                        lable,
                                                                        controller
                                                                            .bedroomQty
                                                                            .value,
                                                                        total,
                                                                        lable
                                                                            .standardPrice);
                                                                  }
                                                                } else if (index ==
                                                                    1) {
                                                                  if (controller
                                                                          .bathroomQty
                                                                          .value >
                                                                      0) {
                                                                    controller
                                                                        .bathroomQty
                                                                        .value--;
                                                                    int total = int.parse(lable
                                                                            .standardPrice) *
                                                                        controller
                                                                            .bathroomQty
                                                                            .value;
                                                                    updateServiceListDecrement(
                                                                        index,
                                                                        lable,
                                                                        controller
                                                                            .bathroomQty
                                                                            .value,
                                                                        total,
                                                                        lable
                                                                            .standardPrice);
                                                                  }
                                                                } else {
                                                                  if (controller
                                                                          .perHourQty
                                                                          .value >
                                                                      0) {
                                                                    controller
                                                                        .perHourQty
                                                                        .value--;
                                                                    int total = int.parse(lable
                                                                            .standardPrice) *
                                                                        controller
                                                                            .perHourQty
                                                                            .value;
                                                                    updateServiceListDecrement(
                                                                        index,
                                                                        lable,
                                                                        controller
                                                                            .perHourQty
                                                                            .value,
                                                                        total,
                                                                        lable
                                                                            .standardPrice);
                                                                  }
                                                                }
                                                              },
                                                              // onPressed: () {
                                                              //   if(index == 0){
                                                              //     if(controller.bedroom_qty.value != 0){
                                                              //
                                                              //       controller.bedroom_qty.value--;
                                                              //       controller.total_bedroom_price.value = int.parse(lable.standardPrice)*controller.bedroom_qty.value;
                                                              //       print("total_bedroom_price = = = ${controller.total_bedroom_price.value}");
                                                              //
                                                              //
                                                              //     }else{}
                                                              //   }else if(index == 1){
                                                              //     if(controller.bathroom_qty.value != 0){
                                                              //
                                                              //       controller.bathroom_qty.value--;
                                                              //       controller.total_bathroom_price.value = int.parse(lable.standardPrice)*controller.bathroom_qty.value;
                                                              //       print("total_bathroom_price = = = ${controller.total_bathroom_price.value}");
                                                              //
                                                              //     }else{}
                                                              //   }else{
                                                              //     if(controller.per_hour_qty.value != 0){
                                                              //
                                                              //       controller.per_hour_qty.value--;
                                                              //       controller.total_per_hour_price.value = int.parse(lable.standardPrice)*controller.per_hour_qty.value;
                                                              //       print("total_per_hour_price = = = ${controller.total_per_hour_price.value}");
                                                              //
                                                              //     }else{}
                                                              //   }
                                                              // },
                                                              icon: Image.asset(
                                                                "assets/icons/minus.png",
                                                                scale: 20,
                                                                color: Colors
                                                                    .white,
                                                              ))),
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              10,
                                                          child: Center(
                                                              child: Obx(() =>
                                                                  Textwidget(
                                                                    textscalefector:
                                                                        1,
                                                                    text: index ==
                                                                            0
                                                                        ? controller
                                                                            .bedroomQty
                                                                            .value
                                                                            .toString()
                                                                        : index ==
                                                                                1
                                                                            ? controller.bathroomQty.value.toString()
                                                                            : controller.perHourQty.value.toString(),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        20,
                                                                  )))),
                                                      Card(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3)),
                                                          color: AppStyles
                                                              .appThemeColor,
                                                          child: IconButton(
                                                              onPressed: () {
                                                                if (index ==
                                                                    0) {
                                                                  controller
                                                                      .bedroomQty
                                                                      .value++;
                                                                  int total = int
                                                                          .parse(lable
                                                                              .standardPrice) *
                                                                      controller
                                                                          .bedroomQty
                                                                          .value;
                                                                  updateServiceListIncrement(
                                                                      index,
                                                                      lable,
                                                                      controller
                                                                          .bedroomQty
                                                                          .value,
                                                                      total,
                                                                      lable
                                                                          .standardPrice);
                                                                } else if (index ==
                                                                    1) {
                                                                  controller
                                                                      .bathroomQty
                                                                      .value++;
                                                                  int total = int
                                                                          .parse(lable
                                                                              .standardPrice) *
                                                                      controller
                                                                          .bathroomQty
                                                                          .value;
                                                                  updateServiceListIncrement(
                                                                      index,
                                                                      lable,
                                                                      controller
                                                                          .bathroomQty
                                                                          .value,
                                                                      total,
                                                                      lable
                                                                          .standardPrice);
                                                                } else {
                                                                  controller
                                                                      .perHourQty
                                                                      .value++;
                                                                  int total = int
                                                                          .parse(lable
                                                                              .standardPrice) *
                                                                      controller
                                                                          .perHourQty
                                                                          .value;
                                                                  updateServiceListIncrement(
                                                                      index,
                                                                      lable,
                                                                      controller
                                                                          .perHourQty
                                                                          .value,
                                                                      total,
                                                                      lable
                                                                          .standardPrice);
                                                                }
                                                              },
                                                              // onPressed: () {
                                                              //   if(index == 0){
                                                              //
                                                              //     controller.bedroom_qty.value++;
                                                              //     controller.total_bedroom_price.value = int.parse(lable.standardPrice)*controller.bedroom_qty.value;
                                                              //     print("total_bedroom_price = = = ${controller.total_bedroom_price.value}");
                                                              //
                                                              //   }else if(index == 1){
                                                              //
                                                              //     controller.bathroom_qty.value++;
                                                              //     controller.total_bathroom_price.value =  int.parse(lable.standardPrice)*controller.bathroom_qty.value;
                                                              //     print("total_bathroom_price = = = ${controller.total_bathroom_price.value}");
                                                              //
                                                              //   }else{
                                                              //
                                                              //     controller.per_hour_qty.value++;
                                                              //     controller.total_per_hour_price.value =  int.parse(lable.standardPrice)*controller.per_hour_qty.value;
                                                              //     print("total_per_hour_price = = = ${controller.total_per_hour_price.value}");
                                                              //
                                                              //   }
                                                              //
                                                              // },
                                                              icon: const Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .white,
                                                              ))),
                                                    ],
                                                  )
                                                ],
                                              );
                                            })
                                        : ListView.builder(
                                            itemCount:
                                                controller.priceLabels.length,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (buildContext, index) {
                                              var lable =
                                                  controller.priceLabels[index];
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      lable.text ==
                                                              "Per Bedroom"
                                                          ? Image.asset(
                                                              "assets/icons/bedroom.png",
                                                              scale: 4,
                                                            )
                                                          : lable.text ==
                                                                  "Per Bathroom"
                                                              ? Image.asset(
                                                                  "assets/icons/bathroom.png",
                                                                  scale: 4,
                                                                )
                                                              : Image.asset(
                                                                  "assets/icons/price.png",
                                                                  height: 20,
                                                                  color: AppStyles
                                                                      .appThemeColor,
                                                                ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Textwidget(
                                                            text: lable.text,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Textwidget(
                                                                text:
                                                                    "\$${lable.deepPrice}",
                                                                fontSize: 12,
                                                                color: AppStyles
                                                                    .appThemeColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Image.asset(
                                                                "assets/icons/cancelicon.png",
                                                                color: AppStyles
                                                                    .appThemeColor,
                                                                scale: 7.5,
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Obx(() =>
                                                                  Textwidget(
                                                                    textscalefector:
                                                                        1,
                                                                    text: index ==
                                                                            0
                                                                        ? controller
                                                                            .bedroomQty
                                                                            .value
                                                                            .toString()
                                                                        : index ==
                                                                                1
                                                                            ? controller.bathroomQty.value.toString()
                                                                            : controller.perHourQty.value.toString(),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: AppStyles
                                                                        .appThemeColor,
                                                                    fontSize:
                                                                        12,
                                                                  ))
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Card(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3)),
                                                          color: AppStyles
                                                              .Blacklightbuttoncolor,
                                                          child: IconButton(
                                                              onPressed: () {
                                                                // Decrement quantities and prices based on the selected index
                                                                if (index ==
                                                                    0) {
                                                                  if (controller
                                                                          .bedroomQty
                                                                          .value >
                                                                      0) {
                                                                    controller
                                                                        .bedroomQty
                                                                        .value--;
                                                                    int total = int.parse(lable
                                                                            .deepPrice) *
                                                                        controller
                                                                            .bedroomQty
                                                                            .value;
                                                                    updateServiceListDecrement(
                                                                        index,
                                                                        lable,
                                                                        controller
                                                                            .bedroomQty
                                                                            .value,
                                                                        total,
                                                                        lable
                                                                            .deepPrice);
                                                                  }
                                                                } else if (index ==
                                                                    1) {
                                                                  if (controller
                                                                          .bathroomQty
                                                                          .value >
                                                                      0) {
                                                                    controller
                                                                        .bathroomQty
                                                                        .value--;
                                                                    int total = int.parse(lable
                                                                            .deepPrice) *
                                                                        controller
                                                                            .bathroomQty
                                                                            .value;
                                                                    updateServiceListDecrement(
                                                                        index,
                                                                        lable,
                                                                        controller
                                                                            .bathroomQty
                                                                            .value,
                                                                        total,
                                                                        lable
                                                                            .deepPrice);
                                                                  }
                                                                } else {
                                                                  if (controller
                                                                          .perHourQty
                                                                          .value >
                                                                      0) {
                                                                    controller
                                                                        .perHourQty
                                                                        .value--;
                                                                    int total = int.parse(lable
                                                                            .deepPrice) *
                                                                        controller
                                                                            .perHourQty
                                                                            .value;
                                                                    updateServiceListDecrement(
                                                                        index,
                                                                        lable,
                                                                        controller
                                                                            .perHourQty
                                                                            .value,
                                                                        total,
                                                                        lable
                                                                            .deepPrice);
                                                                  }
                                                                }
                                                              },
                                                              icon: Image.asset(
                                                                "assets/icons/minus.png",
                                                                scale: 20,
                                                                color: Colors
                                                                    .white,
                                                              ))),
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              10,
                                                          child: Center(
                                                              child: Obx(() =>
                                                                  Textwidget(
                                                                    textscalefector:
                                                                        1,
                                                                    text: index ==
                                                                            0
                                                                        ? controller
                                                                            .bedroomQty
                                                                            .value
                                                                            .toString()
                                                                        : index ==
                                                                                1
                                                                            ? controller.bathroomQty.value.toString()
                                                                            : controller.perHourQty.value.toString(),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        20,
                                                                  )))),
                                                      Card(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3)),
                                                          color: AppStyles
                                                              .appThemeColor,
                                                          child: IconButton(
                                                              onPressed: () {
                                                                if (index ==
                                                                    0) {
                                                                  controller
                                                                      .bedroomQty
                                                                      .value++;
                                                                  int total = int
                                                                          .parse(lable
                                                                              .deepPrice) *
                                                                      controller
                                                                          .bedroomQty
                                                                          .value;
                                                                  updateServiceListIncrement(
                                                                      index,
                                                                      lable,
                                                                      controller
                                                                          .bedroomQty
                                                                          .value,
                                                                      total,
                                                                      lable
                                                                          .deepPrice);
                                                                } else if (index ==
                                                                    1) {
                                                                  controller
                                                                      .bathroomQty
                                                                      .value++;
                                                                  int total = int
                                                                          .parse(lable
                                                                              .deepPrice) *
                                                                      controller
                                                                          .bathroomQty
                                                                          .value;
                                                                  updateServiceListIncrement(
                                                                      index,
                                                                      lable,
                                                                      controller
                                                                          .bathroomQty
                                                                          .value,
                                                                      total,
                                                                      lable
                                                                          .deepPrice);
                                                                } else {
                                                                  controller
                                                                      .perHourQty
                                                                      .value++;
                                                                  int total = int
                                                                          .parse(lable
                                                                              .deepPrice) *
                                                                      controller
                                                                          .perHourQty
                                                                          .value;
                                                                  updateServiceListIncrement(
                                                                      index,
                                                                      lable,
                                                                      controller
                                                                          .perHourQty
                                                                          .value,
                                                                      total,
                                                                      lable
                                                                          .deepPrice);
                                                                }
                                                              },
                                                              icon: const Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .white,
                                                              ))),
                                                    ],
                                                  )
                                                ],
                                              );
                                            })),

                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Row(
                                    //       crossAxisAlignment: CrossAxisAlignment.start,
                                    //       children: [
                                    //         Image.asset(
                                    //           "assets/icons/bedroom.png",
                                    //           scale: 3.5,
                                    //           width: 20,
                                    //         ),
                                    //         const SizedBox(
                                    //           width: 10,
                                    //         ),
                                    //         Column(
                                    //           crossAxisAlignment: CrossAxisAlignment.start,
                                    //           children: [
                                    //             Textwidget(
                                    //               text: "Bedroom ",
                                    //               fontSize: 15,
                                    //               fontWeight: FontWeight.w700,
                                    //             ),
                                    //             Row(
                                    //               children: [
                                    //                 Textwidget(
                                    //                   text: "\$50",
                                    //                   fontSize: 12,
                                    //                   color: AppStyles.appThemeColor,
                                    //                   fontWeight: FontWeight.w700,
                                    //                 ),
                                    //                 const SizedBox(
                                    //                   width: 5,
                                    //                 ),
                                    //                 Image.asset(
                                    //                   "assets/icons/cancelicon.png",
                                    //                   color: AppStyles.appThemeColor,
                                    //                   scale: 7.5,
                                    //                 ),
                                    //                 const SizedBox(
                                    //                   width: 5,
                                    //                 ),
                                    //                 Textwidget(
                                    //                   text: "1",
                                    //                   fontSize: 12,
                                    //                   color: AppStyles.appThemeColor,
                                    //                   fontWeight: FontWeight.w700,
                                    //                 ),
                                    //               ],
                                    //             )
                                    //           ],
                                    //         )
                                    //       ],
                                    //     ),
                                    //     Row(
                                    //       children: [
                                    //         Obx(() => controller.bedroomCount.value == 0
                                    //             ? Card(
                                    //             shape: RoundedRectangleBorder(
                                    //                 borderRadius:
                                    //                 BorderRadius.circular(3)),
                                    //             child: IconButton(
                                    //                 onPressed: () {
                                    //                   //  controller.bedroomCount.value--;
                                    //                 },
                                    //                 icon: Image.asset(
                                    //                   "assets/icons/minus.png",
                                    //                   scale: 20,
                                    //                 )))
                                    //             : Card(
                                    //             shape: RoundedRectangleBorder(
                                    //                 borderRadius:
                                    //                 BorderRadius.circular(3)),
                                    //             color: AppStyles.Blacklightbuttoncolor,
                                    //             child: IconButton(
                                    //                 onPressed: () {
                                    //                   controller.bedroomCount.value--;
                                    //                 },
                                    //                 icon: Image.asset(
                                    //                   "assets/icons/minus.png",
                                    //                   scale: 20,
                                    //                   color: Colors.white,
                                    //                 )))),
                                    //         SizedBox(
                                    //             width:
                                    //             MediaQuery.of(context).size.width / 10,
                                    //             child: Center(
                                    //                 child: Obx(() => Textwidget(
                                    //                   textscalefector: 1,
                                    //                   text: controller
                                    //                       .bedroomCount.value
                                    //                       .toString(),
                                    //                   fontWeight: FontWeight.w700,
                                    //                   fontSize: 20,
                                    //                 )))),
                                    //         Card(
                                    //             shape: RoundedRectangleBorder(
                                    //                 borderRadius: BorderRadius.circular(3)),
                                    //             color: AppStyles.appThemeColor,
                                    //             child: IconButton(
                                    //                 onPressed: () {
                                    //                   controller.bedroomCount.value++;
                                    //                 },
                                    //                 icon: const Icon(
                                    //                   Icons.add,
                                    //                   color: Colors.white,
                                    //                 ))),
                                    //       ],
                                    //     )
                                    //   ],
                                    // ),
                                    // const SizedBox(
                                    //   height: 10,
                                    // ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Row(
                                    //       crossAxisAlignment: CrossAxisAlignment.start,
                                    //       children: [
                                    //         Image.asset(
                                    //           "assets/icons/bathroom.png",
                                    //           scale: 3.5,
                                    //           width: 20,
                                    //         ),
                                    //         const SizedBox(
                                    //           width: 10,
                                    //         ),
                                    //         Column(
                                    //           crossAxisAlignment: CrossAxisAlignment.start,
                                    //           children: [
                                    //             Textwidget(
                                    //               text: "Bathroom ",
                                    //               fontSize: 15,
                                    //               fontWeight: FontWeight.w700,
                                    //             ),
                                    //             Row(
                                    //               children: [
                                    //                 Textwidget(
                                    //                   text: "\$50",
                                    //                   fontSize: 12,
                                    //                   color: AppStyles.appThemeColor,
                                    //                   fontWeight: FontWeight.w700,
                                    //                 ),
                                    //                 const SizedBox(
                                    //                   width: 5,
                                    //                 ),
                                    //                 Image.asset(
                                    //                   "assets/icons/cancelicon.png",
                                    //                   color: AppStyles.appThemeColor,
                                    //                   scale: 7.5,
                                    //                 ),
                                    //                 const SizedBox(
                                    //                   width: 5,
                                    //                 ),
                                    //                 Textwidget(
                                    //                   text: "1",
                                    //                   fontSize: 12,
                                    //                   color: AppStyles.appThemeColor,
                                    //                   fontWeight: FontWeight.w700,
                                    //                 ),
                                    //               ],
                                    //             )
                                    //           ],
                                    //         )
                                    //       ],
                                    //     ),
                                    //     Row(
                                    //       children: [
                                    //         Obx(() => controller.BathroomCount.value == 0
                                    //             ? Card(
                                    //             shape: RoundedRectangleBorder(
                                    //                 borderRadius:
                                    //                 BorderRadius.circular(3)),
                                    //             child: IconButton(
                                    //                 onPressed: () {
                                    //                   //  controller.bedroomCount.value--;
                                    //                 },
                                    //                 icon: Image.asset(
                                    //                   "assets/icons/minus.png",
                                    //                   scale: 20,
                                    //                 )))
                                    //             : Card(
                                    //             shape: RoundedRectangleBorder(
                                    //                 borderRadius:
                                    //                 BorderRadius.circular(3)),
                                    //             color: AppStyles.Blacklightbuttoncolor,
                                    //             child: IconButton(
                                    //                 onPressed: () {
                                    //                   controller.BathroomCount.value--;
                                    //                 },
                                    //                 icon: Image.asset(
                                    //                   "assets/icons/minus.png",
                                    //                   scale: 20,
                                    //                   color: Colors.white,
                                    //                 )))),
                                    //         SizedBox(
                                    //             width:
                                    //             MediaQuery.of(context).size.width / 10,
                                    //             child: Center(
                                    //                 child: Obx(() => Textwidget(
                                    //                   textscalefector: 1,
                                    //                   text: controller
                                    //                       .BathroomCount.value
                                    //                       .toString(),
                                    //                   fontWeight: FontWeight.w700,
                                    //                   fontSize: 20,
                                    //                 )))),
                                    //         Card(
                                    //             shape: RoundedRectangleBorder(
                                    //                 borderRadius: BorderRadius.circular(3)),
                                    //             color: AppStyles.appThemeColor,
                                    //             child: IconButton(
                                    //                 onPressed: () {
                                    //                   controller.BathroomCount.value++;
                                    //                 },
                                    //                 icon: const Icon(
                                    //                   Icons.add,
                                    //                   color: Colors.white,
                                    //                 ))),
                                    //       ],
                                    //     )
                                    //   ],
                                    // ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                )
                    else if (controller.serviceId.value == "3" ||
                        controller.serviceId.value == "6")
                      controller.isLoading.isTrue
                          ? ShowLoader.isLoadingProgress(
                              controller.isLoading.value)
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Textwidget(
                                  text: "What you want service?",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Obx(
                                  () => SizedBox(
                                    height: 30,
                                    child: ListView.builder(
                                        itemCount: controller
                                            .serviceTypeListPerHour.length,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder: (buildContext, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: InkWell(
                                              focusColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              splashColor: Colors.transparent,
                                              onTap: () {
                                                controller
                                                    .selectServiceWeeklySqrFeel
                                                    .value = index.toString();
                                                // controller.property_size_sqrFeet.value = '';
                                              },
                                              child: Row(
                                                children: [
                                                  Obx(() => controller
                                                              .selectServiceWeeklySqrFeel
                                                              .value ==
                                                          index.toString()
                                                      ? Image.asset(
                                                          "assets/icons/graycirculefill.png",
                                                          height: 25,
                                                        )
                                                      : Image.asset(
                                                          "assets/icons/graycircule.png",
                                                          height: 25,
                                                        )),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Textwidget(
                                                    text: controller
                                                            .serviceTypeListPerHour[
                                                        index],
                                                    fontSize: 15,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                // prices
                                if (controller
                                        .selectServiceWeeklySqrFeel.value ==
                                    "0")
                                  Obx(() => ListView.builder(
                                      itemCount: controller.weeklyList.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (buildContext, index) {
                                        // var sqr_feet;
                                        // var price;

                                        if (controller
                                                .weeklyList[index].squareFeet ==
                                            controller
                                                .propertySizeSqrFeet.value) {
                                          controller.sQft.value = controller
                                              .weeklyList[index].squareFeet;
                                          controller.totalSqftPrice.value =
                                              controller.weeklyList[index]
                                                  .servicePrice;
                                        } else {}
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10, top: 5),
                                          child: controller.weeklyList[index]
                                                      .squareFeet ==
                                                  controller
                                                      .propertySizeSqrFeet.value
                                              ? Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      "assets/icons/Vector (3).png",
                                                      scale: 3,
                                                      color: AppStyles
                                                          .appThemeColor,
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Textwidget(
                                                          text:
                                                              "${controller.sQft.value} Sq.ft",
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16,
                                                        ),
                                                        Textwidget(
                                                          text:
                                                              "\$${controller.totalSqftPrice} - ${controller.selectServiceWeeklySqrFeel.value == "0" ? "Week" : controller.selectServiceWeeklySqrFeel.value == "1" ? "Bi Week" : "Month"}",
                                                          color: AppStyles
                                                              .appThemeColor,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox(),
                                        );
                                      }))
                                else if (controller
                                        .selectServiceWeeklySqrFeel.value ==
                                    "1")
                                  Obx(() => ListView.builder(
                                      itemCount: controller.biWeeklyList.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (buildContext, index) {
                                        // var sqr_feet;
                                        // var price;

                                        if (controller.biWeeklyList[index]
                                                .squareFeet ==
                                            controller
                                                .propertySizeSqrFeet.value) {
                                          controller.sQft.value = controller
                                              .biWeeklyList[index].squareFeet;
                                          controller.totalSqftPrice.value =
                                              controller.biWeeklyList[index]
                                                  .servicePrice;
                                        } else {}

                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10, top: 5),
                                          child: controller.biWeeklyList[index]
                                                      .squareFeet ==
                                                  controller
                                                      .propertySizeSqrFeet.value
                                              ? Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      "assets/icons/Vector (3).png",
                                                      scale: 3,
                                                      color: AppStyles
                                                          .appThemeColor,
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Textwidget(
                                                          text:
                                                              "${controller.sQft.value} Sq.ft",
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16,
                                                        ),
                                                        Textwidget(
                                                          text:
                                                              "\$${controller.totalSqftPrice.value} - ${controller.selectServiceWeeklySqrFeel.value == "0" ? "Week" : controller.selectServiceWeeklySqrFeel.value == "1" ? "Bi Week" : "Month"}",
                                                          color: AppStyles
                                                              .appThemeColor,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox(),
                                        );
                                      }))
                                else
                                  Obx(
                                    () => ListView.builder(
                                        itemCount:
                                            controller.monthlyList.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (buildContext, index) {
                                          // var sqr_feet;
                                          // var price;

                                          if (controller.monthlyList[index]
                                                  .squareFeet ==
                                              controller
                                                  .propertySizeSqrFeet.value) {
                                            controller.sQft.value = controller
                                                .monthlyList[index].squareFeet;
                                            controller.totalSqftPrice.value =
                                                controller.monthlyList[index]
                                                    .servicePrice;
                                          } else {}
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10, top: 5),
                                            child: controller.monthlyList[index]
                                                        .squareFeet ==
                                                    controller
                                                        .propertySizeSqrFeet
                                                        .value
                                                ? Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Image.asset(
                                                        "assets/icons/Vector (3).png",
                                                        scale: 3,
                                                        color: AppStyles
                                                            .appThemeColor,
                                                      ),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Textwidget(
                                                            text:
                                                                "${controller.sQft.value} Sq.ft",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16,
                                                          ),
                                                          Textwidget(
                                                            text:
                                                                "\$${controller.totalSqftPrice.value} - ${controller.selectServiceWeeklySqrFeel.value == "0" ? "Week" : controller.selectServiceWeeklySqrFeel.value == "1" ? "Bi Week" : "Month"}",
                                                            color: AppStyles
                                                                .appThemeColor,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox(),
                                          );
                                        }),
                                  ),

                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            )
                    else
                      controller.isLoading.isTrue
                          ? ShowLoader.isLoadingProgress(
                              controller.isLoading.value)
                          : Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Textwidget(
                                    text: "What you want service?",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: ListView.builder(
                                        itemCount: controller
                                            .serviceTypeListPerHour.length,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder: (buildContext, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: InkWell(
                                              focusColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              splashColor: Colors.transparent,
                                              onTap: () {
                                                controller
                                                    .selectServiceWeeklyHourly
                                                    .value = index.toString();
                                                controller.hourQty.value = "0";
                                                controller.hourQtyController
                                                    .clear();
                                              },
                                              child: Row(
                                                children: [
                                                  Obx(() => controller
                                                              .selectServiceWeeklyHourly
                                                              .value ==
                                                          index.toString()
                                                      ? Image.asset(
                                                          "assets/icons/graycirculefill.png",
                                                          height: 25,
                                                        )
                                                      : Image.asset(
                                                          "assets/icons/graycircule.png",
                                                          height: 25,
                                                        )),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Textwidget(
                                                    text: controller
                                                            .serviceTypeListPerHour[
                                                        index],
                                                    fontSize: 15,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if (controller
                                          .selectServiceWeeklyHourly.value ==
                                      "0")
                                    for (int i = 0;
                                        i < controller.weeklyListH.length;
                                        i++)
                                      Obx(() => Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 10, top: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      "assets/icons/Vector (5).png",
                                                      scale: 4,
                                                      color: AppStyles
                                                          .appThemeColor,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Textwidget(
                                                              text: "Hourly ",
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            Textwidget(
                                                              text:
                                                                  "( Minimum 2 hours services ) ",
                                                              fontSize: 13,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Textwidget(
                                                              text:
                                                                  "\$${controller.weeklyListH[i].servicePrice}",
                                                              fontSize: 12,
                                                              color: AppStyles
                                                                  .appThemeColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Image.asset(
                                                              "assets/icons/cancelicon.png",
                                                              color: AppStyles
                                                                  .appThemeColor,
                                                              scale: 7.5,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Textwidget(
                                                              textscalefector:
                                                                  1,
                                                              text: controller
                                                                      .hourQty
                                                                      .isEmpty
                                                                  ? "0"
                                                                  : controller
                                                                      .hourQty
                                                                      .value,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppStyles
                                                                  .appThemeColor,
                                                              fontSize: 12,
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 100,
                                                  child: TextFormField(
                                                    controller: controller
                                                        .hourQtyController,
                                                    textAlign: TextAlign.center,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter hours',
                                                      hintStyle:
                                                          const TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            "JosefinSans",
                                                      ),
                                                      labelStyle:
                                                          const TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            "JosefinSans",
                                                      ),
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                    onFieldSubmitted: (value) {
                                                      if (int.parse(value) >=
                                                          2) {
                                                        controller
                                                                .hourQty.value =
                                                            controller
                                                                .hourQtyController
                                                                .text
                                                                .toString();
                                                        int total = int.parse(
                                                                controller
                                                                    .weeklyListH[
                                                                        i]
                                                                    .servicePrice) *
                                                            int.parse(controller
                                                                .hourQty.value);
                                                        controller
                                                                .totalHourlyPrice
                                                                .value =
                                                            total.toString();
                                                        controller
                                                                .actualHourlyPrice
                                                                .value =
                                                            controller
                                                                .weeklyListH[i]
                                                                .servicePrice;

                                                        controller
                                                            .hourQtyController
                                                            .clear();
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          dismissDirection:
                                                              DismissDirection
                                                                  .horizontal,
                                                          backgroundColor:
                                                              AppStyles
                                                                  .appThemeColor,
                                                          content: Center(
                                                              child: Textwidget(
                                                            text:
                                                                "Minimum 2 hour services",
                                                            color: Colors.white,
                                                          )),
                                                        ));
                                                      }
                                                    },
                                                  ),
                                                ),

                                                // Textwidget(
                                                //   text: "\$${controller.weekly_list_h[i].servicePrice}",
                                                // ),
                                              ],
                                            ),
                                          ))
                                  else if (controller
                                          .selectServiceWeeklyHourly.value ==
                                      "1")
                                    for (int i = 0;
                                        i < controller.biWeeklyListH.length;
                                        i++)
                                      Obx(() => Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10, top: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      "assets/icons/Vector (5).png",
                                                      scale: 4,
                                                      color: AppStyles
                                                          .appThemeColor,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Textwidget(
                                                              text: "Hourly ",
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            Textwidget(
                                                              text:
                                                                  "( Minimum 2 hours services ) ",
                                                              fontSize: 13,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Textwidget(
                                                              text:
                                                                  "\$${controller.biWeeklyListH[i].servicePrice}",
                                                              fontSize: 12,
                                                              color: AppStyles
                                                                  .appThemeColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Image.asset(
                                                              "assets/icons/cancelicon.png",
                                                              color: AppStyles
                                                                  .appThemeColor,
                                                              scale: 7.5,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Textwidget(
                                                              textscalefector:
                                                                  1,
                                                              text: controller
                                                                      .hourQty
                                                                      .isEmpty
                                                                  ? "0"
                                                                  : controller
                                                                      .hourQty
                                                                      .value,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppStyles
                                                                  .appThemeColor,
                                                              fontSize: 12,
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 100,
                                                  child: TextFormField(
                                                    controller: controller
                                                        .hourQtyController,
                                                    textAlign: TextAlign.center,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter hours',
                                                      hintStyle:
                                                          const TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            "JosefinSans",
                                                      ),
                                                      labelStyle:
                                                          const TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            "JosefinSans",
                                                      ),
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                    onFieldSubmitted: (value) {
                                                      if (int.parse(value) >=
                                                          2) {
                                                        controller
                                                                .hourQty.value =
                                                            controller
                                                                .hourQtyController
                                                                .text
                                                                .toString();
                                                        int total = int.parse(
                                                                controller
                                                                    .biWeeklyListH[
                                                                        i]
                                                                    .servicePrice) *
                                                            int.parse(controller
                                                                .hourQty.value);
                                                        controller
                                                                .totalHourlyPrice
                                                                .value =
                                                            total.toString();
                                                        controller
                                                                .actualHourlyPrice
                                                                .value =
                                                            controller
                                                                .biWeeklyListH[
                                                                    i]
                                                                .servicePrice;

                                                        controller
                                                            .hourQtyController
                                                            .clear();
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          dismissDirection:
                                                              DismissDirection
                                                                  .horizontal,
                                                          backgroundColor:
                                                              AppStyles
                                                                  .appThemeColor,
                                                          content: Center(
                                                              child: Textwidget(
                                                            text:
                                                                "Minimum 2 hour services",
                                                            color: Colors.white,
                                                          )),
                                                        ));
                                                      }
                                                    },
                                                  ),
                                                ),

                                                // Textwidget(
                                                //   text: "\$${controller.weekly_list_h[i].servicePrice}",
                                                // ),
                                              ],
                                            ),
                                          ))
                                  else
                                    for (int i = 0;
                                        i < controller.monthlyListH.length;
                                        i++)
                                      Obx(
                                        () => Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10, top: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    "assets/icons/Vector (5).png",
                                                    scale: 4,
                                                    color:
                                                        AppStyles.appThemeColor,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Textwidget(
                                                            text: "Hourly ",
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          Textwidget(
                                                            text:
                                                                "( Minimum 2 hours services ) ",
                                                            fontSize: 13,
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Textwidget(
                                                            text:
                                                                "\$${controller.monthlyListH[i].servicePrice}",
                                                            fontSize: 12,
                                                            color: AppStyles
                                                                .appThemeColor,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Image.asset(
                                                            "assets/icons/cancelicon.png",
                                                            color: AppStyles
                                                                .appThemeColor,
                                                            scale: 7.5,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Textwidget(
                                                            textscalefector: 1,
                                                            text: controller
                                                                    .hourQty
                                                                    .isEmpty
                                                                ? "0"
                                                                : controller
                                                                    .hourQty
                                                                    .value,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: AppStyles
                                                                .appThemeColor,
                                                            fontSize: 12,
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                width: 100,
                                                child: TextFormField(
                                                  controller: controller
                                                      .hourQtyController,
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    hintText: 'Enter hours',
                                                    hintStyle: const TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "JosefinSans",
                                                    ),
                                                    labelStyle: const TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "JosefinSans",
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets.all(5),
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                  onFieldSubmitted: (value) {
                                                    if (int.parse(value) >= 2) {
                                                      controller.hourQty.value =
                                                          controller
                                                              .hourQtyController
                                                              .text
                                                              .toString();
                                                      int total = int.parse(
                                                              controller
                                                                  .monthlyListH[
                                                                      i]
                                                                  .servicePrice) *
                                                          int.parse(controller
                                                              .hourQty.value);
                                                      controller
                                                              .totalHourlyPrice
                                                              .value =
                                                          total.toString();
                                                      controller
                                                              .actualHourlyPrice
                                                              .value =
                                                          controller
                                                              .monthlyListH[i]
                                                              .servicePrice;

                                                      controller
                                                          .hourQtyController
                                                          .clear();
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        duration:
                                                            const Duration(
                                                                seconds: 1),
                                                        dismissDirection:
                                                            DismissDirection
                                                                .horizontal,
                                                        backgroundColor:
                                                            AppStyles
                                                                .appThemeColor,
                                                        content: Center(
                                                            child: Textwidget(
                                                          text:
                                                              "Minimum 2 hour services",
                                                          color: Colors.white,
                                                        )),
                                                      ));
                                                    }
                                                  },
                                                ),
                                              ),

                                              // Textwidget(
                                              //   text: "\$${controller.weekly_list_h[i].servicePrice}",
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                ],
                              )),

                    TextFieldDesignedOutline(
                      controller: controller.needsTextController,
                      maxLines: 3,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: SizedBox(
                          width: 10,
                          height: 60,
                          child: Image.asset(
                            "assets/icons/describeicon.png",
                            scale: 3.5,
                          ),
                        ),
                      ),
                      hintText: "Describe Your cleaning needs",
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Textwidget(
                          maxLines: 10,
                          text:
                              "Cleaner needs to wash and dry linen and towels",
                          fontSize: 12,
                        )),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              Textwidget(
                                text: "",
                                fontSize: 12,
                              ),
                              Obx(() => Switch(
                                  activeColor: AppStyles.appThemeColor,
                                  value: controller.isSwitched.value,
                                  onChanged: (value) {
                                    controller.toggleSwitch();
                                    if (value == true) {
                                      controller.washTowels.value = "1";
                                    } else {
                                      controller.washTowels.value = "0";
                                    }
                                  })),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Textwidget(
                          maxLines: 10,
                          text: "I provide cleaning supplies",
                          fontSize: 12,
                        )),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Textwidget(
                                text: "",
                                fontSize: 12,
                              ),
                              Obx(() => Switch(
                                  activeColor: AppStyles.appThemeColor,
                                  value: controller.isSwitchedProvide.value,
                                  onChanged: (value) {
                                    controller.toggleSwitchone();
                                    if (value == true) {
                                      controller.cleanerSupplies.value = "1";
                                    } else {
                                      controller.cleanerSupplies.value = "0";
                                    }
                                  })),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
            // if(controller.isLoading_Property_add.isFalse)
            //   SizedBox()
            // else
            //   ShowLoaderOn.isLoadingProgress(controller.isLoading_Property_add.value)
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: MyButton(
              text: "Next",
              onPressed: () {
                if (controller.serviceId.value == "1" ||
                    controller.serviceId.value == "2" ||
                    controller.serviceId.value == "4") {
                  controller.validationSD(context);
                } else if (controller.serviceId.value == "3" ||
                    controller.serviceId.value == "6") {
                  controller.validationSquerFeet(context);
                } else {
                  controller.validationHourly(context);
                }
                // var data = {
                //   "title": controller.title.value.toString(),
                //   "id": controller.id.value.toString(),
                //   "user_type": controller.user_type.value.toString(),
                //   "cleaner_cohost_id": controller.cleaner_cohost_id.value.toString(),
                //   "service_id": controller.service_id.value.toString(),
                // };
                //
                // Get.toNamed(Routes.EXTRAWORK_ADD_SCREEN, parameters: data);
              },
              color: AppStyles.appThemeColor,
              TextColor: AppStyles.backgroundColor),
        ),
      ),
    );
  }

  void updateServiceListIncrement(
      int index, lable, int newQty, int total, String actualPrice) {
// Check if the item already exists in the list
    int existingIndex = controller.serviceLableId.indexOf(lable.id.toString());

    if (newQty == 0) {
      // Clear lists if quantity is 0
      controller.serviceLableId.clear();
      controller.serviceTitleList.clear();
      controller.serviceQtyList.clear();
      controller.serviceTotalPriceList.clear();
    } else if (existingIndex == -1) {
      // If the item doesn't exist in the list, add it
      controller.serviceLableId.add(lable.id.toString());
      controller.serviceTitleList.add(lable.text.toString());
      controller.serviceQtyList.add(newQty);
      controller.serviceTotalPriceList.add(total);
      controller.serviceActualPrice.add(actualPrice);
    } else {
      // Otherwise, update the existing item
      controller.serviceQtyList[existingIndex] = newQty;
      controller.serviceTotalPriceList[existingIndex] = total;
    }

    // Debug print statements
    log("service_lable_id = ${controller.serviceLableId}");
    log("service_title_List = ${controller.serviceTitleList}");
    log("service_qty_list = ${controller.serviceQtyList}");
    log("service_price_list = ${controller.serviceTotalPriceList}");
  }

  void updateServiceListDecrement(
      int index, lable, int newQty, int total, String actualPrice) {
    if (newQty == 0) {
      // Clear lists if quantity is 0
      controller.serviceLableId.clear();
      controller.serviceTitleList.clear();
      controller.serviceQtyList.clear();
      controller.serviceTotalPriceList.clear();
    } else {
      // Update lists with the new quantity and total price
      if (controller.serviceQtyList.isEmpty ||
          controller.serviceQtyList.length <= index) {
        // If the list doesn't have an item at this index, add a new one
        controller.serviceLableId.add(lable.id.toString());
        controller.serviceTitleList.add(lable.text.toString());
        controller.serviceQtyList.add(newQty);
        controller.serviceTotalPriceList.add(total);
        controller.serviceActualPrice.add(actualPrice);
      } else {
        // Otherwise, update the existing item
        controller.serviceQtyList[index] = newQty;
        controller.serviceTotalPriceList[index] = total;
      }
    }

    // Debug print statements
    log("service_lable_id = ${controller.serviceLableId}");
    log("service_title_List = ${controller.serviceTitleList}");
    log("service_qty_list = ${controller.serviceQtyList}");
    log("service_price_list = ${controller.serviceTotalPriceList}");
  }
}
