import 'package:get/get.dart';

class MakeAccountWithScreenController extends GetxController {
  //TODO: Implement MakeAccountWithScreenController



  final makeAccountwith = {

    "id" :[
      "0", "1", "2"
    ],

    "IconImage" :[
      "assets/icons/search.png",
      "assets/icons/Group.png",
      "assets/icons/addIcon.png"],

    "title":[
      "Search a new cleaners",
      "Search Co-host",
      "Create a bid & Find the best\ncleaner and co-host"
    ],

    "discription":[
      "Join Airnests and connect with new cleaners.",
      "Join Airnests and connect with co-host cleaners",
      "Create a project and find best cleaners"
    ],

    "nextScreendis":[
      "How would you like a continue?",
      "What do you want your co-host to manage?",
      "What type of cleaning do you need?"
    ]

  };

  final userType = "".obs;
  final dashBtn = false.obs;


  final count = 0.obs;
  @override
  void onInit() {
    dashBtn.value = Get.arguments;
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
