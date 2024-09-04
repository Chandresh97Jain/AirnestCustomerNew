import 'package:get/get.dart';

class FilterScreenController extends GetxController {
  //TODO: Implement FilterScreenController

  final count = 0.obs;
  final isSwitched = false.obs;
  final sortoptionselected = "".obs;
  final genderselected = "".obs;
  final starRatingselected = "".obs;
  final workExperienceselected = "".obs;
   void toggleSwitch() {
    isSwitched.toggle();
  }

  final lowerValue = 50.obs;
  final upperValue = 180.obs;

  final sortOPtion = [
    "Popularity",
    "Star Rating ( highest first )",
    "Star Rating ( lowest first )",
    "Best Reviewed First",
    "Most Reviewed First",
    "Price ( lowest first )",
    "Price ( highest first )"
  ];


  final genderList = [
    "Male",
    "Female",
  ];

  final workExperience = [
    "Any Experience",
    "< 1",
    "1 - 5",
    "5 - 10",
    "10 - 15",
    "15 - 20",
  ];

  final starRating = [
    "1",
    "2",
    "3",
    "4",
    "5",
  ];


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
