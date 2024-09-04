

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoCallService{

  final String appId = "a53dc234d515494eb7be54bd45448a9c";
  final String token = "007eJxTYJB+c+nXT7M55wrOnDx4Kz/+33cm/0vvbRZ4B7BXnV5XfPCnAkOiqXFKspGxSYqpoamJpUlqknlSqqlJUoqJqYmJRaJlsnlkSFpDICPDD91trIwMEAjiszCUpBaXMDAAAIztIxk=";


  // Future<void> initializeAgora(engine,isJoined,remoteUid,userid) async {
  //   engine = createAgoraRtcEngine();
  //   await engine.initialize(RtcEngineContext(appId: appId));
  //
  //   engine.registerEventHandler(
  //     RtcEngineEventHandler(
  //       onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
  //         isJoined.value = true;
  //       },
  //       onUserJoined: (RtcConnection connection, int userid, int elapsed) {
  //         isJoined.value = userid;
  //       },
  //       // onUserOffline: (RtcConnection connection, int uid) {
  //       //   remoteUid.value = 0;
  //       // },
  //     ),
  //   );
  //
  //   await engine.enableVideo();
  // }
   initializeAgora(engine,isJoined,remoteUid,userid) async {
    await [Permission.camera, Permission.microphone].request();

    engine = createAgoraRtcEngine();
    await engine?.initialize(
      RtcEngineContext(appId: appId),
    );

    engine?.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          isJoined.value = true;
        },
        onUserJoined: (RtcConnection connection, int uid, int elapsed) {
          remoteUid.value = uid;
        },
        onUserOffline: (RtcConnection connection, int uid, reason) {
          remoteUid.value = 0;
        },
      ),
    );

    await engine?.enableVideo();
  }

  joinChannel(engine) async {
    await engine.startPreview();
    await engine.joinChannel(
      token: token,
      channelId: 'test',
      uid: 0,
      options: ChannelMediaOptions(),
    );
  }

   leaveChannel(engine,isJoined) async {
    await engine.leaveChannel();
    isJoined.value = false;
  }


}