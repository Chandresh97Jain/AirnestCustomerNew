import 'package:get/get.dart';
import 'package:power_maids/app/modules/VideoCall/controllers/video_call_controller.dart';


class VideoCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoCallController>(
      () => VideoCallController(),
    );
  }
}
