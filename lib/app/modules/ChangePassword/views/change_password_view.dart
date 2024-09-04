import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/textformfield_ui_global.dart';
import 'package:power_maids/app/modules/ChangePassword/controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyles.OnbordingBodybackgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppStyles.backgroundColor,
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: Obx(
          () => controller.isLoading.isFalse
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 4.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Textwidget(
                              text: "Change Password",
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              color: AppStyles.appThemeColor,
                            ),
                            Textwidget(
                              textAlign: TextAlign.center,
                              maxLines: 50,
                              text:
                                  "Enter your phone, we will send a verification code to your mobile",
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppStyles.BlacklightTextcolor,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppStyles.backgroundColor),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 30),
                              child: Column(
                                children: [
                                  TextFieldDesigned(
                                    maxLength: 10,
                                    controller: controller.mobileController,
                                    prefixIcon: Image.asset(
                                      "assets/icons/phoneIcon.png",
                                      scale: 3.5,
                                    ),
                                    hintText: "Phone Number",
                                    keyboardType: TextInputType.phone,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  MyButton(
                                    onPressed: () {
                                      controller.onSubmit();
                                    },
                                    text: "Send OTP",
                                    color: AppStyles.appThemeColor,
                                    TextColor: AppStyles.backgroundColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : ShowLoader.isLoadingProgress(controller.isLoading.value),
        ));
  }
}
