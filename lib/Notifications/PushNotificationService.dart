import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:callkeep/callkeep.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/entities/notification_params.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../app/routes/app_pages.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';



class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  RtcEngine? _agoraRtcEngine;

  Future<void> init() async {
    await Firebase.initializeApp();

    await _firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
    );

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('logo');
    const DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null) {
          handleNotificationPayload(response.payload!);
        }
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleNotificationPayload(message.data['payload']);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  }

  void initializeCallKit(data) {
    FlutterCallkitIncoming.onEvent.listen((CallEvent? event) {

      switch (event!.event) {
        case Event.actionCallIncoming:
        // Handle an incoming call
        // For example:
        // showIncomingCallScreen(event.callUUID, event.handle, event.hasVideo);
          break;
        case Event.actionCallStart:
        // Handle when an outgoing call starts
        // For example:
        // showOutgoingCallScreen(event.callUUID, event.handle, event.hasVideo);
          break;
        case Event.actionCallAccept:
        // Handle when an incoming call is accepted
        // For example:
        // acceptIncomingCall(event.callUUID);
          if (kDebugMode) {
            print("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 👉🏻jaydeepep =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-");
          }
          notificationVideoClick(data);
          // joinCall(event.callUUID, callData['agora_token']);
          break;
        case Event.actionCallDecline:

          break;
        case Event.actionCallEnded:
        // Handle when a call ends
        // For example:
          PushNotificationService().endCall();
          break;
        case Event.actionCallTimeout:
        // Handle when a call times out (missed call)
        // For example:
        // handleMissedCall(event.callUUID);
          break;
        case Event.actionCallCallback:
        // Handle when the user clicks "Call back" from a missed call notification (Android only)
        // For example:
        // callBackMissedCall(event.callUUID);
          break;
      // Add cases for other events as needed
        default:
          break;
      }
    });
  }


  Future<void> _showNotification(RemoteMessage message) async {
    if (kDebugMode) {
      print("☎️ - ---------call not coming-------------- jaydeep ${message.data}");
    }
    if (message.data['type'] == 'video') {
      showIncomingCallNotification(message.data['channelId'], message.data['token'],message.senderId.toString());
    } else {
      const androidNotificationDetails = AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        channelDescription: 'your_channel_description',
        importance: Importance.max,
        priority: Priority.high,
      );

      const notificationDetails = NotificationDetails(android: androidNotificationDetails);
      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title ?? '',
        message.notification?.body ?? '',
        notificationDetails,
        payload: message.data['notify_type'].toString(),
      );
    }
  }

  void showIncomingCallNotification(String channelId, String token,String name ) {
    final params = CallKitParams(
      id: channelId,
      nameCaller: name,
      appName: 'Airnest',
      avatar: '',
      handle: 'Caller ID',
      type: 0,
      duration: 30000,
      textAccept: 'Accept',
      textDecline: 'Decline',
      extra: <String, dynamic>{
        'channelId': channelId,
        'agora_token': token,
      },
    );
    FlutterCallkitIncoming.showCallkitIncoming(params);
  }

  void handleNotificationPayload(String payload) {
    if (kDebugMode) {
      print("☎️ handleNotificationPayload- -payload $payload");
    }
    final data = payload.split(',');
    final channelId = data[0];
    final token = data[1];
    joinCall(channelId, token);

  }

  void joinCall(String channelId, String token) async {
    await _agoraRtcEngine!.initialize(const RtcEngineContext(appId: 'a53dc234d515494eb7be54bd45448a9c'));
    _agoraRtcEngine?.joinChannel(token:token,channelId:channelId, uid: 0, options: const ChannelMediaOptions(),);
  }

  void endCall() {
    _agoraRtcEngine?.leaveChannel();
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("☎️ _firebaseMessagingBackgroundHandler- -message $message");
  }
  await Firebase.initializeApp();
  if (message.data['type'] == 'video') {
    showCallkitIncoming(message.data['channelId'],message.data,message.data['user_name'],message.data['user_image']);
  }else{
    showCallkitIncoming(message.data['channelId'],message.data,message.data['user_name'],message.data['user_image']);
  }
}

