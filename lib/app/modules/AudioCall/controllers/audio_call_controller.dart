import 'dart:async';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:just_audio/just_audio.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:power_maids/AgoraVideoCall/video_call.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class AudioCallController extends GetxController {
  //TODO: Implement AddAccountController

  VideoCallService videoCallService = VideoCallService();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final count = 0.obs;
   RtcEngine? engine;
  var isJoined = false.obs;
  var remoteUid = 0.obs;
  var remoteUserName = ''.obs;
  var remoteUserProfile = ''.obs;
  // var remoteFirebaseId = ''.obs;
  final userID = ''.obs;
  final channelId = ''.obs;
  final agoraToken = ''.obs;
  final isLoading = false.obs;
  final remoteUserId = ''.obs;

  final AudioPlayer justAudioPlayer = AudioPlayer();
  final muted = false.obs;
  final isSpeakerOn = false.obs;
  final cameraTurn = false.obs;
  final userVideoOff = false.obs;
  final howOffVideo = false.obs;

  @override
  void onInit() {
    getPref();
    super.onInit();
    remoteUserId.value = Get.parameters['remote_user_id']??"";
    remoteUserName.value = Get.parameters['remote_user_name']??"";
    remoteUserProfile.value = Get.parameters['remoteUserProfile']??"";
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
          startTimer();
          justAudioPlayer.stop();
        },
        onUserOffline: (RtcConnection connection, int remoteUidd,
            UserOfflineReasonType reason) {
          debugPrint("remote user -- ☎️ $remoteUidd left channel");
            remoteUid.value = 0;
            leaveChannel();
        },
        onUserMuteVideo: (rtcConnection,int uid, check) {
          print("userMuteVideo user $uid joined");
            userVideoOff.value = check;
            howOffVideo.value = check;
        },
        onLeaveChannel: (rtcConnection, rtcStats) {
          debugPrint('leaveChannel ${rtcStats.toJson()}');
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
    await engine!.disableVideo();
    await engine!.startPreview();
    await engine!.joinChannel(
      token: token,
      channelId: channelId,
      uid: uid,
      options: const ChannelMediaOptions(),
    );
  }

  Future fetchAgoraToken() async {

    print("remote_user_id.value   ----- ${remoteUserId.value}");
    try {
      isLoading(true);

      var response = await ApiService().startAudioCall(remoteUserId.value);

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

  // Display remote user's video
  Widget remoteVideo() {
    if (remoteUid.value != 0) {
      return AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine:engine!,
            canvas: VideoCanvas(uid: remoteUid.value),
            connection:  RtcConnection(channelId: channelId.value),
          )
      );
    } else {
      return  const SizedBox();
    }
  }

  Timer? timer;
  final callDuration = 0.obs; // Observable to track call duration
  String formatDuration(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void startTimer() {
    timer?.cancel(); // Cancel any existing timer
    callDuration.value = 0; // Reset the duration
    timer = Timer.periodic( const Duration(seconds: 1), (Timer timer) {
      callDuration.value++;
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  // Method to toggle speaker mode
  Future<void> toggleSpeaker(bool enabled) async {
    try {
      await engine!.setEnableSpeakerphone(enabled);
      print(enabled ? 'Speaker enabled' : 'Speaker disabled');
    } on AgoraRtcException catch (e) {
      print('AgoraRtcException ${e.code}, ${e.message}');
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
            RawMaterialButton(
              onPressed: (){
                isSpeakerOn.value = !isSpeakerOn.value;
                toggleSpeaker(isSpeakerOn.value);
              },
              shape: const CircleBorder(),
              elevation: 2.0,
              fillColor: isSpeakerOn.value ? AppStyles.backgroundColor:AppStyles.appThemealtralightColor,
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                isSpeakerOn.value ? CupertinoIcons.volume_off : Icons.volume_up_outlined,
                color: isSpeakerOn.value ? Colors.black45 : Colors.white,
                size: 20.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30,),

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

