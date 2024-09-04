import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/textformfield_ui_global.dart';
import 'package:power_maids/app/modules/ResetChangePassword/controllers/reset_change_password_controller.dart';


class ResetChangePasswordView extends GetView<ResetChangePasswordController> {
  const ResetChangePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.OnbordingBodybackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppStyles.backgroundColor,
        centerTitle: true,
      ),
      body: Obx(() => Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Textwidget(
                        text: "Create New Password",
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        color: AppStyles.appThemeColor,
                      ),
                      Textwidget(
                        textAlign: TextAlign.center,
                        maxLines: 50,
                        text: "Enter a password that is safe and easy to remember",
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
                    color: AppStyles.backgroundColor,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppStyles.backgroundColor),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 30),
                        child: Column(
                          children: [
                            Obx(() => TextFieldDesigned(
                                controller: controller.oldPasswordTextController,
                                obscureText: controller.obscureTextOldPassword.value,
                                prefixIcon: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                                  child: Image.asset(
                                    "assets/icons/Vector.png",
                                    scale: 3.5,
                                  ),
                                ),
                                hintText: "Old Password",
                                keyboardType: TextInputType.text,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.toggleOldPasswordVisibility();
                                    //  controller.obscureText.value = !controller.obscureText.value;
                                  },
                                  icon:
                                  Obx(() => controller.obscureTextOldPassword.value
                                      ? Image.asset(
                                    "assets/icons/style=linear.png",
                                    height: 25,
                                  )
                                      : Image.asset(
                                    "assets/icons/view.png",
                                    height: 25,
                                  )),
                                ))),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(() => TextFieldDesigned(
                                controller: controller.passwordTextController,
                                obscureText: controller.obscureTextPassword.value,
                                prefixIcon: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                                  child: Image.asset(
                                    "assets/icons/Vector.png",
                                    scale: 3.5,
                                  ),
                                ),
                                hintText: "New Password",
                                keyboardType: TextInputType.text,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.togglePasswordVisibility();
                                    //  controller.obscureText.value = !controller.obscureText.value;
                                  },
                                  icon:
                                  Obx(() => controller.obscureTextPassword.value
                                      ? Image.asset(
                                    "assets/icons/style=linear.png",
                                    height: 25,
                                  )
                                      : Image.asset(
                                    "assets/icons/view.png",
                                    height: 25,
                                  )),
                                ))),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(() => TextFieldDesigned(
                                controller:
                                controller.confirmPasswordTextController,
                                obscureText:
                                controller.obscureTextConfirmPassword.value,
                                prefixIcon: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                                  child: Image.asset(
                                    "assets/icons/Vector.png",
                                    scale: 3.5,
                                  ),
                                ),
                                hintText: "Confirm Password",
                                keyboardType: TextInputType.text,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.toggleConfirmPasswordVisibility();
                                    //  controller.obscureText.value = !controller.obscureText.value;
                                  },
                                  icon: Obx(() =>
                                  controller.obscureTextConfirmPassword.value
                                      ? Image.asset(
                                    "assets/icons/style=linear.png",
                                    height: 25,
                                  )
                                      : Image.asset(
                                    "assets/icons/view.png",
                                    height: 25,
                                  )),
                                ))),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: MyButton(
                                onPressed: () {
                                  controller.resetPasswordApi();
                                },
                                text: "Reset Password",
                                color: AppStyles.appThemeColor,
                                TextColor: AppStyles.backgroundColor,
                              ),
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
