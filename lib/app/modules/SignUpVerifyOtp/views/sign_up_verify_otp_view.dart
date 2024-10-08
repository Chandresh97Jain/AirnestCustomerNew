import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/app/modules/SignUpVerifyOtp/controllers/sign_up_verify_otp_controller.dart';

class SignUpVerifyOtpView extends GetView<SignUpVerifyOtpController> {
  const SignUpVerifyOtpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyles.OnbordingBodybackgroundColor,
        body: Obx(
          () => controller.isLoading.isFalse
              ? SingleChildScrollView(
                  child: SafeArea(
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
                                text: "Verify Code",
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                                color: AppStyles.appThemeColor,
                              ),
                              Textwidget(
                                textAlign: TextAlign.center,
                                maxLines: 50,
                                text: "Please enter the code we just sent to",
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: AppStyles.BlacklightTextcolor,
                              ),
                              Textwidget(
                                textAlign: TextAlign.center,
                                color: AppStyles.appThemeColor,
                                maxLines: 50,
                                text: controller.email.value,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
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
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Form(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Directionality(
                                              // Specify direction if desired
                                              textDirection: TextDirection.ltr,
                                              child: Pinput(
                                                controller: controller
                                                    .otpController.value,
                                                // focusNode: focusNode,
                                                androidSmsAutofillMethod:
                                                    AndroidSmsAutofillMethod
                                                        .smsUserConsentApi,
                                                listenForMultipleSmsOnAndroid:
                                                    true,
                                                // defaultPinTheme: defaultPinTheme,
                                                // validator: (value) {
                                                //   return value == controller.otp.value ? null : 'Pin is incorrect';
                                                // },
                                                // onClipboardFound: (value) {
                                                //   debugPrint('onClipboardFound: $value');
                                                //   pinController.setText(value);
                                                // },
                                                hapticFeedbackType:
                                                    HapticFeedbackType
                                                        .lightImpact,
                                                onCompleted: (pin) {
                                                  debugPrint(
                                                      'onCompleted: $pin');
                                                },
                                                onChanged: (value) {
                                                  debugPrint(
                                                      'onChanged: $value');
                                                },
                                                cursor: Container(),

                                                focusedPinTheme: controller
                                                    .defaultPinTheme
                                                    .copyWith(
                                                  decoration: controller
                                                      .defaultPinTheme
                                                      .decoration!
                                                      .copyWith(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    border: Border.all(),
                                                  ),
                                                ),
                                                submittedPinTheme: controller
                                                    .defaultPinTheme
                                                    .copyWith(
                                                  decoration: controller
                                                      .defaultPinTheme
                                                      .decoration!
                                                      .copyWith(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    border: Border.all(),
                                                  ),
                                                ),
                                                errorPinTheme: controller
                                                    .defaultPinTheme
                                                    .copyBorderWith(
                                                  border: Border.all(
                                                      color: Colors.redAccent),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    controller.start != 0
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 3, right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Textwidget(
                                                  textAlign: TextAlign.center,
                                                  color: Colors.black,
                                                  maxLines: 50,
                                                  text: 'Resend',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                Textwidget(
                                                  textAlign: TextAlign.center,
                                                  color:
                                                      AppStyles.appThemeColor,
                                                  maxLines: 50,
                                                  text: '00:'
                                                      "${controller.start.toString()}",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                ),
                                                Textwidget(
                                                  textAlign: TextAlign.center,
                                                  color:
                                                      AppStyles.appThemeColor,
                                                  maxLines: 50,
                                                  text: 'sec',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                ),
                                              ],
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Textwidget(
                                                textAlign: TextAlign.center,
                                                color: Colors.black,
                                                maxLines: 50,
                                                text: 'Did not recived OTP',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                onTap: () {
                                                  controller.start.value = 30;
                                                  // controller.isLoadingg(true);
                                                  controller.startTimer();
                                                  controller.resendApi();
                                                },
                                                child: Textwidget(
                                                  textAlign: TextAlign.center,
                                                  color:
                                                      AppStyles.appThemeColor,
                                                  maxLines: 50,
                                                  text: 'Resend',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    MyButton(
                                      onPressed: () {
                                        if (controller
                                                .otpController.value.text !=
                                            controller.otp.value) {
                                          ToastClass.showToast("Invalid OTP");
                                        } else {
                                          controller.verifyOtpApi();
                                        }
                                      },
                                      text: "Continue",
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
                )
              : ShowLoader.isLoadingProgress(controller.isLoading.value),
        ));
  }
}
