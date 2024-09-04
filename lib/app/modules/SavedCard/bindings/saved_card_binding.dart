import 'package:get/get.dart';

import '../controllers/saved_card_controller.dart';

class SavedCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SavedCardController>(
      () => SavedCardController(),
    );
  }
}
