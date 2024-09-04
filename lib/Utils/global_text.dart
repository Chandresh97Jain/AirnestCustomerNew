import 'package:flutter/cupertino.dart';

class Textwidget extends StatelessWidget {
  final String? text;
  final double? fontSize;Color? color;TextAlign? textAlign;FontWeight? fontWeight;
  final height;
  final maxLines;
  final  decoration;
  final  decorationColor;
  final double? textscalefector;

  Textwidget(
      {this.text,
        this.fontSize,
        this.color,
         this.fontWeight,
        this.height,
        this.maxLines,
        this.textAlign,
        this.decoration,
        this.decorationColor,
      this.textscalefector

      });

  @override
  Widget build(BuildContext context) {
    return Text(
      textScaleFactor: textscalefector,
      text ?? "",
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
       style: TextStyle(
         overflow: TextOverflow.ellipsis,
          height: height,
          
          fontFamily: "JosefinSans",
          fontSize: fontSize,
          fontWeight: fontWeight,
          //color: Theme.of(context).iconTheme.color
           decorationColor:decorationColor,
           decoration: decoration,
          color: color),
    );
  }
}
