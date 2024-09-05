import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:power_maids/app/modules/ConnectivityScreen/views/connectivity_screen_view.dart';
import 'Notifications/PushNotificationService.dart';
import 'app/routes/app_pages.dart';


Future<void> requestNotificationPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.microphone,
    Permission.camera,
    Permission.audio
  ].request();
  print(statuses[Permission.location]);



  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
}

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
 await FirebaseService().initializeFirebase();
  // await PushNotificationService().init();
 await requestNotificationPermissions();

  // Stripe.publishableKey = "pk_test_51LMds6GVpTf9ozAW3QSiODUgfZidpwBAW4j87XLUEnxufm7Acd72AVA7qvxWadL8NWtBlbbXgZhh7OIhBz1Aw1kE00zKYuijEz";
  Stripe.publishableKey = "pk_live_51LMds6GVpTf9ozAWGOUgoO6k3f0hKrvYSm9cNgTZ1J4hQsPE3mtpc3PWHpnAkXrYqLTZcwfWKJnsErqTWYCSftlk00KJsZ3rCK";
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print('Received background message: ${message.notification?.body}');
//
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return InternetWidget(

      offline: FullScreenWidget( child: ConnectivityScreenView()),




      online: GetMaterialApp(
        //  initialBinding: ControllerBinding(),
        debugShowCheckedModeBanner: false,
        title: "Airnest",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          //  canvasColor: AppStyles.appThemeColor,
            useMaterial3: true,
        ),
      ),
    );
  }
}

int id = 0;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
StreamController<String?>.broadcast();


const MethodChannel platform = MethodChannel('dexterx.dev/flutter_local_notifications_example');

const String portName = 'notification_send_port';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });


  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';
final navigatorKey = GlobalKey<NavigatorState>();