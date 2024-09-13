import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/textformfield_ui_global.dart';
import 'package:power_maids/app/modules/CreateBidForCleanerAndCohost/controllers/create_bid_for_cleaner_and_cohost_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';


class CreateBidForCleanerAndCohostView
    extends GetView<CreateBidForCleanerAndCohostController> {
  const CreateBidForCleanerAndCohostView({Key? key}) : super(key: key);
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
          text: "Create a bid & Find\nthe best cleaner and co-host",
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: false,
      ),
      body: Obx(() =>  Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                        itemCount: controller.selectbid.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (buildContext, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                controller.selectedBid.value = index;

                                log("controller.selectedBid.value -- ${controller.selectedBid.value.toString()}");

                                if(controller.selectedBid.value == 0){
                                  controller.serviceListApi("1");
                                  controller.userType.value = "1";
                                  controller.selectedServiceId.value = "";
                                }else{
                                  controller.serviceListApi("2");
                                  controller.userType.value = "2";
                                  controller.selectedServiceId.value = "";
                                }

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
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Obx(() =>
                                      controller.selectedBid.value == index
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
                                      Textwidget(
                                        maxLines: 5,
                                        text: controller.selectbid[index],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: 10,),


                  TextFieldDesignedOutline(
                    controller: controller.zipTextController,
                    prefixIcon: Image.asset(
                      "assets/icons/addressIcon.png",
                      scale: 3,
                    ),
                    hintText: "Zipcode",
                    maxLength: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Textwidget(
                    maxLines: 5,
                    fontWeight: FontWeight.w700,
                    text: controller.selectedBid.value == 0 ?"What type of cleaning do you "
                        "need?":"Property Management",
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
                              controller.selectedServiceId.value = serviceList.id.toString();
                              controller.selectedServiceName.value = serviceList.title.toString();
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
                                    horizontal: 10, vertical: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() => controller.selectedServiceId.value == serviceList.id.toString()
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
              ?ShowLoader.isLoadingProgress(controller.isLoading.value)
              : const SizedBox()
        ],
      ),),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 8, top: 8),
        child: Padding(
          padding: MediaQuery.viewInsetsOf(context),
          child: MyButton(
            onPressed: () {
              if(controller.userType.value.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const  Duration(seconds: 1),
                  dismissDirection: DismissDirection.horizontal,
                  backgroundColor: AppStyles.appThemeColor,
                  content: Center(child: Textwidget(text: "Please select user type",color: Colors.white,)),
                ));
              }else if(controller.zipTextController.text.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 1),
                  dismissDirection: DismissDirection.horizontal,
                  backgroundColor: AppStyles.appThemeColor,
                  content: Center(child: Textwidget(text: "Please enter zip code",color: Colors.white,)),
                ));
              }else if(controller.selectedServiceId.value.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 1),
                  dismissDirection: DismissDirection.horizontal,
                  backgroundColor: AppStyles.appThemeColor,
                  content: Center(child: Textwidget(text: "Please select a service",color: Colors.white,)),
                ));
              }else{
                 var data = {
                   'user_type' : controller.userType.value,
                   'zip_code' : controller.zipTextController.text,
                   'service_id' : controller.selectedServiceId.value,
                   'selected_Bid' : controller.selectedServiceId.value,
                   'service_name' : controller.selectedServiceName.value,
                 };
          
                Get.toNamed(Routes.ADD_REQUIREMENT_CREATE_BID,parameters: data);
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
