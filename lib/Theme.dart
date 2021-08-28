import 'package:flutter/material.dart';

class Style {
  static const Color primaryDark = Color(0xFF306628);
  static const Color primary800 = Color(0xFF4f8839);
  static const primary = Color(0xff74B04C);
  static const Color primary400 = Color(0xFF94c96d);
  static const Color primary100 = Color(0xFFd9ecca);
  static const Color primary50 = Color(0xFFf0f8ea);

  static const Color accent = Color(0xFF4D434B);
  static const Color accentDark = Color(0xFF2b2229);
  static const Color darkerText = Color(0xFF343434);
  static const Color darkText = Color(0xFF4B414B);
  static const Color lightText = Color(0xFF6C6C6C);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color prime900 = Color(0xff006d01);
  static const Color prime800 = Color(0xff1d9019);
  static const Color prime700 = Color(0xff39a424);
  static const Color prime600 = Color(0xff51b82e);
  static const Color prime500 = Color(0xff60c836);
  static const Color prime400 = Color(0xff7ad157);
  static const Color prime300 = Color(0xff94d977);
  static const Color prime200 = Color(0xffb4e49f);
  static const Color prime100 = Color(0xffd2efc5);
  static const Color prime50 = Color(0xffedf9e8);
  static const Color background = Color(0xffD9DBDA);
  static const String fontName = 'Poppins';

  static TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static final TextStyle title = TextStyle(
    // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText.withOpacity(0.87),
  );

  static const TextStyle subtitle = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    // body1 -> body2
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    // body2 -> body1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );
}
