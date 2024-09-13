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
      "Search a new cleaner",
      "Search a new Co-host",
      "Create a bid & Find the best\ncleaner and co-host"
    ],

    "discription":[
      "Find cleaners near your service location.",
      "Find co-host near your service location.",
      "Create a project and find best cleaners or co-hosts."
    ],

    "nextScreendis":[
      "What best describes your cleaning needs?",
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
