import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:power_maids/Utils/global_text.dart';


class OnbordingScreensAppbar extends StatelessWidget {

  final String? Title;

  const OnbordingScreensAppbar({ this.Title});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // Set a base font size
    double titleFontSize = 25.0;
     // Calculate the adjusted font size based on screen width
    double adjustedFontSize = screenWidth / 350.0 * titleFontSize;
     return Textwidget(
       textscalefector: 1,
      text: Title,
      fontSize: adjustedFontSize,
      fontWeight: FontWeight.w700,
    );
  }
}
