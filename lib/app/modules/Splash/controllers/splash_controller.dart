import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:power_maids/Notifications/PushNotificationService.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;
  final image = "assets/images/Splash Screen.png".obs;

  @override
  void onInit() {
    super.onInit();
    FirebaseNotifications().firebaseInitialization();
    requestLocationPermission();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  requestLocationPermission() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // Check if location services are enabled
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      log("_serviceEnabled  -- $_serviceEnabled");
      _serviceEnabled = await location.requestService();
      Future.delayed(  const Duration(seconds: 3), navigateUser);
      // Check if location permissions are granted
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          ToastClass.showToast("Please allow location permission to continue!");
          exit(0);
        }
      }else{
        Future.delayed( const Duration(seconds: 3), navigateUser);
      }
      if (!_serviceEnabled) {
        ToastClass.showToast("Please enable location service to continue!");
        exit(0);
      }
    }else{
      Future.delayed( const Duration(seconds: 3), navigateUser);
    }
  }

  void navigateUser() async {
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      final prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('userID');
      var authToken = prefs.getString('auth_token');

      log("authToken ------  -- -  - - ${authToken.toString()}");
      if(authToken == null){
        Get.offAllNamed(Routes.WELLCOME_SCREEN);
      }else{
        Get.offAllNamed(Routes.DESHBOARD);
      }
    }
    );


   // Get.offAllNamed(Routes.SIGN_IN);
   //  Get.offAllNamed(Routes.WELLCOME_SCREEN);


    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var loginstatus=prefs.getString('loginstatus');
    // String status = SharedPreferencesUtils.getString(SDConstant.token).toString();
    // print("status"+status);
    //
    // loginstatus=="true"
    //     ? Get.offAllNamed(Routes.DESHBOARD)
    //     : Get.offAllNamed(Routes.LOGIN);
  }

}
