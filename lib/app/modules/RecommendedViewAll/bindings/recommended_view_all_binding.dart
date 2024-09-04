import 'package:get/get.dart';

import '../controllers/recommended_view_all_controller.dart';

class RecommendedViewAllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecommendedViewAllController>(
      () => RecommendedViewAllController(),
    );
  }
}
