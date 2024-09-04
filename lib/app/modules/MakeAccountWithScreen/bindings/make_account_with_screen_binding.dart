import 'package:get/get.dart';

import '../controllers/make_account_with_screen_controller.dart';

class MakeAccountWithScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MakeAccountWithScreenController>(
      () => MakeAccountWithScreenController(),
    );
  }
}
