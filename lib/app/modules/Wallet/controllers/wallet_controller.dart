import 'package:get/get.dart';

class WalletController extends GetxController {
  //TODO: Implement WalletController

  final count = 0.obs;

  final ammountSilect ="".obs;

  final amontList = [

    "100",
    "200",
    "500",
    "1000"


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
