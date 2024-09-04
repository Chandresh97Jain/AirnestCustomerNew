import 'package:get/get.dart';

import '../controllers/sign_up_basic_details_screen_controller.dart';

class SignUpBasicDetailsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpBasicDetailsScreenController>(
      () => SignUpBasicDetailsScreenController(),
    );
  }
}
