import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/textformfield_ui_global.dart';
import 'package:power_maids/app/modules/SelectServices/controllers/select_services_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';

class SelectServicesView extends GetView<SelectServicesController> {
  const SelectServicesView({Key? key}) : super(key: key);
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
          text: controller.title.value,
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
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => TextFieldDesignedOutline(
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
                      height: 10,
                    ),
                    Textwidget(
                      maxLines: 5,
                      fontWeight: FontWeight.w700,
                      text: controller.nextScreendis.value,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListView.builder(
                        itemCount: controller.serviceList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (buildContext, index) {
                          var serviceList = controller.serviceList[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                controller.selectedServiceId.value =
                                    serviceList.id.toString();
                                controller.selectedServiceName.value =
                                    serviceList.title.toString();
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
                                      horizontal: 10, vertical: 15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(() =>
                                          controller.selectedServiceId.value ==
                                                  serviceList.id.toString()
                                              ? Image.asset(
                                                  "assets/icons/graycirculefill.png",
                                                  scale: 3.3,
                                                )
                                              : Image.asset(
                                                  "assets/icons/graycircule.png",
                                                  scale: 3.3,
                                                )),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Textwidget(
                                              maxLines: 5,
                                              text: serviceList.title,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                  ],
                ),
              ),
            ),
            controller.isLoading.isTrue
                ? ShowLoader.isLoadingProgress(controller.isLoading.value)
                : const SizedBox()
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 8, top: 8),
        child: Padding(
          padding: MediaQuery.viewInsetsOf(context),
          child: MyButton(
            onPressed: () {
              if (controller.userType.value.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 1),
                  dismissDirection: DismissDirection.horizontal,
                  backgroundColor: AppStyles.appThemeColor,
                  content: Center(
                      child: Textwidget(
                    text: "Please select user type",
                    color: Colors.white,
                  )),
                ));
              } else if (controller
                  .googleMapService.addressController.value.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 1),
                  dismissDirection: DismissDirection.horizontal,
                  backgroundColor: AppStyles.appThemeColor,
                  content: Center(
                      child: Textwidget(
                    text: "Please enter zip code",
                    color: Colors.white,
                  )),
                ));
              } else if (controller.selectedServiceId.value.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 1),
                  dismissDirection: DismissDirection.horizontal,
                  backgroundColor: AppStyles.appThemeColor,
                  content: Center(
                      child: Textwidget(
                    text: "Please select a service",
                    color: Colors.white,
                  )),
                ));
              } else {
                var data = {
                  "title": controller.title.toString(),
                  "id": controller.id.toString(),
                  'user_type': controller.userType.value,
                  'address':
                      controller.googleMapService.addressController.value.text,
                  'lat': controller.googleMapService.latitude.value.toString(),
                  'long':
                      controller.googleMapService.longitude.value.toString(),
                };

                if (controller.id.value == "0") {
                  Get.toNamed(Routes.CLEANER_And_Cohost_LIST, parameters: data);
                } else if (controller.id.value == "1") {
                  Get.toNamed(Routes.CLEANER_And_Cohost_LIST, parameters: data);
                } else if (controller.id.value == "2") {
                  Get.toNamed(Routes.ADD_REQUIREMENT_CLEANER, parameters: data);
                }
              }
            },
            text: "Next",
            color: AppStyles.appThemeColor,
            TextColor: AppStyles.backgroundColor,
          ),
        ),
      ),
    );
  }
}
