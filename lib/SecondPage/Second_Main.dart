import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../Theme.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Style.prime[50]!.withOpacity(0.04),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 8,
                  left: 6,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Your Existing Plans',
                      style: Style.headline.copyWith(
                        letterSpacing: 0.4,
                        fontWeight: FontWeight.w500,
                        //TODO: Check the font color
                        color: Style.accent[900],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Choose More Plans',
                      style: Style.body2.copyWith(
                        color: Style.prime.withOpacity(0.87),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Container(
                  child: Column(
                    children: [
                      TabBar(
                        unselectedLabelStyle: Style.subtitle.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Style.accent[400]!.withOpacity(0.60),
                        ),
                        labelStyle: Style.title.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Style.accent[800]!.withOpacity(0.87),
                        ),
                        indicatorColor: Style.prime[300],
                        indicatorPadding: EdgeInsets.all(8),
                        labelPadding: EdgeInsets.all(8),
                        indicatorWeight: 1.6,
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: [
                          Text(
                            'Basic',
                            textAlign: TextAlign.left,
                          ),
                          Text('Customized'),
                        ],
                      ),
                      Container(
                        height: Get.height,
                        width: Get.width,
                        margin: EdgeInsets.symmetric(vertical: 16),
                        child: TabBarView(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  PlansContainer(
                                    title: 'Body Building ',
                                    grams: '200 Grams',
                                    price: '24',
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  PlansContainer(
                                    title: 'Fitness Diet ',
                                    grams: '150 Grams',
                                    price: '32',
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  PlansContainer(
                                    title: 'Easy Slimming Diet ',
                                    grams: '100 Grams',
                                    price: '64',
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  PlansContainer(
                                    title: 'Subscription Apps\'s ',
                                    grams: 'Custom Plan',
                                    price: '54',
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  PlansContainer(
                                    title: 'Body Building ',
                                    grams: '200 Gms',
                                    price: '40',
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  PlansContainer(
                                    title: 'Fitness Diet ',
                                    grams: '150 Gms',
                                    price: '23',
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  PlansContainer(
                                    title: 'Easy Slimming Diet ',
                                    grams: '100 Gms',
                                    price: '30',
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlansContainer extends StatelessWidget {
  final title;
  final grams;
  final price;
  PlansContainer({this.title, this.grams, this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 4.5,
      // color: Style.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: Get.width / 6,
            child: Container(
              width: Get.width / 1.4,
              padding: EdgeInsets.only(left: 50, top: 24, bottom: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Style.accent[50]!.withOpacity(0.60),
                    blurRadius: 8,
                    // spreadRadius: 0.005,
                    offset: Offset(0, 0.5),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  bottomLeft: Radius.circular(60),
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
                border: Border.all(
                  width: 0.3,
                  color: Style.accent,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 8),
                    child: RichText(
                      softWrap: true,
                      text: TextSpan(
                        text: title,
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w600,
                          color: Style.accent[800]!.withOpacity(0.87),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: grams,
                            style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.8,
                              // wordSpacing: 0.8,
                              fontWeight: FontWeight.w500,
                              color: Style.prime[800]!.withOpacity(0.87),
                            ),
                          ),
                          // TextSpan(text: ' \$ '),
                        ],
                      ),
                    ),
                  ),
                  // Text(
                  //   'Easy Slimming Diet 100 Gms',
                  //   textAlign: TextAlign.left,
                  //   overflow: TextOverflow.clip,
                  //   softWrap: true,
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     letterSpacing: 0.8,
                  //     // wordSpacing: 0.8,
                  //     fontWeight: FontWeight.w500,
                  //     color: Style.accent[800]!.withOpacity(0.87),
                  //   ),
                  // ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Your diet is like a bank account',
                    style: Style.caption.copyWith(
                      color: Style.prime[400]!.withOpacity(0.60),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Plan Starts from',
                      style: Style.subtitle.copyWith(
                        color: Style.accent[200],
                        fontWeight: FontWeight.w500,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: '  \$ '),
                        TextSpan(
                          text: price,
                          style: Style.title.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Style.prime,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: Get.width / 140,
            child: Card(
              shape: CircleBorder(side: BorderSide.none),
              borderOnForeground: true,
              // shadowColor: Style.primary.withOpacity(0.2),
              shadowColor: Style.prime.withOpacity(0.2),
              clipBehavior: Clip.antiAlias,
              elevation: 18,
              child: CircleAvatar(
                foregroundColor: Style.accent[900],
                backgroundColor: Style.prime[50]!.withOpacity(0.098),
                radius: 48,
                foregroundImage: AssetImage('assets/images/Pizza2.jpg'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
