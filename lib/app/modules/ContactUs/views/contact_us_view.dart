import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';

import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: AppStyles.appThemeColor,
        title: Textwidget(
          text: "Contact Us",
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Center(
              child: Image.asset(
                "assets/icons/logo.png",
                height: MediaQuery.of(context).size.height / 10,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Textwidget(
              text:
                  "You can get in touch with us through below platforms, Our team will reach "
                  "out to you as soon as it would be possible",
              fontSize: 16,
              maxLines: 4,
              textAlign: TextAlign.center,
              color: Colors.black38,
              fontWeight: FontWeight.w300,
            ),
            SizedBox(
              height: 20,
            ),
            // Customer Support Card
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Textwidget(
                      text: "Customer Support",
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(50), // Circular border
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                "assets/icons/Icon-Set.png",
                                color: AppStyles.appThemeColor,
                                height: 24,
                                width: 24,
                              ),
                            )),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () =>
                              controller.launchEmail('info@airnests.com'),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Textwidget(
                                text: "Email Address",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                              Textwidget(
                                text: "info@airnests.com",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(50), // Circular border
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                "assets/icons/CallIvons1.png",
                                color: AppStyles.appThemeColor,
                                height: 24,
                                width: 24,
                              ),
                            )),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => controller.launchPhone('(708)668-7607'),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Textwidget(
                                text: "Contact Number",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                              Textwidget(
                                text: "(708)668-7607",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Social Media Card
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Textwidget(
                      text: "Social Media",
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 15),
                    // Instagram
                    GestureDetector(
                      onTap: () => controller.launchSocialMedia(
                          'https://www.instagram.com/official_airnests/'),
                      child: Row(
                        children: [
                          Image.asset('assets/icons/instagram.png', width: 30),
                          const SizedBox(width: 10),
                          Textwidget(
                            text: "Instagram",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Twitter
                    GestureDetector(
                      onTap: () => controller
                          .launchSocialMedia('https://x.com/Airnests'),
                      child: Row(
                        children: [
                          Image.asset('assets/icons/twitter.png', width: 30),
                          const SizedBox(width: 10),
                          Textwidget(
                            text: "Twitter",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Facebook
                    GestureDetector(
                      onTap: () => controller.launchSocialMedia(
                          'https://www.facebook.com/profile.php?id=100084743673728  '),
                      child: Row(
                        children: [
                          Image.asset('assets/icons/facebook.png', width: 30),
                          const SizedBox(width: 10),
                          Textwidget(
                            text: "Facebook",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
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
    );
  }
}
