import 'package:flutter/material.dart';
import 'package:power_maids/Utils/global_text.dart';

class ProfileUI extends StatelessWidget {
  final String iconImages;
  final String title;
  final VoidCallback onPressed;
  final Color? iconColor;
  final Color? imageIconColor;

  const ProfileUI(
      {super.key,
      required this.iconImages,
      required this.title,
      required this.onPressed,
      this.iconColor,
      this.imageIconColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Row(
                  children: [
                    SizedBox(
                        width: 25,
                        child: Image.asset(
                          iconImages,
                          height: 30,
                          color: imageIconColor,
                        )),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: Textwidget(
                        textscalefector: 1,
                        maxLines: 1,
                        text: title,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: 18,
                color: iconColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
