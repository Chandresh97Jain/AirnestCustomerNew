import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:power_maids/Utils/color_style.dart';

import 'global_text.dart';

class AppbarWithBackButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? titleColor;

  const AppbarWithBackButton(
      {required this.text, required this.onPressed, this.titleColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          icon: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Container(
                decoration: BoxDecoration(color: AppStyles.backgroundColor),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.arrow_back),
                ),
              )),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: Textwidget(
            text: text,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: titleColor,
          ),
        ),
      ],
    );
  }
}
