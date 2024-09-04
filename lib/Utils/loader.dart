import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'color_style.dart';

class ShowLoader{

  static isLoadingProgress(bool show) {
   return Center(
       child:  Visibility(
         visible: show,
         child: Stack(
           alignment: Alignment.center,
           children: [
             Image.asset(
               "assets/icons/logo.png",
               scale: 14.5,
             ),
             LoadingAnimationWidget.beat(
               color: Colors.white,
               size: 70.0,
             )
           ],
         ),
       )
   );

  }
}

class ShowLoaderr{

  static isLoadingProgress() {
   return Center(

       child:  Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/icons/logo.png",
            scale: 14.5,
          ),
          LoadingAnimationWidget.beat(
            color: Colors.white,
            size: 70.0,
          )
        ],
                )
   );

  }
}

class ShowLoaderOn{

  static isLoadingProgress(bool show) {
    return Center(
        child:  Visibility(
          visible: show,
          child: Container(
            color: AppStyles.appThemeColor.withOpacity(0.05),
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/icons/logo.png",
                  scale: 14.5,
                ),
                LoadingAnimationWidget.beat(
                  color: Colors.white,
                  size: 70.0,
                )
              ],
            ),
          ),
        )
    );

  }
}