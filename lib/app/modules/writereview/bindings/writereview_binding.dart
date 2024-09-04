import 'package:get/get.dart';

import '../controllers/writereview_controller.dart';

class WritereviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WritereviewController>(
      () => WritereviewController(),
    );
  }
}
