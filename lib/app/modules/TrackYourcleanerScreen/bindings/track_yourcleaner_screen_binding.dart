import 'package:get/get.dart';

import '../controllers/track_yourcleaner_screen_controller.dart';

class TrackYourcleanerScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackYourcleanerScreenController>(
      () => TrackYourcleanerScreenController(),
    );
  }
}
