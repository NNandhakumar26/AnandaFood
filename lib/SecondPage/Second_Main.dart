import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subscription_mobile_app/CustomPlan.dart';
import '../Theme.dart';
import '../groupPage.dart';
import 'AvailablePlansScreen.dart';

class SecondPage extends StatelessWidget {
  final Map<String, List<Group>> groups;
  final Map<String, String> images = {
    'Building': 'muscle.png',
    'Diet': 'diet (2).png',
    'Slimming': 'diet (1).png',
    'Healthy': 'Soup.png',
    'Ramadan': 'dish.png'
  };
  final bool isLoggedIn;

  SecondPage({required this.groups, this.isLoggedIn = false});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Style.prime[50]!.withOpacity(0.016),
        child: Column(
          children: [
            SizedBox(
              height: Get.height / 16,
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
                    style: Style.subtitle.copyWith(
                      letterSpacing: 0.4,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Style.accent[900],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Choose More Plans',
                    style: Style.body2.copyWith(
                      color: Style.prime[300],
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
              child: Column(
                children: [
                  TabBar(
                    unselectedLabelStyle: Style.subtitle.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                    labelStyle: Style.subtitle.copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.6,
                    ),
                    labelColor: Style.prime[800],
                    unselectedLabelColor: Style.accent[400],
                    indicatorColor: Style.prime[50],
                    labelPadding: EdgeInsets.all(8),
                    indicatorWeight: 2.4,
                    tabs: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                        width: Get.width,
                        child: Text(
                          'Basic',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                        width: Get.width,
                        child: Text(
                          'Customized',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: Get.height / 1.5,
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: TabBarView(
                      children: [
                        Container(
                          child: (groups['active']!.length == 0)
                              ? Container(
                                  child: Center(
                                    child: Text(
                                      'empty'.tr,
                                      style: Style.subtitle.copyWith(
                                        color: Style.prime[900],
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: groups['active']!.length,
                                  itemBuilder: (context, index) {
                                    print(groups);
                                    return PlansContainer(
                                      title: groups['active']![index].groupName,
                                      // grams: '200 Grams',
                                      // price: '24',
                                      // first: true,
                                      image: images[(groups['active']![index]
                                                  .groupName!
                                                  .split(" ")
                                                  .length >
                                              1)
                                          ? groups['active']![index]
                                              .groupName!
                                              .split(" ")[1]
                                          : groups['active']![index]
                                              .groupName!
                                              .split(" ")[0]],
                                      onTap: () async {
                                        if (isLoggedIn) {
                                          var groupId =
                                              groups['active']![index].groupId;
                                          var groupName =
                                              groups['active']![index]
                                                  .groupName;
                                          var preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          preferences.setInt('id', groupId!);
                                          preferences.setString(
                                              'planTitle', groupName!);
                                          return Get.to(
                                            () => PlansAvailableScreen(
                                                id: groupId,
                                                groupName: groupName),
                                          );
                                        } else
                                          return Get.to(
                                            PlansAvailableScreen(
                                              id: groups['active']![index]
                                                  .groupId!,
                                              groupName:
                                                  groups['active']![index]
                                                      .groupName
                                                      .toString(),
                                            ),
                                          );
                                      },
                                    );
                                  },
                                ),
                        ),
                        // SingleChildScrollView(
                        //   physics: BouncingScrollPhysics(),
                        //   child: Column(
                        //     children: groups['active']!.map(
                        //       (e) {
                        //         return PlansContainer(
                        //           title: e.groupName,
                        //           grams: '200 Grams',
                        //           price: '24',
                        //           first: true,
                        //         );
                        //       },
                        //     ).toList(),
                        //     // children: [
                        //     //   PlansContainer(
                        //     //     title: 'Body Building ',
                        //     //     grams: '200 Grams',
                        //     //     price: '24',
                        //     //     first: true,
                        //     //   ),
                        //     //   PlansContainer(
                        //     //     title: 'Fitness Diet ',
                        //     //     grams: '150 Grams',
                        //     //     price: '32',
                        //     //     first: true,
                        //     //   ),
                        //     //   PlansContainer(
                        //     //     title: 'Easy Slimming Diet ',
                        //     //     grams: '100 Grams',
                        //     //     price: '64',
                        //     //     first: true,
                        //     //   ),
                        //     // ],
                        //   ),
                        // ),
                        Container(
                          child: (groups['inActive']!.length == 0)
                              ? Container(
                                  child: Center(
                                    child: Text(
                                      'empty'.tr,
                                      style: Style.subtitle.copyWith(
                                        color: Style.prime[900],
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: groups['inActive']!.length,
                                  itemBuilder: (context, index) {
                                    return PlansContainer(
                                      title:
                                          groups['inActive']![index].groupName,
                                      image: images[(groups['inActive']![index]
                                                  .groupName!
                                                  .split(" ")
                                                  .length >
                                              1)
                                          ? groups['inActive']![index]
                                              .groupName!
                                              .split(" ")[1]
                                          : groups['inActive']![index]
                                              .groupName!
                                              .split(" ")[0]],
                                      onTap: () async {
                                        if (isLoggedIn) {
                                          var groupId =
                                              groups['inActive']![index]
                                                  .groupId;
                                          var groupName =
                                              groups['inActive']![index]
                                                  .groupName;
                                          var preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          preferences.setInt('id', groupId!);
                                          preferences.setString(
                                              'planTitle', groupName!);
                                          //CustomisePlan(
                                          // groupId: groupId, groupName: groupName),
                                          Get.to(
                                            CustomisePlan(
                                              groupId: groupId,
                                              groupName: groupName,
                                            ),
                                          );
                                        } else
                                          return Get.dialog(
                                            AlertDialog(
                                              title: Text('coming_soon'.tr),
                                              content:
                                                  Text('coming_message'.tr),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Get.back(),
                                                  child: Text('ok'.tr),
                                                )
                                              ],
                                            ),
                                          );
                                      },
                                    );
                                  },
                                ),
                          // child: SingleChildScrollView(
                          //   physics: BouncingScrollPhysics(),
                          //   child: Column(
                          //     children: groups['inActive']!.map(
                          //       (e) {
                          //         return PlansContainer(
                          //           title: e.groupName,
                          //           grams: '200 Grams',
                          //           price: '24',
                          //           first: false,
                          //         );
                          //       },
                          //     ).toList(),
                          //     // PlansContainer(
                          //     //   title: 'Subscription Apps\'s ',
                          //     //   grams: 'Custom Plan',
                          //     //   price: '54',
                          //     //   first: false,
                          //     // ),
                          //     // PlansContainer(
                          //     //   title: 'Body Building ',
                          //     //   grams: '200 Gms',
                          //     //   price: '40',
                          //     //   first: false,
                          //     // ),
                          //     // PlansContainer(
                          //     //   title: 'Fitness Diet ',
                          //     //   grams: '150 Gms',
                          //     //   price: '23',
                          //     //   first: false,
                          //     // ),
                          //     // PlansContainer(
                          //     //   title: 'Easy Slimming Diet ',
                          //     //   grams: '100 Gms',
                          //     //   price: '30',
                          //     //   first: false,
                          //     // )
                          //   ),
                          // ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
    );
  }
}

class PlansContainer extends StatelessWidget {
  final title;
  final grams;
  final price;
  final first;
  final String? image;
  final Function? onTap;
  PlansContainer({
    this.title,
    this.grams,
    this.price,
    this.first,
    this.image = 'Dinner.png',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        onTap!();
        // if (first) {
        //   onTap!();
        // } else {
        //   var preferences = await SharedPreferences.getInstance();
        //   if (preferences.get('custId') != null) {
        //     Get.to(CustomMealPage());
        //   } else {
        //     //Display the coming soon screen.
        //   }
        // }
      },
      child: Container(
        height: Get.height / 4.5,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: Get.width / 6,
              child: Container(
                width: Get.width / 1.4,
                padding: EdgeInsets.only(
                  left: Get.width / 6,
                  top: 24,
                  bottom: 24,
                  right: Get.width / 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Style.accent[50]!.withOpacity(0.60),
                      blurRadius: 8,
                      spreadRadius: 0.005,
                      offset: Offset(0, 0.5),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                    bottomLeft: Radius.circular(80),
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
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
                      //MAKE THIS A COMMON FIELD
                      child: RichText(
                        softWrap: true,
                        text: TextSpan(
                          text: title,
                          style: Style.subtitle.copyWith(
                            fontSize: 16,
                            letterSpacing: 0.8,
                            fontWeight: FontWeight.w600,
                            color: Style.accent[800]!.withOpacity(0.87),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: grams,
                              style: Style.subtitle.copyWith(
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

                    SizedBox(
                      height: 10,
                    ),
                    //MAKE THIS A COMMON FIELD
                    RichText(
                      text: TextSpan(
                        text: 'Plan Starts from',
                        style: Style.subtitle.copyWith(
                          color: Style.accent[200],
                          fontSize: 12,
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
                shadowColor: Style.prime[900]!.withOpacity(0.32),
                clipBehavior: Clip.antiAlias,
                elevation: 20,
                child: CircleAvatar(
                  foregroundColor: Style.accent[900],
                  backgroundColor: Style.prime[50]!.withOpacity(0.098),
                  radius: 48,
                  // foregroundImage: AssetImage('assets/images/$image'),
                  child: Image(
                    image: AssetImage('assets/images/$image'),
                    color: Style.prime[900],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
