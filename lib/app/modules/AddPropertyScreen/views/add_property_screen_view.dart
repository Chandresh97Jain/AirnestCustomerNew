import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/nodata_image.dart';
import 'package:power_maids/Utils/textformfield_ui_global.dart';
import 'package:power_maids/app/modules/AddPropertyScreen/controllers/add_property_screen_controller.dart';

class AddPropertyScreenView extends GetView<AddPropertyScreenController> {
  const AddPropertyScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: AppStyles.backgroundColor,
          appBar: AppBar(
            surfaceTintColor: AppStyles.backgroundColor,
            titleSpacing: 5,
            toolbarHeight: 70,
            automaticallyImplyLeading: false,
            elevation: 1,
            backgroundColor: AppStyles.backgroundColor,
            title: AppbarWithBackButton(
              text: "My Property",
              onPressed: () {
                Get.back();
              },
            ),
            centerTitle: false,
          ),
          body: Visibility(
            visible: controller.isLoadingGetProperty.isFalse &&
                controller.isLoadingAddProperty.isFalse,
            replacement: ShowLoaderr.isLoadingProgress(),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: controller.propertyList.isNotEmpty,
                      replacement: NoDataFound(
                        height: MediaQuery.of(context).size.height / 1.3,
                      ),
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.propertyList.length,
                          itemBuilder: (buildContext, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color:
                                                    AppStyles.appThemeColor)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            "assets/icons/aptIcon.png",
                                            scale: 3.5,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Textwidget(
                                              maxLines: 2,
                                              text: controller
                                                  .propertyList[index].name,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            Textwidget(
                                              maxLines: 3,
                                              text: controller
                                                  .propertyList[index].address,
                                              fontSize: 12,
                                            ),
                                            Textwidget(
                                              text: controller
                                                  .propertyList[index]
                                                  .propertySize,
                                              fontSize: 12,
                                              color:
                                                  AppStyles.GraylightTextColor,
                                            ),
                                          ],
                                        ),
                                      ),


                                      Visibility(
                                        visible: controller.propertyList[index].isBid.toString()=="0" && controller.propertyList[index].isBooked.toString()=="0",
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: PopupMenuButton(
                                                icon: Icon(
                                                  Icons.more_vert_rounded,
                                                  color: AppStyles.appThemeColor,
                                                ),
                                                color: AppStyles.appThemeColor,
                                                surfaceTintColor:
                                                    AppStyles.appThemeColor,
                                                itemBuilder:
                                                    (BuildContext context) {
                                                  return [
                                                    PopupMenuItem<int>(
                                                      onTap: () {
                                                        controller.propertyId.value =
                                                            controller
                                                                .propertyList[
                                                                    index]
                                                                .id
                                                                .toString();
                                                        controller
                                                                .propertyNameUpdateController
                                                                .text =
                                                            controller
                                                                .propertyList[
                                                                    index]
                                                                .name
                                                                .toString();
                                                        controller
                                                                .googleMapService
                                                                .addressController
                                                                .value
                                                                .text =
                                                            controller
                                                                .propertyList[
                                                                    index]
                                                                .address
                                                                .toString();
                                                        controller
                                                                .googleMapService
                                                                .latitude
                                                                .value =
                                                            controller
                                                                .propertyList[
                                                                    index]
                                                                .latitude
                                                                .toString();
                                                        controller.googleMapService.longitude.value = controller.propertyList[index].longitude.toString();
                                                        controller.propertySize.value  = controller.propertyList[index].propertySize.toString();



                                                        bottomSheetForEditProperty(context);
                                                      },
                                                      height: 30,
                                                      value: 0,
                                                      child: Center(
                                                          child: Textwidget(
                                                        text: "Edit",
                                                        color: AppStyles
                                                            .backgroundColor,
                                                      )),
                                                    ),
                                                    PopupMenuItem<int>(
                                                      onTap: () async {
                                                        final propertyId =
                                                            controller
                                                                .propertyList[
                                                                    index]
                                                                .id
                                                                .toString();
                                                        await controller
                                                            .removeProperty(
                                                                propertyId:
                                                                    propertyId,
                                                                index: index);
                                                      },
                                                      height: 30,
                                                      value: 0,
                                                      child: Center(
                                                          child: Textwidget(
                                                        text: "Remove",
                                                        color: AppStyles
                                                            .backgroundColor,
                                                      )),
                                                    ),
                                                  ];
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Visibility(
            visible: controller.isLoadingGetProperty.isFalse && controller.isLoadingAddProperty.isFalse && controller.isLoadingUpdateProperty.isFalse,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: MyButton(
                    text: "Add Property",
                    onPressed: () {
                      controller.clearFields();
                      bottomSheetForAddProperty(context);
                    },
                    color: AppStyles.appThemeColor,
                    TextColor: AppStyles.backgroundColor),
              ),
            ),
          ),
        ));
  }

  void bottomSheetForAddProperty(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppStyles.backgroundColor,
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Textwidget(
                    text: "Add your property details",
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFieldDesignedOutline(
                    prefixIcon: SizedBox(
                      width: 10,
                      height: 60,
                      child: Image.asset(
                        "assets/icons/fn.png",
                        scale: 3.5,
                      ),
                    ),
                    hintText: "Property Name",
                    controller: controller.propertyNameController,
                    keyboardType: TextInputType.text,
                    maxLength: 30,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Obx(() => TextFieldDesignedOutline(
                        enabled: true,
                        controller:
                            controller.googleMapService.addressController.value,
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
                              controller.googleMapService.getCurrentLocation();
                            } else {
                              {}
                            }
                          },
                          icon: controller.googleMapService.addressController
                                      .value.text.isEmpty &&
                                  controller.googleMapService.isFocused.value ==
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
                                        ? controller.propertySizeId.value
                                        : null,
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    underline: Container(),
                                    onChanged: (newValue) {
                                      controller.show.value = true;
                                      controller.propertySizeId.value = newValue.toString();
                                      // controller.coHostServicesPriceApi();
                                      //
                                      // log("property-ID --  -- ${controller.propertySizeId.value}");
                                    },
                                    items: controller.sqrFeetList.map((item) {
                                      return DropdownMenuItem(
                                        onTap: () {
                                          controller.propertySize.value = "Under ${item.squareFeet} sq. ft";
                                          controller.propertySizeSqrFeet.value = item.squareFeet;
                                          log("property-size --  -- ${controller.propertySize.value}");
                                        },
                                        value: item.id.toString(),
                                        child: Text("Under ${item.squareFeet} sq. ft",
                                          style: const TextStyle(fontFamily: "JosefinSans"),
                                        ),
                                      );
                                    }).toList(),
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyButton(
                            text: "Save",
                            onPressed: () {
                              if (controller
                                  .propertyNameController.text.isEmpty) {
                                ToastClass.showToast(
                                  'Enter Property name',
                                );
                              } else if (controller.googleMapService
                                  .addressController.value.text.isEmpty) {
                                ToastClass.showToast(
                                  'Enter address',
                                );
                              } else if (controller.propertySizeId.value ==
                                  null) {
                                ToastClass.showToast(
                                  'Select property size',
                                );
                              } else {
                                controller.addProperty();
                                Get.back();
                              }
                            },
                            color: AppStyles.appThemeColor,
                            TextColor: AppStyles.backgroundColor),
                      ),
                      Expanded(
                        child: MyButton(
                            text: "Cancel",
                            onPressed: () {
                              Get.back();
                            },
                            color: AppStyles.backgroundColor,
                            TextColor: AppStyles.BlackColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void bottomSheetForEditProperty(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppStyles.backgroundColor,
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Textwidget(
                    text: "Edit your property details",
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFieldDesignedOutline(
                    prefixIcon: SizedBox(
                      width: 10,
                      height: 60,
                      child: Image.asset(
                        "assets/icons/fn.png",
                        scale: 3.5,
                      ),
                    ),
                    hintText: "Property Name",
                    controller: controller.propertyNameUpdateController,
                    keyboardType: TextInputType.text,
                    maxLength: 30,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Obx(() => TextFieldDesignedOutline(
                        enabled: true,
                        controller:
                            controller.googleMapService.addressController.value,
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
                              controller.googleMapService.getCurrentLocation();
                            } else {
                              {}
                            }
                          },
                          icon: controller.googleMapService.addressController
                                      .value.text.isEmpty &&
                                  controller.googleMapService.isFocused.value ==
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
                                        ? controller.propertySizeId.value
                                        : null,
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    underline: Container(),
                                    onChanged: (newValue) {
                                      controller.show.value = true;
                                      controller.propertySizeId.value =
                                          newValue.toString();
                                      // controller.coHostServicesPriceApi();
                                      //
                                      // log("property-ID --  -- ${controller.propertySizeId.value}");
                                    },
                                    items: controller.sqrFeetList.map((item) {
                                      return DropdownMenuItem(
                                        onTap: () {
                                          controller.propertySize.value =
                                              "Under ${item.squareFeet} sq. ft";
                                          controller.propertySizeSqrFeet.value =
                                              item.squareFeet;
                                          log("property-size --  -- ${controller.propertySize.value}");
                                        },
                                        value: item.id.toString(),
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
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyButton(
                            text: "Edit",
                            onPressed: () {
                              if (controller
                                  .propertyNameUpdateController.text.isEmpty) {
                                ToastClass.showToast(
                                  'Enter Property name',
                                );
                              } else if (controller.googleMapService
                                  .addressController.value.text.isEmpty) {
                                ToastClass.showToast(
                                  'Enter address',
                                );
                              } else if (controller.propertySizeId.value ==
                                  null) {
                                ToastClass.showToast(
                                  'Select property size',
                                );
                              } else {
                                controller.updateProperty(
                                    propertyId: controller.propertyId);
                                Get.back();
                              }
                            },
                            color: AppStyles.appThemeColor,
                            TextColor: AppStyles.backgroundColor),
                      ),
                      Expanded(
                        child: MyButton(
                            text: "Cancel",
                            onPressed: () {
                              Get.back();
                            },
                            color: AppStyles.backgroundColor,
                            TextColor: AppStyles.BlackColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
