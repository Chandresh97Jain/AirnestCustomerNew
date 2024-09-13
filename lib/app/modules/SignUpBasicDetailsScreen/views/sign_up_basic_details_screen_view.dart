import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/textformfield_ui_global.dart';
import 'package:power_maids/app/modules/SignUpBasicDetailsScreen/controllers/sign_up_basic_details_screen_controller.dart';

class SignUpBasicDetailsScreenView
    extends GetView<SignUpBasicDetailsScreenController> {
  const SignUpBasicDetailsScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyles.OnbordingBodybackgroundColor,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: AppStyles.backgroundColor,
          centerTitle: true,
        ),
        body: Obx(() => Visibility(
              visible: controller.isLoading.isFalse,
              replacement:
                  ShowLoader.isLoadingProgress(controller.isLoading.value),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 15,
                          ),
                          Textwidget(
                            text: "Welcome ${"Jaydeep"}",
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                            color: AppStyles.appThemeColor,
                          ),
                          Textwidget(
                            text: "Enter Basic Details",
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      color: AppStyles.backgroundColor,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppStyles.backgroundColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Textwidget(
                                maxLines: 5,
                                text:
                                    "What’s your main goal for joining Airnest?",
                                color: AppStyles.BlacklightTextcolor,
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              ToggleButtons(
                                borderColor: AppStyles.appThemeColor, // Border color of buttons
                                selectedBorderColor: AppStyles.appThemeColor, // Border color when selected
                                selectedColor: Colors.white, // Text color when selected
                                fillColor: AppStyles.appThemeColor, // Background color when selected
                                color: AppStyles.appThemeColor, // Text color when not selected
                                borderRadius: BorderRadius.circular(10),
                                isSelected: controller.isSelected,
                                onPressed: (int index) {
                                    // Toggle selection
                                    for (int i = 0; i < controller.isSelected.length; i++) {
                                      controller.isSelected[i] = i == index; // Select the pressed button
                                    }
                                }, // Border radius for buttons
                                children: const <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Text('Cleaning Services'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Text('Property Management'),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 20,
                              ),
                              Textwidget(
                                maxLines: 5,
                                text: "How many properties require service today?",
                                color: AppStyles.BlacklightTextcolor,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFieldDesigned(
                                controller: controller.propertycontroller,
                                maxLength: 40,
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Textwidget(
                                maxLines: 5,
                                text: "Do you currently work with a property management service provider?",
                                color: AppStyles.BlacklightTextcolor,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFieldDesigned(
                                controller: controller.pmsController,
                                maxLength: 40,
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              MyButton(

                                text: "Continue",
                                onPressed: () {
                                  // Future.delayed(const Duration(seconds: 3),
                                  //     controller.navigateUser);
                               if (controller.propertycontroller.text.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      duration: const Duration(seconds: 1),
                                      dismissDirection:
                                          DismissDirection.horizontal,
                                      backgroundColor: AppStyles.appThemeColor,
                                      content: Center(
                                          child: Textwidget(
                                        text:
                                            "Please enter how many properties do you manage",
                                        color: Colors.white,
                                      )),
                                    ));
                                  } else if (controller.pmsController.text.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      duration: const Duration(seconds: 1),
                                      dismissDirection:
                                          DismissDirection.horizontal,
                                      backgroundColor: AppStyles.appThemeColor,
                                      content: Center(
                                          child: Textwidget(
                                        text:
                                            "Please enter do you work with a PMS",
                                        color: Colors.white,
                                      )),
                                    ));
                                  } else {
                                    controller.basicDetailsApi();
                                    // showDialog(
                                    //     barrierDismissible: false,
                                    //     context: context,
                                    //     builder: (BuildContext context) {
                                    //       return AlertDialog(
                                    //         shape: RoundedRectangleBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(20)),
                                    //         elevation: 0,
                                    //         contentPadding: EdgeInsets.zero,
                                    //         titlePadding: EdgeInsets.zero,
                                    //         content: Padding(
                                    //           padding: const EdgeInsets.only(
                                    //               left: 15,
                                    //               right: 15,
                                    //               top: 20,
                                    //               bottom: 20),
                                    //           child: Column(
                                    //             mainAxisSize: MainAxisSize.min,
                                    //             children: [
                                    //               Image.asset(
                                    //                 "assets/images/signupwaitimage.png",
                                    //                 scale: 4,
                                    //               ),
                                    //               const SizedBox(
                                    //                 height: 5,
                                    //               ),
                                    //               Textwidget(
                                    //                 maxLines: 5,
                                    //                 textAlign: TextAlign.center,
                                    //                 fontWeight: FontWeight.w700,
                                    //                 fontSize: 15,
                                    //                 text: "Sign up Successful",
                                    //                 color: AppStyles.appThemeColor,
                                    //               ),
                                    //               Textwidget(
                                    //                 fontSize: 13,
                                    //                 textAlign: TextAlign.center,
                                    //                 maxLines: 5,
                                    //                 text:
                                    //                     "please Wait... You will be directed to the welcome screen",
                                    //               ),
                                    //               const SizedBox(
                                    //                 height: 5,
                                    //               ),
                                    //               SpinKitCircle(
                                    //                 color: AppStyles.appThemeColor,
                                    //                 size: 70.0,
                                    //               )
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       );
                                    //     });
                                  }
                                },
                                color: AppStyles.appThemeColor,
                                TextColor: AppStyles.backgroundColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
