import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart' as RtcRemoteView;
import 'package:agora_rtc_engine/agora_rtc_engine.dart' as RtcLocalView;
import 'package:power_maids/Utils/cached_netword_image.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/modules/AudioCall/controllers/audio_call_controller.dart';


class AudioCallView extends GetView<AudioCallController> {
  const AudioCallView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Obx(() => Scaffold(
        key: controller.scaffoldKey,
        extendBody: true,
        bottomNavigationBar: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            controller.toolbar(),
            const SizedBox(
              height: 8,
            ),
            // const CustomBottomNavigationBar(),
          ],
        ),
        body: Stack(
          children: [
            Center(
              child: controller.remoteVideo(),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height/8,
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 120,
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: ProfileImage(image: controller.remoteUserProfile.value, fit: BoxFit.fill,),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Textwidget(
                        text: controller.remoteUserName.value,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    controller.remoteUid.value != 0
                        ?Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Textwidget(
                        text: controller.formatDuration(controller.callDuration.value),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                    : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Textwidget(
                        text: "Calling...",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
            )
          ],
        ),
      )),
      onWillPop: () => controller.onCallEnd(),
    );
  }
}
