import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:subscription_mobile_app/HomePage.dart';
import 'Theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'groupPage.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _visible = true; // For Splash Screen Visibility

  @override
  void initState() {
    super.initState();
    getPage();
    Future.delayed(
      Duration(milliseconds: 500),
      () {
        setState(
          () {
            _visible = !_visible;
          },
        );
      },
    );
  }

  getPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.get('custID') != null) {
      Timer(
        Duration(milliseconds: 3200),
        () {
          Get.to(Homepage());
          //use profile to go to desired section.
        },
      );
    } else {
      Timer(
        Duration(milliseconds: 3200),
        () {
          Get.to(GroupPage());
        },
      );
    }
  }

  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.background,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: Get.height * 0.02,
              child: Opacity(
                opacity: 0.50,
                child: Lottie.asset(
                  'assets/json/Stars.json',
                  width: Get.width / 1.03,
                  repeat: true,
                  reverse: false,
                ),
              ),
            ),
            Positioned(
              top: Get.height / 3.5,
              child: Column(
                children: [
                  AnimatedOpacity(
                    opacity: _visible ? 0.0 : 1,
                    curve: Curves.bounceInOut,
                    duration: Duration(milliseconds: 1600),
                    child: Center(
                      child: Card(
                        elevation: 8,
                        shape: CircleBorder(side: BorderSide.none),
                        borderOnForeground: true,
                        // shadowColor: Style.primary.withOpacity(0.2),
                        shadowColor: Style.prime.withOpacity(0.2),
                        clipBehavior: Clip.antiAlias,
                        child: CircleAvatar(
                          maxRadius: 100.0,
                          foregroundImage:
                              AssetImage('assets/images/Logo.jpeg'),
                        ),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: _visible ? 0.0 : 1,
                    curve: Curves.easeInBack,
                    duration: Duration(milliseconds: 2400),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'كن بصحة جيدة',
                          style: Style.display1.copyWith(
                            fontSize: 22,
                            letterSpacing: 1.6,
                            shadows: [
                              Shadow(
                                blurRadius: 0.8,
                                color: Style.accent,
                                offset: Offset(0.051, 0.51),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Subscription App'.toUpperCase(),
                          style: Style.headline.copyWith(
                            fontSize: 24,
                            color: Style.darkerText.withOpacity(
                              0.87,
                            ),
                            letterSpacing: 1.6,
                            shadows: [
                              Shadow(
                                blurRadius: 0.8,
                                color: Style.accent[800]!,
                                offset: Offset(0.51, 0.851),
                              ),
                            ],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              child: Column(
                children: [
                  Text(
                    'Build 2.0.3\tDate: ${date.day}.${date.month}.${date.year}\tBy DE Kuwait',
                    textAlign: TextAlign.center,
                    style: Style.caption.copyWith(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Copyright by SubCrb Kuwait 2021',
                    style: Style.caption.copyWith(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
