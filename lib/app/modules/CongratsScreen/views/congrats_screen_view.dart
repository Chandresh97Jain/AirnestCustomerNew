import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/modules/CongratsScreen/controllers/congrats_screen_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';

class CongratsScreenView extends GetView<CongratsScreenController> {
  const CongratsScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height/6,),
                Center(
                    child: Image.asset(
                  "assets/images/CongratsImage.png",
                  height: 150,
                )),
                Textwidget(
                  text: "Congrats!",
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: AppStyles.appThemeColor,
                ),
                Textwidget(
                  textAlign: TextAlign.center,
                  color: AppStyles.BlacklightTextcolor,
                  fontSize: 12,
                  maxLines: 15,
                  text:
                      "Your request has been sent to potential cleaners and you should start receiving bid soon.",
                ),
                Card(
                  elevation: 0.3,
                  margin: const EdgeInsets.only(top: 20),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Textwidget(
                          maxLines: 5,
                          text: "Here’s what happens next",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.circle,
                                size: 10,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                  child: Textwidget(
                                maxLines: 50,
                                fontSize: 12,
                                text:
                                    "Chat with prospective cleaners using the chat feature.",
                                color: AppStyles.BlacklightTextcolor,
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.circle,
                                size: 10,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                  child: Textwidget(
                                maxLines: 50,
                                fontSize: 12,
                                text:
                                    "Once you agree on a cleaning price. accept the cleaner’s bid to start working with them.",
                                color: AppStyles.BlacklightTextcolor,
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.circle,
                                size: 10,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                  child: Textwidget(
                                maxLines: 50,
                                fontSize: 12,
                                text:
                                    "After you accept their bid, your new cleaner will receive notifications about your projects on the Airnests app.",
                                color: AppStyles.BlacklightTextcolor,
                              ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
        child: MyButton(
          text: 'Got it',
          onPressed: () {
            Get.offAllNamed(Routes.DESHBOARD);
          },
          color: AppStyles.appThemeColor,
          TextColor: AppStyles.backgroundColor,
        ),
      ),
    );
  }
}
