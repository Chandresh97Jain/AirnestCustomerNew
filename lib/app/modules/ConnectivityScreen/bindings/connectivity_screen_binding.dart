import 'package:get/get.dart';

import '../controllers/connectivity_screen_controller.dart';

class ConnectivityScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectivityScreenController>(
      () => ConnectivityScreenController(),
    );
  }
}
