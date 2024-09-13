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
      'Have multiple properties?',
    ],
    'desc': [
      'Looking for a cleaner or a co-host at an affordable price? Use our app to create a bid for several cleaners near you.  Accept the one that makes sense to you.',
      'After you book one of the cleaner or co-host, easily track progress of the work live on the day of service.',
      'Easily manage multiple properties and favorite cleaners in just a few clicks using our app.'
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
