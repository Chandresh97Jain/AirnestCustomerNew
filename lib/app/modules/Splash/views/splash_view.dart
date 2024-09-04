import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/app/modules/Splash/controllers/splash_controller.dart';


class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
               controller.image.value,
                fit: BoxFit.fill,
               ),
            ),
      ),
    );
  }
}
