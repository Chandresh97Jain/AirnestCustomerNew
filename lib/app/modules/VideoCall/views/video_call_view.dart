import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart' as RtcRemoteView;
import 'package:agora_rtc_engine/agora_rtc_engine.dart' as RtcLocalView;
import '../controllers/video_call_controller.dart';

class VideoCallView extends GetView<VideoCallController> {
  const VideoCallView({Key? key}) : super(key: key);
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
            Visibility(
              visible: true,
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 66.0, right: 15.0),
                  child: SizedBox(
                    width: 100,
                    height: 175,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.86),
                          child:  Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12.86),
                            ),
                            width: 100,
                            height: 150,
                            child: Center(
                              child: controller.isJoined.value
                                  ? AgoraVideoView(controller: VideoViewController(rtcEngine: controller.engine!, canvas: const VideoCanvas(uid: 0),),)
                                  : const CircularProgressIndicator(),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Visibility(
            //   visible: controller.HowOffVideo.value,
            //   child: Align(
            //     alignment: Alignment.topCenter,
            //     child: Container(
            //       width: MediaQuery.of(context).size.width,
            //       color: Colors.red,
            //       padding: const EdgeInsets.all(10.0),
            //       child: const Text(
            //         // '${widget.type == 1 ? widget.callModel.receiverName : widget.callModel.callerName} is off video ',
            //         ' is off video ',
            //         textAlign: TextAlign.center,
            //         style: TextStyle(color: Colors.white, fontSize: 14.0),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      )),
      onWillPop: () => controller.onCallEnd(),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     titleSpacing: 15,
    //     toolbarHeight: 70,
    //     automaticallyImplyLeading: false,
    //     elevation: 1,
    //     backgroundColor: Colors.transparent,
    //     title: AppbarWithBackButton(
    //       text: 'Video Chat',
    //       onPressed: () {
    //         Get.back();
    //       },
    //     ),
    //     centerTitle: false,
    //   ),
    //   body:  Obx(() {
    //     return
    //     //   Stack(
    //     //   children: [
    //     //     Center(
    //     //       child: controller.remoteVideo(),
    //     //     ),
    //     //     Align(
    //     //       alignment: Alignment.topLeft,
    //     //       child: Center(
    //     //         child: controller.isJoined.value
    //     //             ? AgoraVideoView(
    //     //           controller: VideoViewController(
    //     //             rtcEngine: controller.engine!,
    //     //             canvas: const VideoCanvas(uid: 0),
    //     //           ),
    //     //         )
    //     //             : const CircularProgressIndicator(),
    //     //       ),
    //     //     ),
    //     //   ],
    //     // );
    //
    //       Stack(
    //       children: [
    //         Center(
    //           child: controller.isJoined.value
    //               ? AgoraVideoView(
    //             controller: VideoViewController(
    //               rtcEngine: controller.engine!,
    //               canvas: const VideoCanvas(uid: 0),
    //             ),
    //           )
    //               : Text('Join a channel'),
    //         ),
    //         Positioned(
    //           right: 16,
    //           top: 16,
    //           width: 100,
    //           height: 150,
    //           child: controller.remoteUid.value != 0
    //               ? AgoraVideoView(
    //             controller: VideoViewController.remote(
    //               rtcEngine: controller.engine!,
    //               canvas: VideoCanvas(uid: controller.remoteUid.value),
    //               connection:  RtcConnection(channelId: controller.channelId.value),
    //             ),
    //           )
    //               : Container(
    //             color: Colors.black,
    //             child: Center(child: Textwidget(
    //               text: 'Waiting for user',
    //               fontSize: 14,
    //               color: Colors.white,
    //               maxLines: 2,
    //               textAlign: TextAlign.center,
    //               fontWeight: FontWeight.w500,
    //             )
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           bottom: 16,
    //           left: 16,
    //           right: 16,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               // ElevatedButton(
    //               //   onPressed: (){
    //               //     controller.isJoined.value == true
    //               //         ? controller.leaveChannel()
    //               //         : controller.joinChannel();
    //               //     },
    //               //   child: Text(controller.isJoined.value ? 'Leave' : 'Join'),
    //               // ),
    //               ElevatedButton(
    //                 onPressed: (){
    //                controller.leaveChannel();
    //                 },
    //                 child: const Text('Leave'),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     );
    //   }),
    // );
  }

}
