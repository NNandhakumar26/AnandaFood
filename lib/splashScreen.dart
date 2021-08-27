import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:subscription_mobile_app/HomePage.dart';

import 'Theme.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    getPage();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _visible = !_visible;
      });
    });
  }

  getPage() async {
    Timer(Duration(milliseconds: 2800), () {
      print('To Home page');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Homepage()));
      //use profile to go to desired section.
    });
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // if (prefs.get('custID') != null) {
    //   Timer(Duration(milliseconds: 2800), () {
    //     print('To Home page');
    //     Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => HomePage()));
    //     //use profile to go to desired section.
    //   });
    // } else {
    //   Timer(Duration(milliseconds: 2800), () {
    //     print('To Group page');
    //     Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => GroupPage()));
    //   });
    // }
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
                ),
              ),
            ),
            Positioned(
              top: Get.height / 3.5,
              child: Column(
                children: [
                  AnimatedOpacity(
                    opacity: _visible ? 0.0 : 1,
                    curve: Curves.easeIn,
                    duration: Duration(milliseconds: 1400),
                    child: Center(
                      child: Card(
                        elevation: 8.0,
                        shape: CircleBorder(side: BorderSide.none),
                        borderOnForeground: true,
                        shadowColor: Style.primary.withOpacity(0.2),
                        clipBehavior: Clip.antiAlias,
                        child: CircleAvatar(
                          maxRadius: 100.0,
                          child: Center(
                            child: Image(
                              image: AssetImage('assets/images/Logo.jpeg'),
                            ),
                          ),
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
                              // Shadow(
                              //   blurRadius: 0.08,
                              //   color: Style.primary,
                              //   offset: Offset(0.051, 0.51),
                              // ),
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
                                color: Style.accentDark,
                                offset: Offset(0.051, 0.51),
                              ),
                              Shadow(
                                blurRadius: 0.8,
                                color: Style.primary,
                                offset: Offset(0.1, 0.1),
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
                    style: Style.caption,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Copyright by SubCrb Kuwait 2021',
                    style: Style.caption,
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
