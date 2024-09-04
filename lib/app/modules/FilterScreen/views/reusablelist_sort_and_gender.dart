import 'package:flutter/material.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';

class SortOptionAndGender extends StatelessWidget {
  final String text;
  final String iconImage;
  final VoidCallback onPressed;

  const SortOptionAndGender(
      {Key? key,
      required this.text,
      required this.iconImage,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Textwidget(
                text: text,
                color: AppStyles.BlacklightTextcolor,
              ),
              Image.asset(
                iconImage,
                height: 23,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 0,
          )
        ],
      ),
    );
  }
}
