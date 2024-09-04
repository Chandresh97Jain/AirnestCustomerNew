import 'package:get/get.dart';

class PhotoViewMaidDetailsController extends GetxController {
  //TODO: Implement PhotoViewMaidDetailsController

  final count = 0.obs;
  final photo = ''.obs;
  final index = ''.obs;
  final photol = [].obs;
  @override
  void onInit() {
    photo.value=Get.parameters['photo'].toString();
    index.value=Get.parameters['index'].toString();
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
