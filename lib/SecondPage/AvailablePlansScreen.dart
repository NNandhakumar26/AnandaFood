import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:subscription_mobile_app/Theme.dart';

class PlansScreen extends StatelessWidget {
  final number = Random().nextInt(Style.colors.length);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F7FB),
      appBar: AppBar(
        backgroundColor: Style.white.withOpacity(0.87),
        centerTitle: true,
        title: Text('Plans Available'),
        titleTextStyle: Style.subtitle.copyWith(
          fontSize: 18,
          color: Style.accent[900],
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            CupertinoIcons.back,
            size: 18,
            color: Style.accent[400],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Container(
                height: Get.height,
                width: Get.width,
                child: ListView.builder(
                  itemCount: 5,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      height: Get.height / 3.2,
                      margin: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      // color: Style
                      //     .colors[Random().nextInt(Style.colors.length)]!
                      //     .withOpacity(0.32),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Style.accent[50]!, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Style.accent[50]!.withOpacity(0.60),
                            blurRadius: 8,
                            spreadRadius: 0.005,
                            offset: Offset(0, 0.5),
                          ),
                        ],
                      ),
                      width: Get.width,
                      //REMOVE THE CARD AND THE PADDING
                      // elevation: 2,

                      // shadowColor: Style.prime[50],
                      //Use the border with right side circular.. as in UI template application..
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.only(
                      //     topRight: Radius.circular(48),
                      //     bottomLeft: Radius.circular(8),
                      //     bottomRight: Radius.circular(8),
                      //     topLeft: Radius.circular(8),
                      //   ),
                      // ),

                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            top: Get.height / 4,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Style.accent,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'View More',
                                    style: Style.title.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      letterSpacing: 0.8,
                                      color: Style.white.withOpacity(0.87),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 8,
                                  // ),
                                  Icon(
                                    Icons.arrow_right_rounded,
                                    color: Colors.white.withOpacity(0.87),
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                            // child: TextButton(
                            //   style: TextButton.styleFrom(
                            //     elevation: 4,
                            //     backgroundColor: Style.accent,
                            //     // shape: RoundedRectangleBorder(
                            //     //     borderRadius: BorderRadius.circular(24)),
                            //     // padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                            //   ),
                            //   onPressed: () {},
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       Text(
                            //         'View More',
                            //         style: Style.title.copyWith(
                            //           fontWeight: FontWeight.w500,
                            //           fontSize: 12,
                            //           letterSpacing: 0.8,
                            //           color: Style.white.withOpacity(0.87),
                            //         ),
                            //       ),
                            //       // SizedBox(
                            //       //   width: 8,
                            //       // ),
                            //       Icon(
                            //         Icons.arrow_right_rounded,
                            //         color: Colors.white.withOpacity(0.87),
                            //         size: 16,
                            //       )
                            //       // IconData(0xf37f, fontFamily: 'MaterialIcons'),
                            //     ],
                            //   ),
                            // ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 16,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.all(14),
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color:
                                            Style.prime[50]!.withOpacity(0.32),
                                        // color: Style.colors[Random()
                                        //         .nextInt(Style.colors.length)]!
                                        //     .withOpacity(0.0832),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16),
                                        ),
                                      ),
                                      child: Image(
                                        image: AssetImage(
                                            'assets/images/muscle.png'),
                                        color: Style.accent[500],
                                        // color: Style.colors[Random()
                                        //         .nextInt(Style.colors.length)]!
                                        //     .withOpacity(0.87),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RichText(
                                          softWrap: true,
                                          text: TextSpan(
                                            text: 'Fitness Diet',
                                            style: Style.subtitle.copyWith(
                                              fontSize: 16,
                                              letterSpacing: 0.8,
                                              fontWeight: FontWeight.w600,
                                              color: Style.accent[800]!
                                                  .withOpacity(0.87),
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: ' 150 Gram 6 Meals',
                                                style: Style.subtitle.copyWith(
                                                  fontSize: 16,
                                                  letterSpacing: 0.8,
                                                  // wordSpacing: 0.8,
                                                  fontWeight: FontWeight.w500,
                                                  color: Style.prime[800]!
                                                      .withOpacity(0.87),
                                                ),
                                              ),
                                              // TextSpan(text: ' \$ '),
                                            ],
                                          ),
                                        ),

                                        // child: Text(
                                        //   'Fitness Diet 150Gram 6 Meals',
                                        //   style: Style.subtitle.copyWith(
                                        //     fontSize: 16,
                                        //     //TODO: MAKE IT A RICH TEXT AND SHOW VARIATIONS USING COLOUR SCHEME.
                                        //     color: Style.accent[600],
                                        //     fontWeight: FontWeight.w500,
                                        //   ),
                                        // ),
                                      ),
                                      Flexible(
                                        //TODO: MAKE IT FIXED HEIGHT SO THAT IT WILL NOT OVERFLOW
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 6),
                                          child: GridView(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 4.2,
                                            ),
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            children: List<Widget>.generate(
                                              5,
                                              (int i) {
                                                return Builder(
                                                  builder:
                                                      (BuildContext context) {
                                                    return Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Container(
                                                          width: Get.width / 52,
                                                          height:
                                                              Get.height / 52,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Style
                                                                .colors[Random()
                                                                    .nextInt(Style
                                                                        .colors
                                                                        .length)]!
                                                                .withOpacity(
                                                                    0.60),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                        Text(
                                                          'BreakFast',
                                                          style: Style.caption
                                                              .copyWith(
                                                            color: Style
                                                                .accent[400],
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            letterSpacing: 0.8,
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.end,
                                      //   children: [

                                      //     SizedBox(
                                      //       width: 4,
                                      //     ),
                                      //     Icon(
                                      //       Icons.arrow_right_alt_outlined,
                                      //       color: Style.accent[500],
                                      //       size: 16,
                                      //     )
                                      //   ],
                                      // )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
