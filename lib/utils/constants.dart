import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:device_info/device_info.dart';
// import 'package:flutter/painting.dart';

class ColorConstant {
  static final primaryColor = Color(0xffd9e6fa);
  static const green = Colors.green;
  static const red = Colors.red;
  static const amberAccent = Colors.amberAccent;
}

class FontTheme {
  TextTheme primaryFont = TextTheme(
    headline1: TextStyle(fontSize: 96, color: Color(0xff2f3033)),
    headline2: TextStyle(fontSize: 60, color: Color(0xff2f3033)),
    headline3: TextStyle(fontSize: 48, color: Color(0xff2f3033)),
    headline4: TextStyle(fontSize: 34, color: Color(0xff2f3033)),
    headline5: TextStyle(fontSize: 24, color: Color(0xff2f3033)),
    headline6: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xff2f3033)),
    subtitle1: TextStyle(fontSize: 16, color: Color(0xff2f3033)),
    subtitle2: TextStyle(fontSize: 14, color: Color(0xff2f3033)),
    bodyText1: TextStyle(fontSize: 16, color: Color(0xff2f3033)),
    bodyText2: TextStyle(fontSize: 14, color: Color(0xff2f3033)),
    button: TextStyle(fontSize: 14, color: Color(0xff2f3033)),
    caption: TextStyle(fontSize: 12, color: Color(0xff2f3033)),
    overline: TextStyle(fontSize: 10, color: Color(0xff2f3033)),
    // 0xff2f3033
  );
}

class ImagesConstant {
  String logo = 'assets/images/logo.png';
}
