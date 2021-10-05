import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subscription_mobile_app/SecondPage/MealsAvailableScreen.dart';
import 'package:subscription_mobile_app/Theme.dart';
import 'package:subscription_mobile_app/database/dbhelper.dart';

import 'dashboard_items_dbprovider.dart';

class PlansAvailableScreen extends StatefulWidget {
  final int id;
  final String groupName;

  PlansAvailableScreen({
    required this.id,
    required this.groupName,
  });

  @override
  State<PlansAvailableScreen> createState() => _PlansAvailableScreenState();
}

class _PlansAvailableScreenState extends State<PlansAvailableScreen> {
  final number = Random().nextInt(Style.colors.length);
  List<Plan> plans = [];
  Map<String, String> images = {
    'Building': 'muscle.png',
    'Diet': 'diet (2).png',
    'Slimming': 'diet (1).png',
    'Healthy': 'Soup.png',
    'Ramadan': 'dish.png'
  };

  @override
  void initState() {
    super.initState();
    filteredData();
  }

  getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F7FB),
        appBar: AppBar(
          backgroundColor: Style.white.withOpacity(0.87),
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'الخطط',
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                'plan_available'.tr,
              ),
            ],
          ),
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
        body: Container(
          height: Get.height,
          width: Get.width,
          child: (plans.length != 0)
              ? ListView.builder(
                  itemCount: plans.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CustomContainer(
                      image: images[plans[index].imageName]!,
                      title: plans[index].planName!,
                      desc: plans[index].planDetails!,
                      onTap: () {
                        Get.to(
                          MealsAvailableScreen(
                            planName: plans[index].planName,
                            planId: plans[index].planID,
                            id: widget.id,
                            groupName: widget.groupName,
                          ),
                        );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => MealsAvailableScreen(
                        //       planName: plans[index].planName,
                        //       id: widget.id,
                        //       groupName: widget.groupName,
                        //       planId: plans[index].planID,
                        //     ),
                        //   ),
                        // );
                      },
                    );
                  },
                )
              : Center(
                  child: Text('data'),
                ),
        ),
      ),
    );
  }

  filteredData() async {
    final dbHelper = DatabaseHelper.instance;
    var rowsFuture = await dbHelper.selectPlanMeal();
    // List filtered = [];
    var groupId = widget.id;
    print('The rows future is $rowsFuture');

    try {
      List filtered = rowsFuture
          .where((element) => element['GroupID'] == groupId.toString())
          .toList();
      for (var items in filtered) {
        var imageName = (items['GroupName'] as String).split(' ').length > 1
            ? (items['GroupName'] as String).split(' ')[1]
            : (items['GroupName'] as String).split(' ')[0];
        var planDesc =
            items['plandesc'] == null ? "No Description" : items['plandesc'];
        var switch3 = items['switch3'];
        var planId = items['planid'];
        var plan = Plan(
            imageName: imageName,
            planName: planDesc,
            planDetails: switch3,
            planID: planId);
        setState(
          () {
            plans.add(plan);
          },
        );
      }

      print('The plans are $plans');
      // rowsFuture.then(
      //   (dataList) {
      //     List filtered = dataList
      //         .where((element) => element['GroupID'] == groupId.toString())
      //         .toList();
      //     for (var items in filtered) {
      //       var imageName = (items['GroupName'] as String).split(' ').length > 1
      //           ? (items['GroupName'] as String).split(' ')[1]
      //           : (items['GroupName'] as String).split(' ')[0];
      //       var planDesc = items['plandesc'] == null
      //           ? "No Description"
      //           : items['plandesc'];
      //       var switch3 = items['switch3'];
      //       var planId = items['planid'];
      //       var plan = Plan(
      //           imageName: imageName,
      //           planName: planDesc,
      //           planDetails: switch3,
      //           planID: planId);
      //       setState(
      //         () {
      //           plans.add(plan);
      //         },
      //       );
      //     }
      //   },
      // );

    } catch (e) {
      print(e.toString());
    }
  }

  _deleteData() async {
    setState(() {
      // isLoading = true;
    });

    await DBProvider.db.deleteAllPackages();

    // wait for 1 second to simulate loading of data
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      // isLoading = false;
    });

    print('All data deleted');
  }
}

class CustomContainer extends StatelessWidget {
  final String image;
  final String title;
  final String desc;
  final Function onTap;

  CustomContainer({
    required this.image,
    required this.title,
    required this.desc,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var temp = desc.split(', ');

    return Container(
      height: Get.height / 3.16,
      margin: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Style.accent[50]!, width: 0.4),
        // borderRadius: BorderRadius.all(Radius.circular(4)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Style.accent[50]!.withOpacity(0.32),
            blurRadius: 20,
            spreadRadius: 0.5,
            offset: Offset(0.8, 0.5),
          ),
        ],
      ),
      width: Get.width,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            top: Get.height / 4,
            right: 0,
            child: InkWell(
              onTap: () {
                return onTap();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Style.accent[700]!.withOpacity(0.87),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'View More',
                      style: Style.title.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        letterSpacing: 1.2,
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
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16,
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
                        color: Style.prime[50]!.withOpacity(0.16),
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: Image(
                        image: AssetImage('assets/images/$image'),
                        color: Style.prime[900],
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
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                  // text: ' 150 Gram 6 Meals',
                                  text: '',
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
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: GridView(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 4.2,
                            ),
                            physics: NeverScrollableScrollPhysics(),
                            children: List<Widget>.generate(
                              temp.length,
                              (int i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: Get.width / 52,
                                          height: Get.height / 52,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 4),
                                          decoration: BoxDecoration(
                                              color: Style.colors[Random()
                                                      .nextInt(
                                                          Style.colors.length)]!
                                                  .withOpacity(0.87),
                                              // color: Style.prime[900],
                                              shape: BoxShape.circle),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2),
                                          child: Text(
                                            temp[i],
                                            textAlign: TextAlign.left,
                                            style: Style.caption.copyWith(
                                              color: Style.accent[400],
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.8,
                                            ),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Plan {
  String? planName;
  String? planDetails;
  String? imageName;
  int? planID;

  Plan({
    this.planName,
    this.planDetails,
    this.imageName,
    this.planID,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Plan &&
          runtimeType == other.runtimeType &&
          planName == other.planName &&
          planDetails == other.planDetails;

  @override
  int get hashCode => planName.hashCode ^ planDetails.hashCode;
}
