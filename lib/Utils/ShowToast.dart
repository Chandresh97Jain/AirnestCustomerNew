import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/color_style.dart';


class ToastClass{
  static const String colorwhite  = '#ffffff';
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
 static showToast(String msg) {
   Get.snackbar(
     msg,
     "",
     icon: Padding(
       padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
       child: Image.asset(
         'assets/icons/logo.png',

       ),
     ),

     snackPosition: SnackPosition.BOTTOM,
     margin: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
     isDismissible: true,
     messageText: SizedBox(
       height: 0,
     ),
     padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
     backgroundColor:AppStyles.appThemealtralightColor,
     // isDark(Get.context!) ? Colors.white54 : ,
     colorText: AppStyles.appThemeColor,
     forwardAnimationCurve: Curves.easeOut,
     borderRadius: 5.0

   );
 }

}