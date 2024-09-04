import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/textformfield_ui_global.dart';
import 'package:power_maids/app/modules/ForgotPassword/controllers/forgot_password_controller.dart';


class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);
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
      body: Obx(() => Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Textwidget(
                        text: "Forgot Password?",
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
                              controller: controller.mobileTextController,
                              prefixIcon: Image.asset(
                                "assets/icons/phoneIcon.png",
                                scale: 3.5,
                              ),
                              hintText: "Phone Number",
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MyButton(
                              onPressed: () {
                                controller.validation(context);
                                // Get.toNamed(Routes.VERICATION_OTP);
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
          ),
          controller.isLoading.isTrue
              ?ShowLoader.isLoadingProgress(controller.isLoading.value)
              : const SizedBox()
        ],
      ),)
    );
  }
}