Future<void> showCallkitIncoming(String uuid, data,String name,String image) async {
  if (kDebugMode) {
    print("☎️ showCallkitIncoming- -uuid $uuid");
    print("☎️ IMAGE_URL- -IMAGE_URL ${ApiService.imageURL+image}");
  }
  final params = CallKitParams(
    id: uuid,
    nameCaller: name,
    appName: 'Airnest',
    avatar: ApiService.imageURL+image ??"assets/icons/ProfileIcon.png",
    handle: '',
    type: 0,
    duration: 30000,
    textAccept: 'Accept',
    textDecline: 'Decline',
    missedCallNotification: const NotificationParams(
      showNotification: true,
      isShowCallback: false,
      subtitle: 'Missed call',
      callbackText: '',
    ),
    extra: <String, dynamic>{'userId': '1a2b3c4d'},
    headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'android'},
    android: const AndroidParams(
      isCustomNotification: true,
      isShowLogo: false,
      ringtonePath: 'system_ringtone_default',
      backgroundColor: "#ff5858",
      backgroundUrl: 'assets/test.png',
      actionColor: '#4CAF50',
      textColor: '#ffffff',
    ),
    ios: const IOSParams(
      iconName: 'logo',
      handleType: '',
      supportsVideo: true,
      maximumCallGroups: 2,
      maximumCallsPerCallGroup: 1,
      audioSessionMode: 'default',
      audioSessionActive: true,
      audioSessionPreferredSampleRate: 44100.0,
      audioSessionPreferredIOBufferDuration: 0.005,
      supportsDTMF: true,
      supportsHolding: true,
      supportsGrouping: false,
      supportsUngrouping: false,
      ringtonePath: 'system_ringtone_default',
    ),
  );
  await FlutterCallkitIncoming.showCallkitIncoming(params);

  PushNotificationService().initializeCallKit(data);
}

///----------------------------------------- ADOT CODE --------------------------------------///

Future<void> notificationClickIos(var payload) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  if(payload!.data['type'] == 'call'){

  }
}

Future<void> notificationClick(var payload) async {
  if (kDebugMode) {
    print('---------------------------------on click');
  }
  if (kDebugMode) {
    print(    payload);
  }
  SharedPreferences pref = await SharedPreferences.getInstance();
  // if (payload != null) {
  //   print(pref.getString('screen'));
  //   switch (payload!.data['type']) {
  //     case "1":
  //       Navigator.pushReplacement(
  //         navigatorKey.currentState!.context,
  //         PageRouteBuilder(
  //           opaque: false,
  //           pageBuilder: (context, animation, secondaryAnimation) =>
  //               OrderDetails(
  //                 item_id: payload!.data['id'].toString(), onBack: (){
  //
  //               },
  //               ),
  //           transitionsBuilder:
  //               (context, animation, secondaryAnimation, child) {
  //             const begin = Offset(0.0, 1.0);
  //             const end = Offset.zero;
  //             final tween = Tween(begin: begin, end: end);
  //             final offsetAnimation = animation.drive(tween);
  //             return FadeTransition(
  //               opacity: animation,
  //               child: child,
  //             );
  //           },
  //         ),
  //       );
  //       break;
  //     case "2":
  //       Navigator.pushReplacement(
  //         Globle_key.currentState!.context,
  //         PageRouteBuilder(
  //           opaque: false,
  //           pageBuilder: (context, animation, secondaryAnimation) =>
  //               ProductDetails(
  //                 product_id: payload!.data['id'].toString(), onBack: (){
  //
  //               },
  //               ),
  //           transitionsBuilder:
  //               (context, animation, secondaryAnimation, child) {
  //             const begin = Offset(0.0, 1.0);
  //             const end = Offset.zero;
  //             final tween = Tween(begin: begin, end: end);
  //             final offsetAnimation = animation.drive(tween);
  //             return FadeTransition(
  //               opacity: animation,
  //               child: child,
  //             );
  //           },
  //         ),
  //       );
  //       break;
  //     case "comment":
  //       break;
  //     case "Reveal":
  //       break;
  //     case "normal":
  //       break;
  //     default:
  //       break;
  //   }
  // }
}

