import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants.dart';

class CustomTextFormField extends StatelessWidget {
  final controller;
  final focusNode;
  final suffixIcon;
  final bool enabled;
  final onChanged;
  final initialValue;
  final keyboardType;
  final textInputAction;
  final onFieldSubmitted;
  final String labelText;
  final validator;
  final double cursorWidth;
  final TextCapitalization textCapitalization;

  CustomTextFormField({
    this.controller,
    this.focusNode,
    this.suffixIcon,
    this.enabled,
    this.onChanged,
    this.initialValue,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.labelText,
    this.validator,
    this.cursorWidth,
    this.textCapitalization,
  });

  final primaryColor = ColorConstant.primaryColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // inputFormatters: [ThousandsFormatter(allowFraction: true)],
      enabled: enabled ?? true,
      cursorWidth: cursorWidth ?? 1,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      onChanged: onChanged,
      initialValue: initialValue,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 5.w),
        hintStyle: TextStyle(
          color: primaryColor,
        ),
        labelStyle: TextStyle(
          color: Color(0xff2f3033),
        ),
        labelText: labelText,
        // fillColor: Colors.grey.withOpacity(.25),
        // filled: true,
        /* enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black26),
          borderRadius: BorderRadius.circular(30),
        ), */
        /* border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ), */
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue[900], width: 1.0)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue, width: 1.0)),
        suffixIcon: suffixIcon,
      ),
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
    );
  }
}
