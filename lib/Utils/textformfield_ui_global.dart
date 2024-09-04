import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_style.dart';

class TextFieldDesigned extends StatelessWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final IconButton? suffixIcon;
  final    prefixIcon;
  final Color? hintStyle;
  final String hintText;
  final String initialValue;
  final int? maxLength, minLines;
  final int maxLines;
  final bool readOnly;
  final bool obscureText;
  final TextInputType keyboardType;
  final AutovalidateMode? autovalidateMode;
  final FormFieldValidator<String>? validator;
  final GestureTapCallback? onTap;
  final TextAlign textAlign;
  final double fontSize;
  final FocusNode? focusNode;
  final FontWeight fontWeight;
    final String? counterText;
    final ValueChanged<String>? onChanged;

    const TextFieldDesigned({super.key,
    this.inputFormatters,
    this.onTap,
    this.readOnly = false,
    this.obscureText = false,
    this.controller,
    this.hintStyle = Colors.white12,
    this.initialValue = "",
    this.suffixIcon,
    this.prefixIcon,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w300,
    this.autovalidateMode,
    this.hintText = "",
    this.maxLines = 1,
    this.minLines ,
    this.maxLength = 300,
    this.validator,
    this.focusNode,
    this.keyboardType = TextInputType.number,
    this.textAlign = TextAlign.start,
    this.counterText = "",
    this.onChanged,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: AppStyles.TextFormFieldBackgroundColor),
      child: TextFormField(
       // focusNode: focusNode,
        autofocus: false,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        textAlignVertical: TextAlignVertical.center,
        obscureText: obscureText,
        cursorColor:const  Color(0xff0F0F0F),
        textCapitalization: TextCapitalization.sentences,
        readOnly: readOnly,
        autovalidateMode: autovalidateMode,
        validator: validator,
        onTap: onTap,
        controller: controller,
        maxLength: maxLength,
        maxLines: maxLines,
        minLines: minLines,
        keyboardType: keyboardType,
        textAlign: textAlign,

        buildCounter: counter,

        style:const TextStyle(

          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'JosefinSans',
          letterSpacing: 0.8,
          fontStyle: FontStyle.normal,
          color: Color(0xff5d5d5d),
        ),
        decoration: InputDecoration(
          hintStyle:const TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            letterSpacing: 0.8,
            fontFamily: 'JosefinSans',
          ),
          prefixIcon: prefixIcon,
          filled: true,
          counterText: counterText,
          hintText: hintText,
          suffixIcon: suffixIcon,
      
          enabledBorder: OutlineInputBorder(
            borderSide:   BorderSide.none,
            //36325A
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:  BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide:  BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:  BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding:const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          fillColor: Colors.transparent,
          errorStyle: TextStyle(
            fontSize: 18,
            fontWeight: fontWeight,
            fontFamily: 'Lagarto',
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget counter(BuildContext context,
      {required int currentLength,
        required int? maxLength,
        required bool isFocused}) {
    if (isFocused && currentLength > 0) {
      return Text('$currentLength / $maxLength');
    } else {
      return const Text("");
    }
  }
}


class TextFieldDesignedOutline extends StatelessWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final IconButton? suffixIcon;
  final   prefixIcon;
  final Color? hintStyle;
  final String hintText;
  final String initialValue;
  final int? maxLength, minLines;
  final int maxLines;
  final bool readOnly;
  final bool obscureText;
  final TextInputType keyboardType;
  final AutovalidateMode? autovalidateMode;
  final FormFieldValidator<String>? validator;
  final GestureTapCallback? onTap;
  final TextAlign textAlign;
  final double fontSize;
  final FocusNode? focusNode;
  final FontWeight fontWeight;
    final String? counterText;
    final ValueChanged<String>? onChanged;
    final bool? enabled;

  const TextFieldDesignedOutline({super.key,
    this.inputFormatters,
    this.onTap,
    this.readOnly = false,
    this.obscureText = false,
    this.controller,
    this.hintStyle = Colors.white12,
    this.initialValue = "",
    this.suffixIcon,
    this.prefixIcon,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w300,
    this.autovalidateMode,
    this.hintText = "",
    this.maxLines = 1,
    this.minLines ,
    this.maxLength = 300,
    this.validator,
    this.focusNode,
    this.keyboardType = TextInputType.number,
    this.textAlign = TextAlign.start,
    this.counterText = "",
    this.onChanged,
    this.enabled,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppStyles.backgroundColor,

        border: Border.all(color: AppStyles.TextformfeildOutlineColor,width: 0.7 ),borderRadius: BorderRadius.circular(10),),
      child: TextFormField(
        enabled: enabled,
        focusNode: focusNode,
        autofocus: false,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        textAlignVertical: TextAlignVertical.center,
        obscureText: obscureText,
        cursorColor:const  Color(0xff0F0F0F),
        textCapitalization: TextCapitalization.sentences,
        readOnly: readOnly,
        autovalidateMode: autovalidateMode,
        validator: validator,
        onTap: onTap,
        controller: controller,
        maxLength: maxLength,
        maxLines: maxLines,
        minLines: minLines,
        keyboardType: keyboardType,
        textAlign: textAlign,


        buildCounter: counter,
        style:const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'JosefinSans',
          letterSpacing: 0.8,
          fontStyle: FontStyle.normal,
          color: Color(0xff5d5d5d),
        ),
        decoration: InputDecoration(
          hintStyle:const TextStyle(
            color:  Color(0xff5d5d5d),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            letterSpacing: 0.8,
            fontFamily: 'JosefinSans',
          ),
          prefixIcon: prefixIcon,
          filled: true,
          counterText: counterText,
          hintText: hintText,
          suffixIcon: suffixIcon,

          enabledBorder: OutlineInputBorder(
            borderSide:   BorderSide.none,
            //36325A
            borderRadius: BorderRadius.circular(10),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide:   BorderSide.none,
            //36325A
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:  BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide:  BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:  BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding:const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          fillColor: Colors.transparent,
          errorStyle: TextStyle(
            fontSize: 18,
            fontWeight: fontWeight,
            fontFamily: 'Lagarto',
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget counter(BuildContext context,
      {required int currentLength,
        required int? maxLength,
        required bool isFocused}) {
    if (isFocused && currentLength > 0) {
      return Text('$currentLength / $maxLength');
    } else {
      return const Text("");
    }
  }
}


class TextFieldDesignedforchatScreen extends StatelessWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final IconButton? suffixIcon;
  final  IconButton?  prefixIcon;
  final Color? hintStyle;
  final String hintText;
  final String initialValue;
  final int? maxLength, minLines;
  final int maxLines;
  final bool readOnly;
  final bool obscureText;
  final TextInputType keyboardType;
  final AutovalidateMode? autovalidateMode;
  final FormFieldValidator<String>? validator;
  final GestureTapCallback? onTap;
  final TextAlign textAlign;
  final double fontSize;
  final FocusNode? focusNode;
  final FontWeight fontWeight;
    final String? counterText;
    final ValueChanged<String>? onChanged;

  const TextFieldDesignedforchatScreen({super.key,
    this.inputFormatters,
    this.onTap,
    this.readOnly = false,
    this.obscureText = false,
    this.controller,
    this.hintStyle = Colors.white12,
    this.initialValue = "",
    this.suffixIcon,
    this.prefixIcon,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w300,
    this.autovalidateMode,
    this.hintText = "",
    this.maxLines = 1,
    this.minLines ,
    this.maxLength = 300,
    this.validator,
    this.focusNode,
    this.keyboardType = TextInputType.number,
    this.textAlign = TextAlign.start,
    this.counterText = "",
    this.onChanged,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: AppStyles.TextFormFieldBackgroundColor),
      child: TextFormField(
        focusNode: focusNode,
        autofocus: false,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        textAlignVertical: TextAlignVertical.center,
        obscureText: obscureText,
        cursorColor:const  Color(0xff0F0F0F),
        textCapitalization: TextCapitalization.sentences,
        readOnly: readOnly,
        autovalidateMode: autovalidateMode,
        validator: validator,
        onTap: onTap,
        controller: controller,
        maxLength: maxLength,
        maxLines: maxLines,
        minLines: minLines,
        keyboardType: keyboardType,
        textAlign: textAlign,


        buildCounter: counter,

        style:const TextStyle(

          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'JosefinSans',
          letterSpacing: 0.8,
          fontStyle: FontStyle.normal,
          color: Color(0xff5d5d5d),
        ),
        decoration: InputDecoration(
          hintStyle:const TextStyle(
            color:  Color(0xff5d5d5d),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            letterSpacing: 0.8,
            fontFamily: 'JosefinSans',
          ),
          prefixIcon: prefixIcon,
          filled: true,
          counterText: counterText,
          hintText: hintText,
          suffixIcon: suffixIcon,

          enabledBorder: OutlineInputBorder(
            borderSide:   BorderSide.none,
            //36325A
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:  BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide:  BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:  BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding:const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          fillColor: Colors.transparent,
          errorStyle: TextStyle(
            fontSize: 18,
            fontWeight: fontWeight,
            fontFamily: 'Lagarto',
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget counter(BuildContext context,
      {required int currentLength,
        required int? maxLength,
        required bool isFocused}) {
    if (isFocused && currentLength > 0) {
      return Text('$currentLength / $maxLength');
    } else {
      return const Text("");
    }
  }
}

