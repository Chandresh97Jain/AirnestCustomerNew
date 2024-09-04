import 'package:get/get.dart';

import '../controllers/my_favourite_controller.dart';

class MyFavouriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyFavouriteController>(
      () => MyFavouriteController(),
    );
  }
}
