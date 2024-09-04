import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/modules/ChatbootverifyOtp/controllers/chatbootverify_otp_controller.dart';

class ChatbootverifyOtpView extends GetView<ChatbootverifyOtpController> {
  const ChatbootverifyOtpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,

      appBar: AppBar(
        titleSpacing: 5,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppStyles.backgroundColor,
        title: AppbarWithBackButton(
          text: 'Chat Bot Verification ',
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height /15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/chatbot1.png',scale: 5,),
                const SizedBox(width: 5,),
                Flexible(child: Textwidget(
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  text: "Hello I’m Chatty",fontWeight: FontWeight.w700,fontSize: 16,)),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 18,
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
                    text: "+1 9854-541-621",
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppStyles.backgroundColor),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Directionality(
                                // Specify direction if desired
                                textDirection: TextDirection.ltr,
                                child: Pinput(
                                  controller: controller.otpController.value,
                                  // focusNode: focusNode,
                                  androidSmsAutofillMethod:
                                      AndroidSmsAutofillMethod
                                          .smsUserConsentApi,
                                  listenForMultipleSmsOnAndroid: true,
                                  // defaultPinTheme: defaultPinTheme,
                                  // validator: (value) {
                                  //   return value == controller.otp.value ? null : 'Pin is incorrect';
                                  // },
                                  // onClipboardFound: (value) {
                                  //   debugPrint('onClipboardFound: $value');
                                  //   pinController.setText(value);
                                  // },
                                  hapticFeedbackType:
                                      HapticFeedbackType.lightImpact,
                                  onCompleted: (pin) {
                                    debugPrint('onCompleted: $pin');
                                  },
                                  onChanged: (value) {
                                    debugPrint('onChanged: $value');
                                  },
                                  cursor: Container(),

                                  focusedPinTheme:
                                      controller.defaultPinTheme.copyWith(
                                    decoration: controller
                                        .defaultPinTheme.decoration!
                                        .copyWith(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(),
                                    ),
                                  ),
                                  submittedPinTheme:
                                      controller.defaultPinTheme.copyWith(
                                    decoration: controller
                                        .defaultPinTheme.decoration!
                                        .copyWith(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(),
                                    ),
                                  ),
                                  errorPinTheme:
                                      controller.defaultPinTheme.copyBorderWith(
                                    border: Border.all(color: Colors.redAccent),
                                  ),
                                ),
                              ),
                              // TextButton(
                              //   onPressed: () {
                              //     // focusNode.unfocus();
                              //     // formKey.currentState!.validate();
                              //   },
                              //   child: const Text('Validate'),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/15,
                      ),
                      Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: MyButton(
                          onPressed: () {},
                          text: "Verify and Submit",
                          color: AppStyles.appThemeColor,
                          TextColor: AppStyles.backgroundColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
