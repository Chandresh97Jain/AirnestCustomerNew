import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/onbording_appbar.dart';
import 'package:power_maids/Utils/sd_constand.dart';
import 'package:power_maids/Utils/textformfield_ui_global.dart';
import 'package:power_maids/app/modules/SignIn/controllers/sign_in_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // Set a base font size
    double titleFontSize = 24.0;
    double secoundtitleFontSize = 19.0;
    double fontSizeForteen = 14.0;
    // Calculate the adjusted font size based on screen width
    double titleAdjustedFontSize = screenWidth / 350.0 * titleFontSize;
    double secoundtitleAdjustedFontSize =
        screenWidth / 370.0 * secoundtitleFontSize;
    double fontSizeForteenAdjustedFontSize =
        screenWidth / 350.0 * fontSizeForteen;

    return Obx(() => Scaffold(
          backgroundColor: AppStyles.OnbordingBodybackgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            surfaceTintColor: AppStyles.backgroundColor,
            elevation: 0,
            backgroundColor: AppStyles.backgroundColor,
            title: const OnbordingScreensAppbar(Title: "Sign In"),
            centerTitle: true,
          ),
          body: controller.isLoading.isFalse

              ? SingleChildScrollView(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Textwidget(
                              textscalefector: 1,
                              text: "Welcome Back!",
                              fontWeight: FontWeight.w700,
                              fontSize: titleAdjustedFontSize,
                              color: AppStyles.appThemeColor,
                            ),
                            Textwidget(
                              textscalefector: 1,
                              text: "Sign in to continue",
                              fontWeight: FontWeight.w400,
                              fontSize: secoundtitleAdjustedFontSize,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          surfaceTintColor: AppStyles.backgroundColor,
                          color: AppStyles.backgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 30),
                            child: Column(
                              children: [
                                Obx(() =>
                                TextFieldDesigned(

                                  controller: controller.emailTextController,
                                  prefixIcon: Image.asset(
                                    "assets/icons/Icon-Set.png",
                                    scale: 3.5,
                                  ),
                                  hintText: controller.emailHinttext.value,
                                  keyboardType: TextInputType.text,
                                  maxLength: 35,
                                ) ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Obx(() => TextFieldDesigned(
                                    controller:
                                        controller.passwordTextController,
                                    obscureText: controller.obscureText.value,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Image.asset(
                                        "assets/icons/Vector.png",
                                        scale: 3.5,
                                      ),
                                    ),
                                    hintText: "Password",
                                    keyboardType: TextInputType.text,
                                    maxLength: 30,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.togglePasswordVisibility();
                                        //  controller.obscureText.value = !controller.obscureText.value;
                                      },
                                      icon:
                                          Obx(() => controller.obscureText.value
                                              ? Image.asset(
                                                  "assets/icons/style=linear.png",
                                                  height: 25,
                                                )
                                              : Image.asset(
                                                  "assets/icons/view.png",
                                                  height: 25,
                                                )),
                                    )
                                )
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Row(
                                        children: [
                                          Obx(
                                            () => Checkbox(
                                              activeColor:
                                                  AppStyles.appThemeColor,
                                              value: controller.isChecked.value,
                                              onChanged: (bool? value) {
                                                controller.toggleRememberMe(value ?? false);
                                              },
                                            ),
                                          ),
                                          Flexible(
                                            child: Textwidget(
                                              textscalefector: 1,
                                              text: "Remember me",
                                              fontWeight: FontWeight.w400,
                                              fontSize:
                                                  fontSizeForteenAdjustedFontSize,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Get.toNamed(Routes.FORGOT_PASSWORD);
                                        },
                                        child: Textwidget(
                                          textscalefector: 1,
                                          text: "Forgot Password?",
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              fontSizeForteenAdjustedFontSize,
                                          color: Colors.black,
                                        ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),




                                MyButton(
                                  onPressed: () {

                                    log(controller.emailTextController.text);
                                    log(SDConstant.rememberedEmail);
                                    log(SDConstant.rememberedPassword);
                                    log(controller.passwordTextController.text);

                                     controller.validation(context);
                                  },
                                  text: "Sign in",
                                  color: AppStyles.appThemeColor,
                                  TextColor: AppStyles.backgroundColor,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 15),
                        child: Row(children: <Widget>[
                          Expanded(
                              child: Divider(
                            color: AppStyles.deviderColor,
                            thickness: 1,
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Textwidget(
                            textscalefector: 1,
                            fontSize: fontSizeForteenAdjustedFontSize,
                            text: "Or Login With",
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Divider(
                            color: AppStyles.deviderColor,
                            thickness: 1,
                          )),
                        ]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {

                                controller.signInWithFacebook();

                              },
                              icon: Image.asset(
                                "assets/icons/facebbok.png",
                                scale: 3.5,
                              )),
                          const SizedBox(
                            width: 8,
                          ),
                          IconButton(
                              onPressed: () {
                                controller.signInWithGoogle(context);
                                // controller.handleSignIn(context);
                                // controller.handleSignIn2();
                              },
                              icon: Image.asset(
                                "assets/icons/Google (1).png",
                                scale: 3.5,
                              )),
                          const SizedBox(
                            width: 8,
                          ),
                          if (Platform.isAndroid)
                            const SizedBox()
                          else
                            IconButton(
                                onPressed: () {
                                  controller.onAppleLogin();
                                },
                                icon: Image.asset(
                                  "assets/icons/Apple.png",
                                  scale: 3.5,
                                )),
                        ],
                      )
                    ],
                  ),
                )
              : ShowLoader.isLoadingProgress(controller.isLoading.value),
          bottomNavigationBar: controller.isLoading.isFalse
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  child: Padding(
                    padding: MediaQuery.viewInsetsOf(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Textwidget(
                          textscalefector: 1,
                          text: "Don't have an account?",
                          fontSize: fontSizeForteenAdjustedFontSize,
                          fontWeight: FontWeight.w500,
                        )),
                        Flexible(
                            child: TextButton(
                                onPressed: () {
                                  controller.emailTextController.clear();
                                  controller.passwordTextController.clear();
                                  Get.offAllNamed(Routes.SIGN_UP);
                                },
                                child: Textwidget(
                                  textscalefector: 1,
                                  text: "Sign up",
                                  fontSize: fontSizeForteenAdjustedFontSize,
                                  fontWeight: FontWeight.w700,
                                  color: AppStyles.appThemeColor,
                                )))
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
        ));
  }
}
