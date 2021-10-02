import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:math';

const int TenentID = 14;
const String fcmToken = "";

Future<bool> onWillPop() async {
  return await Get.dialog(
    AlertDialog(
      title: Text(
        'you_sure'.tr,
        style: Style.subtitle.copyWith(
          color: Style.accent[700],
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      elevation: 16,
      actionsPadding: EdgeInsets.symmetric(
        horizontal: 8,
      ),
      content: Text(
        'exit_app'.tr,
        style: Style.subtitle.copyWith(
          color: Style.accent[500],
          fontSize: 14,
          letterSpacing: 0.4,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
            foregroundColor: MaterialStateProperty.all(Colors.black87),
          ),
          onPressed: () {
            Get.back(canPop: false);
            // Navigator.of(context).pop(false);
          },
          child: Text(
            'no'.tr,
            style: Style.subtitle.copyWith(
              color: Style.accent[700],
              fontSize: 16,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
            backgroundColor: MaterialStateProperty.all(Style.prime),
            foregroundColor: MaterialStateProperty.all(
              Colors.white,
            ),
          ),
          onPressed: () async {
            Get.back(canPop: true);
          },
          child: Text(
            'yes'.tr,
            style: Style.subtitle.copyWith(
              color: Style.white,
              fontSize: 16,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ),
  );
}

class Style {
  static final storage = GetStorage();

  static final temp = ''.obs;
  static final Rx<Color> tempr =
      Color(int.parse('0xFF' + storage.read('primary'))).obs;
  // static final tempr = Color(0xff74B04C).obs;
  // static const Color primaryDark  = Color(0xFF306628);
  // static const Color primary800   = Color(0xFF4f8839);
  // static const primary            = Color(0xff74B04C);
  // static const Color primary400   = Color(0xFF94c96d);
  // static const Color primary100   = Color(0xFFd9ecca);
  // static const Color primary50    = Color(0xFFf0f8ea);

  static final MaterialColor primaryDark = generateMaterialColor(tempr.value);
  static final MaterialColor prime =
      generateMaterialColor(Color(int.parse('0xFF' + storage.read('primary'))));
  static final MaterialColor accent =
      generateMaterialColor(Color(int.parse('0xFF' + storage.read('accent'))));
  // static final MaterialColor accent = generateMaterialColor()

  // static final Color primary800 = tempr.value;
  // static final Color primary = tempr.value;
  // static final Color primary400 = tempr.value;
  // static final Color primary100 = tempr.value;
  // static final Color primary50 = tempr.value;

  static const Color accentDark = Color(0xFF2b2229);
  static const Color darkerText = Color(0xFF343434);
  static const Color darkText = Color(0xFF4B414B);
  static const Color lightText = Color(0xFF6C6C6C);
  static const Color dark_grey = Color(0xFF313A44);

  static final colors = [
    Colors.brown[400],
    Colors.green[400],
    Colors.red[400],
    Colors.blue[400],
    Colors.deepPurple[400],
    Colors.orange[400],
    Colors.red[400],
    Colors.pink[400],
    Colors.deepOrange[400],
  ];

  // static const Color prime900 = Color(0xff006d01);
  // static const Color prime800 = Color(0xff1d9019);
  // static const Color prime700 = Color(0xff39a424);
  // static const Color prime600 = Color(0xff51b82e);
  // static const Color prime500 = Color(0xff60c836);
  // static const Color prime400 = Color(0xff7ad157);
  // static const Color prime300 = Color(0xff94d977);
  // static const Color prime200 = Color(0xffb4e49f);
  // static const Color prime100 = Color(0xffd2efc5);
  // static const Color prime50 = Color(0xffedf9e8);
  static const Color background = Color(0xffD9DBDA);
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);
  static const String fontName = 'Poppins';

  static InputDecoration inputTextDecoration({String title = ''}) {
    return InputDecoration(
      filled: true,
      fillColor: Style.accent[50]!.withOpacity(0.10),
      contentPadding: EdgeInsets.all(16),
      labelText: title,
      floatingLabelStyle: Style.caption.copyWith(
        color: Style.prime[900],
        letterSpacing: 0.4,
        fontSize: 14,
      ),
      labelStyle: Style.subtitle.copyWith(
        color: Style.accent[500],
        fontSize: 12,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        gapPadding: 4.0,
        borderSide: BorderSide(
          width: 0.6,
          color: Style.accent[700]!,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        gapPadding: 4.0,
        borderSide: BorderSide(
          width: 1.2,
          color: Colors.red,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        gapPadding: 4.0,
        borderSide: BorderSide(
          width: 0.8,
          color: Colors.red,
          // color: Style.accent[600]!,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        gapPadding: 4.0,
        borderSide: BorderSide(
          width: 1,
          color: Style.prime[900]!,
        ),
      ),
    );
  }

  //INVERT BLACK TO WHITE WHEN IT COMES TO COLOUR INVERSION OR THEME CHANGES.

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

  static MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(
      color.value,
      {
        50: tintColor(color, 0.5),
        100: tintColor(color, 0.4),
        200: tintColor(color, 0.3),
        300: tintColor(color, 0.2),
        400: tintColor(color, 0.1),
        500: tintColor(color, 0),
        600: tintColor(color, -0.1),
        700: tintColor(color, -0.2),
        800: tintColor(color, -0.3),
        900: tintColor(color, -0.4),
      },
    );
  }

  static int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);
}

class ColorUtil extends Color {
  static int getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  ColorUtil(final String hexColor) : super(getColorFromHex(hexColor));
}
