import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/modules/WellcomeScreen/controllers/wellcome_screen_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';

class WellcomeScreenView extends GetView<WellcomeScreenController> {
  const WellcomeScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // Set a base font size
    double titleFontSize = 20.0;
    double descFontSize = 14.0;
    // Calculate the adjusted font size based on screen width
    double adjustedFontSize = screenWidth / 350.0 * titleFontSize;
    double adjusteddescFontSize = screenWidth / 370.0 * descFontSize;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(alignment: Alignment.bottomCenter, children: [
        PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          onPageChanged: (value) {
            controller.currentIndex.value = double.parse(value.toString());
          },
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Image.asset(
                      'assets/images/WelcomeImageone.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.5,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/images/welcomebackImage.png",
                          ),
                          fit: BoxFit.fill)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          Center(
                            child: Textwidget(
                              textscalefector: 1,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              color: AppStyles.backgroundColor,
                              fontSize: adjustedFontSize,
                              fontWeight: FontWeight.w700,
                              text: controller.onboardingItems['title']![0],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          Center(
                            child: Textwidget(
                              textscalefector: 1,
                              maxLines: 6,
                              textAlign: TextAlign.center,
                              color: AppStyles.backgroundColor,
                              text: controller.onboardingItems['desc']![0],
                              fontSize: adjusteddescFontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 10,
                          ),

                          MyButton(
                            text: "Next",
                            onPressed: () {
                              if (controller.currentIndex.value == 0) {
                                controller.pageController.animateToPage(1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              }
                              if (controller.currentIndex.value == 1) {
                                controller.pageController.animateToPage(2,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              }
                              if (controller.currentIndex.value == 2) {
                                controller.pageController.animateToPage(3,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              }
                              if (controller.currentIndex.value == 2) {
                                Get.offAllNamed(Routes.SIGN_IN);
                              }
                            },
                            color: Colors.white,
                            TextColor: AppStyles.appThemeColor,
                          ),

                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Image.asset(
                      'assets/images/WelcomeImagetwo.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.5,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/images/welcomebackImage.png",
                          ),
                          fit: BoxFit.fill)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          Center(
                            child: Textwidget(
                              textscalefector: 1,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              color: AppStyles.backgroundColor,
                              fontSize: adjustedFontSize,
                              fontWeight: FontWeight.w700,
                              text: controller.onboardingItems['title']![1],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          Center(
                            child: Textwidget(
                              textscalefector: 1,
                              maxLines: 6,
                              textAlign: TextAlign.center,
                              color: AppStyles.backgroundColor,
                              text: controller.onboardingItems['desc']![1],
                              fontSize: adjusteddescFontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 8,
                          ),

                          MyButton(
                            text: "Next",
                            onPressed: () {
                              if (controller.currentIndex.value == 0) {
                                controller.pageController.animateToPage(1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              }
                              if (controller.currentIndex.value == 1) {
                                controller.pageController.animateToPage(2,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              }
                              if (controller.currentIndex.value == 2) {
                                controller.pageController.animateToPage(3,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              }
                              if (controller.currentIndex.value == 2) {
                                Get.offAllNamed(Routes.SIGN_IN);
                              }
                            },
                            color: Colors.white,
                            TextColor: AppStyles.appThemeColor,
                          ),

                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Image.asset(
                      'assets/images/welcomeImagethree.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.5,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/images/welcomebackImage.png",
                          ),
                          fit: BoxFit.fill)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          Center(
                            child: Textwidget(
                              textscalefector: 1,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              color: AppStyles.backgroundColor,
                              fontSize: adjustedFontSize,
                              fontWeight: FontWeight.w700,
                              text: controller.onboardingItems['title']![2],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          Center(
                            child: Textwidget(
                              textscalefector: 1,
                              maxLines: 6,
                              textAlign: TextAlign.center,
                              color: AppStyles.backgroundColor,
                              text: controller.onboardingItems['desc']![2],
                              fontSize: adjusteddescFontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 8,
                          ),

                          MyButton(
                            text: "Get Started",
                            onPressed: () {
                              if (controller.currentIndex.value == 0) {
                                controller.pageController.animateToPage(1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              }
                              if (controller.currentIndex.value == 1) {
                                controller.pageController.animateToPage(2,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              }
                              if (controller.currentIndex.value == 2) {
                                controller.pageController.animateToPage(3,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              }
                              if (controller.currentIndex.value == 2) {
                                Get.offAllNamed(Routes.SIGN_IN);
                              }
                            },
                            color: Colors.white,
                            TextColor: AppStyles.appThemeColor,
                          ),

                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => DotsIndicator(
                        dotsCount: 3,
                        position: controller.currentIndex.value.toInt(),
                        decorator: DotsDecorator(
                          color: Colors.transparent,
                          activeColor: Colors.white,
                          size: const Size.square(10.0),
                          activeSize: const Size(10.0, 10.0),
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(50)),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      )),
                  IconButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.SIGN_IN);
                    },
                    icon: Textwidget(
                      textscalefector: 1,
                      text: "SKIP",
                      color: AppStyles.backgroundColor,
                      fontWeight: FontWeight.w700,
                    ),
                   )
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }
}
