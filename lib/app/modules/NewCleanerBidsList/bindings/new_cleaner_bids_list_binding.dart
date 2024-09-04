import 'package:get/get.dart';

import '../controllers/new_cleaner_bids_list_controller.dart';

class NewCleanerBidsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewCleanerBidsListController>(
      () => NewCleanerBidsListController(),
    );
  }
}
