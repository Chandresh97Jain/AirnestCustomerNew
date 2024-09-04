import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WellcomeScreenController extends GetxController {
  //TODO: Implement WellcomeScreenController

  PageController pageController = PageController();
  RxDouble currentIndex = 0.0.obs;

  final onboardingItems = {
    'title': [
      'Welcome to Airnests',
      'Easy Track Order',
      'Door to Door Support',
    ],
    'desc': [
      'Reference site about Lorem Ipsum, giving information on its origins, as well as a random Lipsum generator.',
      'Reference site about Lorem Ipsum, giving information on its origins, as well as a random Lipsum generator.',
      'Reference site about Lorem Ipsum, giving information on its origins, as well as a random Lipsum generator.'
    ],
  };




  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
