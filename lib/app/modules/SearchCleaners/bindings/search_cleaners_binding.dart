import 'package:get/get.dart';

import '../controllers/search_cleaners_controller.dart';

class SearchCleanersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchCleanersController>(
      () => SearchCleanersController(),
    );
  }
}
