import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/modules/Splash/controllers/splash_controller.dart';
import 'package:video_player/video_player.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isVideoInitialized.value
            ? Stack(
                children: [
                  // Video player as the background
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: VideoPlayer(controller.videoPlayerController),
                  ),

                  // Gradient overlay to create shadow from bottom to top
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 500.0, // Adjust the height of the gradient area
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black87, // Black at the bottom
                            Colors.transparent, // Transparent at the top
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Positioned widget to place logo and text at the bottom
                  Positioned(
                    bottom: 50.0, // Adjust the distance from the bottom
                    left: 0,
                    right: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Your logo widget
                        Image.asset(
                          'assets/images/New Logo (2).png', // Replace with your logo path
                          width: 150, // Adjust logo size
                          height: 150,
                        ),
                        const SizedBox(height: 10),
                        // Your text widget
                        Textwidget(
                          text: 'Airnests',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ), // Show a loader until the video is ready
      ),
    );
  }
}
