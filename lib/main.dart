import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subscription_mobile_app/Theme.dart';
import 'package:subscription_mobile_app/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mobile Subscription App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Style.primary,
        accentColor: Style.accent,
        textTheme: Style.textTheme,
      ),
      home: Splash(),
    );
  }
}
