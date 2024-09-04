import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/modules/ConnectivityScreen/controllers/connectivity_screen_controller.dart';

class ConnectivityScreenView extends GetView<ConnectivityScreenController> {
  const ConnectivityScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width * .65,
                child: SvgPicture.asset(
                  "assets/icons/nonet.svg",
                  height: height * .4,
                ),
              ),
              Textwidget(
                fontSize: 20,
                text: "Oops!",
              ),
              Textwidget(
                text: "No Internet Connection",
                textAlign: TextAlign.center,
                fontSize: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
