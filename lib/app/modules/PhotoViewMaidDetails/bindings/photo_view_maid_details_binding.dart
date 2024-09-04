import 'package:get/get.dart';

import '../controllers/photo_view_maid_details_controller.dart';

class PhotoViewMaidDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhotoViewMaidDetailsController>(
      () => PhotoViewMaidDetailsController(),
    );
  }
}
