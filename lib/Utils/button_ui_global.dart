import 'package:flutter/material.dart';
import 'color_style.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color TextColor;

  const MyButton(
      {required this.text,
      required this.onPressed,
      required this.color,
      required this.TextColor});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // Set a base font size
    double titleFontSize = 16.0;
    // Calculate the adjusted font size based on screen width
    double adjustedFontSize = screenWidth / 350.0 * titleFontSize;

    return InkWell(
        borderRadius: BorderRadius.circular(10),

        onTap: onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: color),
          child: Center(
              child: Text(
            text,
            textScaleFactor: 1,
            style: TextStyle(
                fontFamily: "JosefinSans",
                color: TextColor,
                fontWeight: FontWeight.w500,
                fontSize: adjustedFontSize),
          )),
        )
    );
  }
}

class MyButtonwithIcon extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color Textcolor;
  final Color? iconcolor;
  final String? iconimage;
  final double? iconImageSize;

  const MyButtonwithIcon(
      {required this.text,
      required this.onPressed,
      required this.color,
      required this.Textcolor,
      this.iconcolor,
      this.iconimage,
      this.iconImageSize});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: color),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                iconimage.toString(),
                color: iconcolor,
                height: iconImageSize,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyle(
                    fontFamily: "JosefinSans",
                    color: Textcolor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ],
          )),
        ));
  }
}

class OutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color bordercolor;
  final Color tectcolor;

  const OutlineButton(
      {required this.text,
      required this.onPressed,
      required this.bordercolor,
      required this.tectcolor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: bordercolor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
              child: Text(
            textAlign: TextAlign.center,
            text,
            style: TextStyle(
                fontFamily: "JosefinSans",
                color: tectcolor,
                fontWeight: FontWeight.w500,
                fontSize: 16),
          )),
        ));
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textcolor;

  const RoundedButton({
    required this.text,
    required this.onPressed,
    required this.color,
    required this.textcolor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18), color: color),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Center(
                child: Text(
              textScaleFactor: 1,
              text,
              style: TextStyle(
                  fontFamily: "JosefinSans",
                  color: textcolor,
                  fontWeight: FontWeight.w800,
                  fontSize: 12.5),
            )),
          ),
        ));
  }
}

class MyButtonForAlertbox extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color TextColor;

  const MyButtonForAlertbox(
      {required this.text,
      required this.onPressed,
      required this.color,
      required this.TextColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: color),
          child: Center(
              child: Text(
            text,
            textScaleFactor: 1,
            style: TextStyle(
                fontFamily: "JosefinSans",
                color: TextColor,
                fontWeight: FontWeight.w700,
                fontSize: 12),
          )),
        ));
  }
}