Future<void> notificationVideoClick(payload) async {
  log("jaydeep ------ joided call---------------------- $payload");

  if(payload['type'] == "video"){
    var data = {
      'channelId' : payload['channelId'].toString(),
      'agora_token' : payload['token'].toString(),
    };
    Get.toNamed(Routes.VIDEO_CALL,parameters: data);
  }else{
    var data = {
      'channelId' : payload['channelId'].toString(),
      'agora_token' : payload['token'].toString(),
      'remote_user_name' : payload['user_name'].toString(),
      'remoteUserProfile' : payload['user_image'].toString(),
    };
    Get.toNamed(Routes.AUDIO_CALL,parameters: data);
  }

}


final FlutterCallkeep _callKeep = FlutterCallkeep();

class FirebaseNotifications extends ChangeNotifier {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Map<String, Call> calls = {};

  String newUUID() => const Uuid().v4();

  void firebaseInitialization() {
    _callKeep.on(CallKeepDidDisplayIncomingCall(), didDisplayIncomingCall);
    _callKeep.on(CallKeepPerformAnswerCallAction(), answerCall);
    _callKeep.on(CallKeepDidPerformDTMFAction(), didPerformDTMFAction);
    _callKeep.on(CallKeepDidReceiveStartCallAction(), didReceiveStartCallAction);
    _callKeep.on(CallKeepDidToggleHoldAction(), didToggleHoldCallAction);
    _callKeep.on(CallKeepDidPerformSetMutedCallAction(), didPerformSetMutedCallAction);
    _callKeep.on(CallKeepPerformEndCallAction(), endCall);
    _callKeep.on(CallKeepPushKitToken(), onPushKitToken);

    _callKeep.setup(navigatorKey.currentContext, <String, dynamic>{
      'ios': {
        'appName': 'Airnest',
      },
      'android': {
        'alertTitle': 'Permissions required',
        'alertDescription':
        'This application needs to access your phone accounts',
        'cancelButton': 'Cancel',
        'okButton': 'ok',
        'foregroundService': {
          'channelId': 'com.advc.adot',
          'channelName': 'Foreground service for my app',
          'notificationTitle': 'My app is running on background',
          'notificationIcon': 'assets/images/adot-logo.png',
        },
      },
    });

    // _firebaseMessaging.getToken().then((token) {
    //   setToken(token);
    // });

    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if (message != null) {
        if (kDebugMode) {
          print('instance');
        }
        if (message.data['type'] == 'video') {
          var currentUuid = const Uuid().v4();
          showCallkitIncoming(currentUuid, message.data,message.data['user_name'],message.data['user_image']);
        }else if (message.data['type'] == 'audio'){
          var currentUuid = const Uuid().v4();
          showCallkitIncoming(currentUuid, message.data,message.data['user_name'],message.data['user_image']);
        } else {
          notificationClick(message);
        }
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('OnMessage ${message.data}');
      }
      // _counterModel.fetchCount();

      notificationDialogManage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (kDebugMode) {
        print('onMessageOpenedApp');
      }
      if (kDebugMode) {
        print('message ${message.data}');
      }
      if (message.data['type'] == 'video') {
        var currentUuid0 = const Uuid().v4();
        showCallkitIncoming(currentUuid0, message.data,message.data['user_name'],message.data['user_image']);
      }else if (message.data['type'] == 'audio'){
        var currentUuid = const Uuid().v4();
        showCallkitIncoming(currentUuid, message.data,message.data['user_name'],message.data['user_image']);
      }else {
        if (kDebugMode) {
          print('-------------------------------onMessageOpenedApp');
        }
        notificationClick(message);
      }
    });
  }

  // Future setToken(token) async {
  //   if (kDebugMode) {
  //     print('Token------------------------${token.toString()}');
  //   }
  //
  //   if (token == null) {
  //
  //   } else {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setString('fcm_token', token.toString());
  //
  //     // CollectionReference usersData =
  //     //     FirebaseFirestore.instance.collection('users');
  //     //
  //     // usersData
  //     //     .doc(prefs.getString('deviceId'))
  //     //     .update({'company': 'Stokes and Sons'})
  //     //     .then((value) => print("User Updated"))
  //     //     .catchError((error) => print("Failed to update user: $error"));
  //   }
  // }

  Future<void> notificationDialogManage(RemoteMessage message) async {
    if (kDebugMode) {
      print('message get or not yet');
    }
    var title = message.notification!.title??'';
    var body = message.notification!.body??'';
    if (kDebugMode) {
      print('message ${message.data}');
    }
    //print('message ${message.data['type']}');

    if (Platform.isAndroid) {
      if (message.data['type'] == 'video') {
        var currentUuid = const Uuid().v4();
        showCallkitIncoming(currentUuid, message.data,message.data['user_name'],message.data['user_image']);
      }else if (message.data['type'] == 'audio'){
        var currentUuid = const Uuid().v4();
        showCallkitIncoming(currentUuid, message.data,message.data['user_name'],message.data['user_image']);
      } else {
        if (kDebugMode) {
          print('-------------------------------call android');
        }
        PushNotificationService()._showNotification(message);
      }
    }

    if (Platform.isIOS) {
      if (kDebugMode) {
        print('notification get');
      }

      if (message.data['type'] == 'video') {
        var currentUuid0 = const Uuid().v4();

        showCallkitIncoming(currentUuid0, message.data,message.data['user_name'],message.data['user_image']);
      } else if (message.data['type'] == 'audio'){
        var currentUuid = const Uuid().v4();
        showCallkitIncoming(currentUuid, message.data,message.data['user_name'],message.data['user_image']);
      } else {
        showDialog(
          context: navigatorKey.currentContext!,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  notificationClickIos(message);
                },
                child: const Text('Ok'),
              )
            ],
          ),
        );
      }
    }
  }

  Future<void> displayIncomingCall(String number) async {
    final String callUUID = newUUID();
    // setState(() {
    calls[callUUID] = Call(number);
    // });
    log('Display incoming call now');
    final bool hasPhoneAccount = await _callKeep.hasPhoneAccount();
    if (!hasPhoneAccount) {
      await _callKeep.hasDefaultPhoneAccount(
          navigatorKey.currentContext!, <String, dynamic>{
        'alertTitle': 'Permissions required',
        'alertDescription':
        'This application needs to access your phone accounts',
        'cancelButton': 'Cancel',
        'okButton': 'ok',
        'foregroundService': {
          'channelId': 'com.company.my',
          'channelName': 'Foreground service for my app',
          'notificationTitle': 'My app is running on background',
          'notificationIcon': 'Path to the resource icon of the notification',
        },
      });
    }

    log('[displayIncomingCall] $callUUID number: $number');
    _callKeep.displayIncomingCall(callUUID, number,
        handleType: 'number', hasVideo: true);
  }

  void didDisplayIncomingCall(CallKeepDidDisplayIncomingCall event) {
    var callUUID = event.callUUID;
    var number = event.handle;
    log('[displayIncomingCall] $callUUID number: $number');
    // setState(() {
    calls[callUUID!] = Call(number!);
    // });
  }

  void onPushKitToken(CallKeepPushKitToken event) {
    log('[onPushKitToken] token => ${event.token}');
  }

  void removeCall(String callUUID) {
    // setState(() {
    calls.remove(callUUID);
    // });
  }

  void setCallHeld(String callUUID, bool held) {
    // setState(() {
    calls[callUUID]!.held = held;
    // });
  }

  void setCallMuted(String callUUID, bool muted) {
    // setState(() {
    calls[callUUID]!.muted = muted;
    // });
  }

  Future<void> answerCall(CallKeepPerformAnswerCallAction event) async {
    final String callUUID = event.callUUID!;
    final String number = calls[callUUID]!.number;
    log('[answerCall] $callUUID, number: $number');
    Timer(const Duration(seconds: 1), () {
      log('[setCurrentCallActive] $callUUID, number: $number');
      _callKeep.setCurrentCallActive(callUUID);
    });
  }

  Future<void> endCall(CallKeepPerformEndCallAction event) async {
    log('endCall: ${event.callUUID}');
    removeCall(event.callUUID!);
  }

  Future<void> didPerformDTMFAction(CallKeepDidPerformDTMFAction event) async {
    log('[didPerformDTMFAction] ${event.callUUID}, digits: ${event.digits}');
  }

  Future<void> didReceiveStartCallAction(
      CallKeepDidReceiveStartCallAction event) async {
    if (event.handle == null) {
      // @TODO: sometime we receive `didReceiveStartCallAction` with handle` undefined`
      return;
    }
    final String callUUID = event.callUUID ?? newUUID();
    // setState(() {
    calls[callUUID] = Call(event.handle!);
    // });
    log('[didReceiveStartCallAction] $callUUID, number: ${event.handle}');

    _callKeep.startCall(callUUID, event.handle!, event.handle!);

    Timer(const Duration(seconds: 1), () {
      log('[setCurrentCallActive] $callUUID, number: ${event.handle}');
      _callKeep.setCurrentCallActive(callUUID);
    });
  }

  Future<void> didPerformSetMutedCallAction(
      CallKeepDidPerformSetMutedCallAction event) async {
    final String number = calls[event.callUUID]!.number;
    log(
        '[didPerformSetMutedCallAction] ${event.callUUID}, number: $number (${event.muted})');

    setCallMuted(event.callUUID!, event.muted!);
  }

  Future<void> didToggleHoldCallAction(
      CallKeepDidToggleHoldAction event) async {
    final String number = calls[event.callUUID]!.number;
    log(
        '[didToggleHoldCallAction] ${event.callUUID}, number: $number (${event.hold})');

    setCallHeld(event.callUUID!, event.hold!);
  }

  Future<void> hangup(String callUUID) async {
    _callKeep.endCall(callUUID);
    removeCall(callUUID);
  }

  Future<void> setOnHold(String callUUID, bool held) async {
    _callKeep.setOnHold(callUUID, held);
    final String handle = calls[callUUID]!.number;
    log('[setOnHold: $held] $callUUID, number: $handle');
    setCallHeld(callUUID, held);
  }

  Future<void> setMutedCall(String callUUID, bool muted) async {
    _callKeep.setMutedCall(callUUID, muted);
    final String handle = calls[callUUID]!.number;
    log('[setMutedCall: $muted] $callUUID, number: $handle');
    setCallMuted(callUUID, muted);
  }

  Future<void> updateDisplay(String callUUID) async {
    final String number = calls[callUUID]!.number;
    // Workaround because Android doesn't display well displayName, se we have to switch ...
    if (isIOS) {
      _callKeep.updateDisplay(callUUID,
          displayName: 'New Name', handle: number);
    } else {
      _callKeep.updateDisplay(callUUID,
          displayName: number, handle: 'New Name');
    }

    log('[updateDisplay: $number] $callUUID');
  }

  Widget buildCallingWidgets() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: calls.entries
            .map((MapEntry<String, Call> item) =>
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text('number: ${item.value.number}'),
              Text('uuid: ${item.key}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      setOnHold(item.key, !item.value.held);
                    },
                    child: Text(item.value.held ? 'Unhold' : 'Hold'),
                  ),
                  InkWell(
                    onTap: () async {
                      updateDisplay(item.key);
                    },
                    child: const Text('Display'),
                  ),
                  InkWell(
                    onTap: () async {
                      setMutedCall(item.key, !item.value.muted);
                    },
                    child: Text(item.value.muted ? 'Unmute' : 'Mute'),
                  ),
                  InkWell(
                    onTap: () async {
                      hangup(item.key);
                    },
                    child: const Text('Hangup'),
                  ),
                ],
              )
            ]))
            .toList());
  }
}

