import 'package:get/get.dart';

import '../controllers/cleaner_co_hostlist_controller.dart';

class CleanerAndCoHostListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CleanerAndCoHostListController>(
      () => CleanerAndCoHostListController(),
    );
  }
}
