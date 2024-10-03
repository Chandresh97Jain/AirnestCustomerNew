import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:power_maids/Notifications/PushNotificationService.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;
  final image = "assets/images/Splash Screen.png".obs;

  late VideoPlayerController videoPlayerController;
  var isVideoInitialized = false.obs;
  final videoPath = 'assets/images/customerSplash2.mp4.mp4';

  void initializeVideo() {
    videoPlayerController = VideoPlayerController.asset(
      videoPath, // Your video URL
    )..initialize().then((_) {
        // Update state once video is initialized
        isVideoInitialized.value = true;
        videoPlayerController.play();
        videoPlayerController.setLooping(true);
      });
  }

  @override
  void onInit() {
    super.onInit();
    FirebaseNotifications().firebaseInitialization();
    requestLocationPermission();
    initializeVideo();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    super.onClose();
  }

  void dispose() {
    _timer?.cancel();
    locationSubscription?.cancel();
  }

  void increment() => count.value++;
  //
  // requestLocationPermission() async {
  //   Location location = Location();
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;
  //
  //   // Check if location services are enabled
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     log("_serviceEnabled  -- $_serviceEnabled");
  //     _serviceEnabled = await location.requestService();
  //     // Future.delayed(  const Duration(seconds: 2), navigateUser);
  //     // Check if location permissions are granted
  //     _permissionGranted = await location.hasPermission();
  //     if (_permissionGranted == PermissionStatus.denied) {
  //       _permissionGranted = await location.requestPermission();
  //       if (_permissionGranted != PermissionStatus.granted) {
  //         ToastClass.showToast("Please allow location permission to continue!");
  //         exit(0);
  //       }
  //     }else{
  //       Future.delayed( const Duration(seconds: 1), navigateUser);
  //     }
  //     if (!_serviceEnabled) {
  //       ToastClass.showToast("Please enable location service to continue!");
  //       exit(0);
  //     }
  //   }else{
  //     Future.delayed( const Duration(seconds: 1), navigateUser);
  //   }
  // }
  //
  // void navigateUser() async {
  //
  //   final prefs = await SharedPreferences.getInstance();
  //   var userId = prefs.getString('userID');
  //   var authToken = prefs.getString('auth_token');
  //
  //   log("authToken ------  -- -  - - ${authToken.toString()}");
  //   if(authToken == null){
  //     Get.offAllNamed(Routes.WELLCOME_SCREEN);
  //   }else{
  //     Get.offAllNamed(Routes.DESHBOARD);
  //   }
  //
  //   // Future.delayed(const Duration(seconds: 2)).then((value) async {
  //   //   final prefs = await SharedPreferences.getInstance();
  //   //   var userId = prefs.getString('userID');
  //   //   var authToken = prefs.getString('auth_token');
  //   //
  //   //   log("authToken ------  -- -  - - ${authToken.toString()}");
  //   //   if(authToken == null){
  //   //     Get.offAllNamed(Routes.WELLCOME_SCREEN);
  //   //   }else{
  //   //     Get.offAllNamed(Routes.DESHBOARD);
  //   //   }
  //   // }
  //   // );
  //
  // }
  /// 1 code
//   requestLocationPermission() async {
//     Location location = Location();
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;
//
//     // Check if location services are enabled
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       log("_serviceEnabled  -- $_serviceEnabled");
//       _serviceEnabled = await location.requestService();
//
//       if (!_serviceEnabled) {
//         ToastClass.showToast("Please enable location service to continue!");
//         return; // Stop further execution instead of exiting the app
//       }
//     }
//
//     // Check if location permissions are granted
//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         ToastClass.showToast("Please allow location permission to continue!");
//         return; // Stop further execution instead of exiting the app
//       }
//     }
//
//     // If all conditions are met, navigate to the appropriate screen
//     Future.delayed(const Duration(seconds: 1), navigateUser);
//   }
//
//   void navigateUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     var userId = prefs.getString('userID');
//     var authToken = prefs.getString('auth_token');
//
//     log("authToken ------  -- -  - - ${authToken.toString()}");
//     if (authToken == null) {
//       Get.offAllNamed(Routes.WELLCOME_SCREEN);
//     } else {
//       Get.offAllNamed(Routes.DESHBOARD);
//     }
//   }
//
  /// 2 code

  Location location = Location();
  late StreamSubscription<LocationData> locationSubscription;
  Timer? _timer; // Timer to periodically check location service

  requestLocationPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // Check if location services are enabled
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      log("_serviceEnabled  -- $_serviceEnabled");
      _serviceEnabled = await location.requestService();

      if (!_serviceEnabled) {
        ToastClass.showToast("Please enable location service to continue!");
        // Listen for changes in location service status
        listenToLocationServiceChanges();
        return; // Stop further execution instead of exiting the app
      }
    }

    // Check if location permissions are granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        ToastClass.showToast("Please allow location permission to continue!");
        return; // Stop further execution instead of exiting the app
      }
    }
    // If all conditions are met, navigate to the appropriate screen
    Future.delayed(const Duration(seconds: 2), navigateUser);
    // navigateUser();
  }

  void listenToLocationServiceChanges() {
    // Use a timer to periodically check if the service is enabled
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) async {
      bool _serviceEnabled = await location.serviceEnabled();
      if (_serviceEnabled) {
        // Location service is enabled, navigate to the appropriate screen
        // ToastClass.showToast("Location service enabled! Navigating...");
        navigateUser();
        // Future.delayed(const Duration(seconds: 2), navigateUser);
        _timer?.cancel(); // Stop the timer once navigated
      }
    });
  }

  void navigateUser() async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userID');
    var authToken = prefs.getString('auth_token');

    log("authToken ------  -- -  - - ${authToken.toString()}");
    if (authToken == null) {
      Get.offAllNamed(Routes.WELLCOME_SCREEN);
    } else {
      Get.offAllNamed(Routes.DESHBOARD);
    }
  }
}
