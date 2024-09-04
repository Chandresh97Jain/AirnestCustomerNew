import 'package:get/get.dart';

import '../controllers/verify_change_password_controller.dart';

class VerifyChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyChangePasswordController>(
      () => VerifyChangePasswordController(),
    );
  }
}
