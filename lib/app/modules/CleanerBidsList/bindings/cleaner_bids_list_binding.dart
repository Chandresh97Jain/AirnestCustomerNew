import 'package:get/get.dart';

import '../controllers/cleaner_bids_list_controller.dart';

class CleanerBidsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CleanerBidsListController>(
      () => CleanerBidsListController(),
    );
  }
}
