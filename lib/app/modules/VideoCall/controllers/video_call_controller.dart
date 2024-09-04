import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:power_maids/AgoraVideoCall/video_call.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class VideoCallController extends GetxController {
  //TODO: Implement AddAccountController


  VideoCallService videoCallService = VideoCallService();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final count = 0.obs;
  RtcEngine? engine;
  var isJoined = false.obs;
  var remoteUid = 0.obs;
  var remoteUserName = ''.obs;
  // var remoteFirebaseId = ''.obs;
  final userID = ''.obs;
  final channelId = ''.obs;
  final agoraToken = ''.obs;
  final isLoading = false.obs;
  final remoteUserId = ''.obs;

  final AudioPlayer justAudioPlayer = AudioPlayer();
  final muted = false.obs;
  final offVideo = false.obs;
  final cameraTurn = false.obs;
  final userVideoOff = false.obs;
  final HowOffVideo = false.obs;

  @override
  void onInit() {
    getPref();
    super.onInit();
    remoteUserId.value = Get.parameters['remote_user_id']??"";
    remoteUserName.value = Get.parameters['remote_user_name']??"";
    channelId.value = Get.parameters['channelId']??"";
    agoraToken.value = Get.parameters['agora_token']??"";
    initAgora();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    engine = createAgoraRtcEngine();
    await engine!.initialize(const RtcEngineContext(
      appId: "a53dc234d515494eb7be54bd45448a9c",
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    engine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user -- ☎️ ${connection.localUid} joined");
          isJoined.value = true;
        },
        onUserJoined: (RtcConnection connection, int remoteUidd, int elapsed) {
          debugPrint("remote user -- ☎️ $remoteUidd joined");
          remoteUid.value = remoteUidd;
          justAudioPlayer.stop();
        },
        onUserOffline: (RtcConnection connection, int remoteUidd,
            UserOfflineReasonType reason) {
          debugPrint("remote user -- ☎️ $remoteUidd left channel");
          remoteUid.value = 0;
          leaveChannel();
        },
        onUserMuteVideo: (RtcConnection,int uid, check) {
          print("userMuteVideo user $uid joined");
          userVideoOff.value = check;
          HowOffVideo.value = check;
        },
        onLeaveChannel: (RtcConnection, RtcStats) {
          debugPrint('leaveChannel ${RtcStats.toJson()}');
          isJoined.value = false;
          remoteUid.value = 0;
          // Navigator.of(context).pop();
        },
        // onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
        //   debugPrint(
        //       '[onTokenPrivilegeWillExpire] connection: -- ☎️ ${connection.toJson()}, token: $token');
        // },
      ),
    );


    if(agoraToken.value.isEmpty && channelId.value.isEmpty){
      // Fetch the token from your server and join the channel
      await fetchAgoraToken();
      await joinChannel(agoraToken.value,channelId.value,0);
    }else{
      await joinChannel(agoraToken.value,channelId.value,0);
    }



    // await joinChannel(token,'test',0);
    // await engine?.joinChannel(token:'007eJxTYJB+c+nXT7M55wrOnDx4Kz/+33cm/0vvbRZ4B7BXnV5XfPCnAkOiqXFKspGxSYqpoamJpUlqknlSqqlJUoqJqYmJRaJlsnlkSFpDICPDD91trIwMEAjiszCUpBaXMDAAAIztIxk=',channelId: 'test',options:  ChannelMediaOptions(),uid:0);

  }

  Future<void> leaveChannel() async {
    justAudioPlayer.stop();
    await engine!.leaveChannel();
    isJoined.value = false;
    await FlutterCallkitIncoming.endAllCalls();
    Navigator.of(scaffoldKey.currentContext!).pop();

  }

  joinChannel(token,channelId,uid) async {
    await engine!.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine!.enableVideo();
    await engine!.startPreview();
    await engine!.joinChannel(
      token: token,
      channelId: channelId,
      uid: uid,
      options:  const ChannelMediaOptions(),
    );
  }

  Future fetchAgoraToken() async {
    try {
      isLoading(true);

      var response = await ApiService().startVideoCall(remoteUserId.value);

      if (response['status'] == true) {

        channelId.value = response['data']['channelId'];
        agoraToken.value = response['data']['token'];

        update();
        isLoading(false);
      } else if (response['status'] == false) {

        isLoading(false);
        update();
      }
    } finally {
      isLoading(false);
      update();

    }
  }

  onCallEnd() async {
    await leaveChannel();
  }

  void onToggleMute() {
    muted.value = !muted.value;
    engine!.muteLocalAudioStream(muted.value);
  }

  void onSwitchCamera() {
    cameraTurn.value = !cameraTurn.value;
    engine!.switchCamera();
  }


  videoOff() async {
    offVideo.value = !offVideo.value;
    // userVideoOff.value = !userVideoOff.value;
    // _engine.enableVideo();
    engine!.muteLocalVideoStream(offVideo.value);
  }

  // Display remote user's video
  Widget remoteVideo() {
    if (userVideoOff.value) {
      return const Center(
        child: Image(
          height: 100,
          width: 100,
          image: AssetImage('assets/icons/logo.png'),
        ),

        // Image.assets(widget.type == 1
        //     ? widget.callModel.receiverPic
        //     : widget.callModel.callerPic),
      );
    } else {
      if (remoteUid.value != 0) {
        return AgoraVideoView(
            controller: VideoViewController.remote(
              rtcEngine:engine!,
              canvas: VideoCanvas(uid: remoteUid.value),
              connection:  RtcConnection(channelId: channelId.value),
            )
        );
      } else {
        return const Center(
          child: Image(
            image: AssetImage(
              'assets/icons/logo.png',
            ),
            height: 100,
            width: 100,
          ),
        );
      }
    }
  }

  // Toolbar layout
  Widget toolbar() {
    // if (widget.callModel.role == ClientRole.Audience) return Container();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RawMaterialButton(
              onPressed: onToggleMute,
              shape: const CircleBorder(),
              elevation: 2.0,
              fillColor: muted.value ? AppStyles.appThemealtralightColor : AppStyles.backgroundColor,
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                muted.value ? Icons.mic_off : Icons.mic,
                color: muted.value ? Colors.white : Colors.black45,
                size: 20.0,
              ),
            ),
            RawMaterialButton(
              onPressed: onSwitchCamera,
              shape: const CircleBorder(),
              elevation: 2.0,
              fillColor:
              cameraTurn.value ? AppStyles.appThemealtralightColor : AppStyles.backgroundColor,
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "assets/icons/flip.png",
                color:cameraTurn.value ?  Colors.white : Colors.black45,
                height: 23,
                width: 23,
              )
            ),
            RawMaterialButton(
              onPressed: videoOff,
              shape: const CircleBorder(),
              elevation: 2.0,
              fillColor: offVideo.value ? AppStyles.appThemealtralightColor : AppStyles.backgroundColor,
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                offVideo.value ? Icons.videocam_off : Icons.videocam,
                color: offVideo.value ? Colors.white : Colors.black45,
                size: 20.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30,),
        Center(
          child: RawMaterialButton(
            onPressed: () => onCallEnd(),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(12.0),
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ),
      ],
    );
  }

  getPref() async {
    final prefs = await SharedPreferences.getInstance();
    // userID.value  = prefs.getString('user_id')!;
    print("userID -------  ${userID.value}");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    engine?.leaveChannel();
    // engine?.destroy();
    super.onClose();
  }

  void increment() => count.value++;
}

