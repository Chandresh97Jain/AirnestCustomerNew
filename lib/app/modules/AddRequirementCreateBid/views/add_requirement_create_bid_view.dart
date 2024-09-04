import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/textformfield_ui_global.dart';
import 'package:power_maids/app/modules/AddRequirementCreateBid/controllers/add_requirement_create_bid_controller.dart';


class AddRequirementCreateBidView
    extends GetView<AddRequirementCreateBidController> {
  const AddRequirementCreateBidView({Key? key}) : super(key: key);
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
      body: Obx(() => Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
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
                    height: 12,
                  ),
                  Textwidget(
                    text: "Confirm your property details",
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  const SizedBox(
                    height: 12,
                  ),

                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppStyles.TextformfeildOutlineColor,
                            width: 0.7)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5),
                      child: Row(
                        children: [
                          const SizedBox(width: 15,),
                          Image.asset(
                            "assets/images/property.png",
                            scale: 23,
                            color: AppStyles.appThemeColor,
                          ),
                          Obx(() => Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 15, right: 25),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  alignment: Alignment.centerLeft,
                                  hint: const Text(
                                    "Select your property (Optional)",
                                    style: TextStyle(
                                      color:  Color(0xff5d5d5d),
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      letterSpacing: 0.8,
                                      fontFamily: 'JosefinSans',
                                    ),
                                  ),
                                  value: controller.show2.value == true ? controller.selectPropertyId.value.toString() : null,
                                  icon: controller.selectPropertyId.value == null
                                      ? Icon(Icons.keyboard_arrow_down_outlined)
                                      : InkWell(
                                      onTap: (){
                                        controller.propertySizeSQFT_pro.value = "";
                                        controller.selectPropertyId.value = null;
                                        controller.googleMapService.addressController.value.text = "";
                                        controller.googleMapService.latitude.value = "";
                                        controller.googleMapService.longitude.value = "";
                                        controller.nameTextController.value.text = "";
                                        controller.show.value = false;
                                        controller.show2.value = false;
                                      },
                                      child: Icon(Icons.close)
                                  ),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  underline: Container(),
                                  onChanged: (newValue) {
                                    controller.show2.value = true;
                                    controller.show.value = true;
                                    controller.selectPropertyId.value = newValue.toString();

                                    log("newValue  --  -- ${newValue.toString()}");
                                  },
                                  items: controller.propertyList.map((item) {
                                    return DropdownMenuItem<String>(
                                      onTap: () {
                                        controller.show2.value = true;
                                        controller.show.value = true;
                                        controller.propertySizeSQFT_pro.value = "${item.propertySize.toString()}";
                                        controller.googleMapService.addressController.value.text = "${item.address}";
                                        controller.googleMapService.latitude.value = "${item.latitude}";
                                        controller.googleMapService.longitude.value = "${item.longitude}";
                                        controller.nameTextController.value.text = "${item.name}";

                                        log("property-size --  -- ${controller.propertySizeSQFT_pro.value.toString()}");
                                        log("address --  -- ${item.address.toString()}");
                                        log("name --  -- ${item.name.toString()}");
                                        log("lalitude --  -- ${item.latitude.toString()}");
                                        log("longitude --  -- ${item.longitude.toString()}");

                                        controller.propertySizeSQFT.value = "${item.propertySize.toString()}";

                                      },
                                      value: item.id.toString(), // Ensure unique value
                                      child: Text(
                                        item.name,
                                        style: const TextStyle(fontFamily: "JosefinSans"),
                                      ),
                                    );
                                  }).toList(),
                                )
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),


                  const SizedBox(
                    height: 12,
                  ),
                  TextFieldDesignedOutline(
                    controller: controller.nameTextController.value,
                    enabled: controller.selectPropertyId.value==null?true:false,
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
                    enabled: controller.selectPropertyId.value==null?true:false,
                    controller: controller.googleMapService.addressController.value,

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
                        if(controller.googleMapService.addressController.value.text.isEmpty){
                          controller.googleMapService.getCurrentLocation();
                        }else{
                          {}
                        }
                      },
                      icon: controller.googleMapService.addressController.value.text.isEmpty && controller.googleMapService.isFocused.value==false
                          ? Textwidget(text: "Current Location", color: AppStyles.appThemeColor)
                          : const SizedBox(),
                    ),
                    onChanged: (v) {
                      controller.googleMapService.googlePlacesApi(v);
                      // controller.googleMapService.addressController.value.text = v;
                      if(v.isEmpty){
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                  )),
                  Obx(() => controller.googleMapService.placesList.isEmpty
                      ? const SizedBox()
                      : ListView.builder(
                    itemCount: controller.googleMapService.placesList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(controller.googleMapService.placesList[index].description),
                        onTap: () {
                          controller.googleMapService.addressController.value.text = controller.googleMapService.placesList[index].description;
                          controller.googleMapService.getPlaceDetails(controller.googleMapService.placesList[index].placeId.toString());
                          controller.googleMapService.placesList.clear();
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      );
                    },
                  )),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppStyles.TextformfeildOutlineColor,
                            width: 0.7)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5),
                      child: Row(
                        children: [
                          const SizedBox(width: 15,),
                          Image.asset(
                            "assets/icons/aptIcon.png",
                            scale: 3.5,
                          ),
                          Obx(() => Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 15, right: 25),
                                child:  DropdownButton(
                                  isExpanded: true,
                                  alignment: Alignment.centerLeft,
                                  hint: const Text("Property size",
                                    style: TextStyle(
                                      color:  Color(0xff5d5d5d),
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      letterSpacing: 0.8,
                                      fontFamily: 'JosefinSans',
                                    ),
                                  ),
                                  value: controller.show.value == true?controller.propertySizeSQFT.value:null,
                                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  underline: Container(),
                                  onChanged: (newValue) {
                                    controller.show.value = true;
                                    controller.propertySizeSQFT.value = newValue.toString();

                                    log("newValue --  -- ${newValue.toString()}");
                                  },
                                  items: controller.sqrFeetList.map((item) {
                                    return DropdownMenuItem(
                                      onTap: (){
                                        controller.propertySizeSQFT.value = "Under ${item.squareFeet} sq. ft";
                                        log("property-size --  -- ${controller.propertySizeSQFT.value.toString()}");
                                      },
                                      value: "Under ${item.squareFeet} sq. ft",
                                      child: Text("Under ${item.squareFeet} sq. ft",
                                        style: const TextStyle(fontFamily: "JosefinSans"),
                                      ),
                                    );
                                  }).toList(),
                                )
                            ),
                          ),)

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
                  //               text: "I don’t know the Property size",
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
                                      color: AppStyles.TextformfeildOutlineColor,
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
                                              text: DateFormat('dd-MM-yyyy').format(
                                                  controller.selectedDate.value!),
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
                                      color: AppStyles.TextformfeildOutlineColor,
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
                                              text: controller.selectedTime.value!
                                                  .format(context),
                                            );
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ))),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
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
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                        itemCount: controller.serviceTypeList.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (buildContext, index) {
                          var servideList = controller.serviceTypeList[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                controller.selectedServiceTypeId.value = servideList.id.toString();
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(() => controller.selectedServiceTypeId.value ==
                                      servideList.id.toString()
                                      ? Image.asset(
                                    "assets/icons/graycirculefill.png",
                                    scale: 3,
                                  )
                                      : Image.asset(
                                    "assets/icons/graycircule.png",
                                    scale: 3,
                                  )
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Textwidget(
                                    maxLines: 5,
                                    text: servideList.title,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
          controller.isLoading.isTrue
              ?ShowLoader.isLoadingProgress(controller.isLoading.value)
              : const SizedBox()
        ],
      ),),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
        child: Padding(
          padding: MediaQuery.viewInsetsOf(context),
          child: MyButton(
              text: "Next",
              onPressed: () {
              controller.validation(context);
              },
              color: AppStyles.appThemeColor,
              TextColor: AppStyles.backgroundColor),
        ),
      ),
    );
  }
}
