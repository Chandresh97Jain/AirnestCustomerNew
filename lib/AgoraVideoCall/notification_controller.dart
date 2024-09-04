import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../app/modules/VideoCall/views/video_call_view.dart';
import '../app/routes/app_pages.dart';

class NotificationController extends GetxController {
  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    _requestPermission();
    _configureFCM();
    _initializeLocalNotifications();
  }

  void _requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void _configureFCM() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data['type'] == 'call') {
        _showIncomingCallNotification(message.data['channelId'], message.data['token']);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['type'] == 'call') {
        _joinCall(message.data['channelId'], message.data['token']);
      }
    });
  }

  void _initializeLocalNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('logo');
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _showIncomingCallNotification(String channelId, String token) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'call_channel_id', 'Call Channel',
      importance: Importance.max,
      priority: Priority.high,
      sound: null,
      // sound: RawResourceAndroidNotificationSound('call_sound'),
      playSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    _flutterLocalNotificationsPlugin.show(
      0,
      'Incoming Call',
      'You have an incoming video call',
      platformChannelSpecifics,
      payload: '$channelId,$token',
    );
  }

  void _joinCall(String channelId, String token) {
    var data = {
      'channelId' : channelId,
      'agora_token' : token,
    };
    Get.toNamed(Routes.VIDEO_CALL,parameters: data);
  }
}
