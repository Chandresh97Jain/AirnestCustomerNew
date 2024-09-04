import 'package:get/get.dart';

import '../controllers/reset_change_password_controller.dart';

class ResetChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetChangePasswordController>(
      () => ResetChangePasswordController(),
    );
  }
}