class Call {
  Call(this.number);

  String number;
  bool held = false;
  bool muted = false;
}
///----------------------------------------- ADOT CODE --------------------------------------///



/// MY CODE
// class PushNotificationnn {
//
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   Future<void> init() async {
//
//    await _firebaseMessaging.requestPermission(
//      sound: true,
//      badge: true,
//      alert: true,
//    );
//    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//    print("jay - -------");
//
//
//    const AndroidInitializationSettings initializationSettingsAndroid =
//    // AndroidInitializationSettings('@mipmap/ic_launcher');
//    AndroidInitializationSettings('logo');
//
//    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//    FlutterLocalNotificationsPlugin();
//
//    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
//        AndroidFlutterLocalNotificationsPlugin>();
//
//
//    final List<DarwinNotificationCategory> darwinNotificationCategories =
//    <DarwinNotificationCategory>[
//      DarwinNotificationCategory(
//        darwinNotificationCategoryText,
//        actions: <DarwinNotificationAction>[
//          DarwinNotificationAction.text(
//            'text_1',
//            'Action 1',
//            buttonTitle: 'Send',
//            placeholder: 'Placeholder',
//          ),
//        ],
//      ),
//      DarwinNotificationCategory(
//        darwinNotificationCategoryPlain,
//        actions: <DarwinNotificationAction>[
//          DarwinNotificationAction.plain('id_1', 'Action 1'),
//          DarwinNotificationAction.plain(
//            'id_2',
//            'Action 2 (destructive)',
//            options: <DarwinNotificationActionOption>{
//              DarwinNotificationActionOption.destructive,
//            },
//          ),
//          DarwinNotificationAction.plain(
//            navigationActionId,
//            'Action 3 (foreground)',
//            options: <DarwinNotificationActionOption>{
//              DarwinNotificationActionOption.foreground,
//            },
//          ),
//          DarwinNotificationAction.plain(
//            'id_4',
//            'Action 4 (auth required)',
//            options: <DarwinNotificationActionOption>{
//              DarwinNotificationActionOption.authenticationRequired,
//            },
//          ),
//        ],
//        options: <DarwinNotificationCategoryOption>{
//          DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
//        },
//
//      )
//    ];
//    final DarwinInitializationSettings initializationSettingsDarwin =
//    DarwinInitializationSettings(
//      requestAlertPermission: true,
//      requestBadgePermission: true,
//      requestSoundPermission: true,
//      defaultPresentAlert: true,
//      defaultPresentBadge: true,
//      defaultPresentBanner: true,
//      defaultPresentList: true,
//      defaultPresentSound: true,
//      requestCriticalPermission: true,
//
//      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
//        didReceiveLocalNotificationStream.add(
//          ReceivedNotification(
//            id: id,
//            title: title,
//            body: body,
//            payload: payload,
//          ),
//        );
//      },
//      notificationCategories: darwinNotificationCategories,
//    );
//    final InitializationSettings initializationSettings = InitializationSettings(
//      android: initializationSettingsAndroid,
//      iOS: initializationSettingsDarwin,
//      // macOS: initializationSettingsDarwin,
//      // linux: initializationSettingsLinux,
//    );
//    await flutterLocalNotificationsPlugin.initialize(
//      initializationSettings,
//      onDidReceiveNotificationResponse: (payload) {
//        print('-------------------------LocalNotificationsPlugin');
//        print('payload-------------------------${payload.payload}');
//      },
//      // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
//    );
//
//    // Foreground Notifications
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Received foreground message: ${message.notification?.body}');
//       // Handle the received message here
//       _showNotification(message);
//     });
//
//     //App Closed Notifications
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('App opened from closed state: ${message.notification?.body}');
//       // Handle the received message here
//       _showNotification(message);
//     });
//
//    // Background Notifications
//    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
//      print("Background message: ${message.notification?.body}");
//      _showNotification(message);
//    });
//   }
//
//   Future<void> _showNotification(message) async {
//
//     print('showNotification ---------------------${ message.data}');
//
//     if (message.data['type'] == 'video') {
//
//       _configureFCM();
//
//     }else{
//
//       if(message.data['image'].toString().isNotEmpty){
//
//         AndroidNotificationDetails androidNotificationDetails =
//         const AndroidNotificationDetails(
//             'your channel id',
//             'your channel name',
//             channelDescription: 'your channel description',
//             // styleInformation: bigPictureStyleInformation,
//             importance: Importance.max,
//             priority: Priority.high,
//             enableVibration: true,
//             ticker: 'ticker');
//         NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//         await flutterLocalNotificationsPlugin.show(
//             id++,  message.notification?.title ?? '',
//             message.notification?.body?? '', notificationDetails,
//             payload: message.data['notify_type'].toString());
//       }else{
//         print('text-------------------------------');
//         AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
//             'your channel id',
//             'your channel name',
//             channelDescription: 'your channel description',
//             importance: Importance.max,
//
//             priority: Priority.high,
//             enableVibration: true,
//             ticker: 'ticker');
//         NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
//         await flutterLocalNotificationsPlugin.show(
//             id++,  message.notification?.title ?? '',
//             message.notification?.body?? '', notificationDetails,
//             payload: message.data['notify_type'].toString());
//       }
//     }
//   }
//
//   void _configureFCM() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print("jaydeep ------ onMessage ");
//       _showIncomingCallNotification(message.data['channelId'], message.data['token']);
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print("jaydeep ------ onMessageOpenedApp ");
//       _joinCall(message.data['channelId'], message.data['token']);
//     });
//   }
//
//   void _showIncomingCallNotification(String channelId, String token) {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'call_channel_id', 'Call Channel',
//       importance: Importance.max,
//       priority: Priority.high,
//       sound: null,
//       // sound: RawResourceAndroidNotificationSound('call_sound'),
//       playSound: true,
//     );
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
//     flutterLocalNotificationsPlugin.show(
//       0,
//       'Incoming Call',
//       'You have an incoming video call',
//       platformChannelSpecifics,
//       payload: '$channelId,$token',
//     );
//     _joinCall(channelId,token);
//
//   }
//
//   void _joinCall(String channelId, String token) {
//
//     print("jaydeep ------ joided call ");
//     var data = {
//       'channelId' : channelId,
//       'agora_token' : token,
//     };
//     Get.toNamed(Routes.VIDEO_CALL,parameters: data);
//   }
//
// }
/// MY CODE



class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  bool _initialized = false;

  factory FirebaseService() {
    return _instance;
  }

  FirebaseService._internal();

  Future<void> initializeFirebase() async {
    if (!_initialized) {
      try {
        await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyB-aDsU9oCrGjIN8xqQxAQEEnWPhopA464",
              authDomain: "airnests-app-39a0a.firebaseapp.com",
              projectId: "airnests-app-39a0a",
              storageBucket: "airnests-app-39a0a.appspot.com",
              messagingSenderId: "121970113693",
              appId: "1:121970113693:web:e4d9ed33cbb1bc1fb42874",
              measurementId: "G-4EB95SY08T"
          ),
        );
        _initialized = true;
      } catch (e) {
        if (kDebugMode) {
          print("Error initializing Firebase: 👉🏻 👉🏻 👉🏻 👉🏻 👉🏻 👉🏻 👉🏻 👉🏻 $e");
        }
      }
    }
  }
}

