import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';

import '../Theme.dart';

class MainPageContainer extends StatelessWidget {
  const MainPageContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Style.prime[50]!.withOpacity(0.24),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        height: Get.height / 2,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: Get.height / 8,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: Get.width / 20,
                        ),
                        Text(
                          'Let\'s',
                          style: Style.subtitle.copyWith(
                            fontSize: 18,
                            letterSpacing: 0.8,
                            color: Style.accent[700],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        DefaultTextStyle(
                          style: Style.subtitle.copyWith(
                            color: Style.prime[700],
                            fontSize: 16.0,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w600,
                          ),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            isRepeatingAnimation: true,
                            animatedTexts: [
                              RotateAnimatedText(
                                'Eat',
                                transitionHeight: 50,
                                rotateOut: true,
                                textDirection: TextDirection.ltr,
                                duration: Duration(milliseconds: 1100),
                              ),
                              RotateAnimatedText(
                                'Delicious',
                                transitionHeight: 50,
                                rotateOut: true,
                                duration: Duration(milliseconds: 1100),
                              ),
                              RotateAnimatedText(
                                'Meals!!!',
                                transitionHeight: 50,
                                rotateOut: true,
                                duration: Duration(milliseconds: 1100),
                              ),
                              RotateAnimatedText(
                                'Order Now...',
                                transitionHeight: 50,
                                rotateOut: true,
                                duration: Duration(milliseconds: 1000),
                              ),
                            ],
                            onTap: () {
                              print("Tap Event");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Card(
                    elevation: 20,
                    shape: CircleBorder(side: BorderSide.none),
                    borderOnForeground: true,
                    shadowColor: Style.prime[50]!.withOpacity(0.32),
                    clipBehavior: Clip.antiAlias,
                    child: CircleAvatar(
                      maxRadius: 120.0,
                      backgroundColor: Style.prime[50]!.withOpacity(0.24),
                      child: Center(
                        child: Image(
                          image: AssetImage('assets/images/Food2.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Positioned(
            //   top: 300,
            //   right: 50,
            //   child: Container(
            //     // margin: EdgeInsets.only(right: 35),
            //     // padding: EdgeInsets.all(5),
            //     // color: Colors.yellow,
            //     height: 50,
            //     width: 50,
            //     child: Image(
            //       image: AssetImage('assets/images/Leaves.png'),
            //     ),
            //   ),
            // ),
            // Positioned(
            //   top: 100,
            //   right: 55,
            //   child: Container(
            //     height: 50,
            //     width: 50,
            //     child: Transform.rotate(
            //       angle: 45,
            //       child: Image(
            //         image: AssetImage('assets/images/Leaves.png'),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
