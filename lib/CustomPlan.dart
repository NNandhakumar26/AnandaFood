import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subscription_mobile_app/Theme.dart';
import 'package:subscription_mobile_app/database/dbhelper.dart';
import 'Services/Constants.dart';
import 'basicplan.dart';

class CustomisePlan extends StatefulWidget {
  final groupId;
  final groupName;
  CustomisePlan({this.groupId, this.groupName});
  @override
  _CustomisePlanState createState() => _CustomisePlanState();
}

class _CustomisePlanState extends State<CustomisePlan> {
  String? planTitle;
  final dataBaseHelper = DatabaseHelper.instance;
  List<MealClass> meals = [];
  List<PlanDaysClass> planClassDays = [];
  List<PlanGramsClass> planGrams = [];
  Map<String, String> foodNames = {
    '1401': 'BreakFast',
    '1402': 'Lunch',
    '1403': 'Dinner',
    '1404': 'Snack',
    '1405': 'Salad',
    '1406': 'Soup'
  };

  @override
  void initState() {
    super.initState();
    getDifferentMeals();
    getPlanDaysAndGrams();
    // check();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () async => true,
          child: Container(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                // Stack(
                //   alignment: AlignmentDirectional.topCenter,
                //   children: [
                //     // Image(
                //     //   image: AssetImage('assets/images/semi-circle.png'),
                //     // ),
                //     Positioned(
                //       top: 5,
                //       left: medq.width / 40,
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           IconButton(
                //             onPressed: () {
                //               Navigator.pop(context);
                //             },
                //             icon: Icon(
                //               Icons.arrow_back_ios,
                //               color: Colors.white,
                //             ),
                //           ),
                //           Text(
                //             'Meal Customisation'.tr,
                //             style: Style.subtitle.copyWith(
                //                 color: Colors.white,
                //                 fontSize: 15,
                //                 fontWeight: FontWeight.w600),
                //           ),
                //           Text(
                //             'تخصيص الخطة',
                //             style: Style.subtitle
                //                 .copyWith(fontSize: 19, color: Colors.white),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Row(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       SizedBox(width: 8),
                        //       Container(
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(20),
                        //           border: Border.all(color: Style.prime),
                        //         ),
                        //         height: 30,
                        //         width: 100,
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(5.0),
                        //           child: Text("Days",
                        //               style: TextStyle(
                        //                 color: Style.prime,
                        //               ),
                        //               textAlign: TextAlign.center),
                        //         ),
                        //       ),
                        //       SizedBox(width: 8),
                        //       Container(
                        //         height: 30,
                        //         width: MediaQuery.of(context).size.width - 120,
                        //         child: ListView.builder(
                        //             shrinkWrap: true,
                        //             physics: BouncingScrollPhysics(),
                        //             itemCount: planClassDays == null
                        //                 ? 0
                        //                 : planClassDays.length,
                        //             scrollDirection: Axis.horizontal,
                        //             itemBuilder: (context, index) {
                        //               return GestureDetector(
                        //                 onTap: () async {
                        //                   planClassDays.forEach((planDay) {
                        //                     planDay.isSelected = false;
                        //                   });
                        //                   setState(() {
                        //                     planClassDays[index].isSelected = true;
                        //                   });
                        //                   var preferences =
                        //                       await SharedPreferences.getInstance();
                        //                   preferences.setInt('planDays',
                        //                       planClassDays[index].noOfDays);
                        //                 },
                        //                 child: Container(
                        //                     decoration: BoxDecoration(
                        //                         borderRadius:
                        //                             BorderRadius.circular(20),
                        //                         color: planClassDays == null
                        //                             ? BeHealthyTheme.kLightOrange
                        //                             : planClassDays[index]
                        //                                     .isSelected
                        //                                 ? BeHealthyTheme.kMainOrange
                        //                                 : BeHealthyTheme
                        //                                     .kLightOrange),
                        //                     height: 30,
                        //                     width: 100,
                        //                     child: Padding(
                        //                       padding: const EdgeInsets.fromLTRB(
                        //                           16, 5, 16, 5),
                        //                       child: Text(
                        //                         planClassDays == null
                        //                             ? ""
                        //                             : "${planClassDays[index].noOfDays} day(s)",
                        //                         style: TextStyle(
                        //                             color: planClassDays == null
                        //                                 ? BeHealthyTheme
                        //                                     .kLightOrange
                        //                                 : planClassDays[index]
                        //                                         .isSelected
                        //                                     ? Colors.white
                        //                                     : BeHealthyTheme
                        //                                         .kMainOrange),
                        //                         textAlign: TextAlign.center,
                        //                       ),
                        //                     )),
                        //               );
                        //             }),
                        //       )
                        //     ]),

                        SizedBox(height: 10),
                        // Row(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       SizedBox(width: 8),
                        //       Container(
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(20),
                        //           border:
                        //               Border.all(color: BeHealthyTheme.kMainOrange),
                        //         ),
                        //         height: 30,
                        //         width: 100,
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(5.0),
                        //           child: Text("Weight",
                        //               style: TextStyle(
                        //                 color: BeHealthyTheme.kMainOrange,
                        //               ),
                        //               textAlign: TextAlign.center),
                        //         ),
                        //       ),
                        //       SizedBox(width: 8),
                        //       Container(
                        //         height: 30,
                        //         width: MediaQuery.of(context).size.width - 120,
                        //         child: ListView.builder(
                        //             shrinkWrap: true,
                        //             physics: BouncingScrollPhysics(),
                        //             itemCount:
                        //                 planGrams == null ? 0 : planGrams.length,
                        //             scrollDirection: Axis.horizontal,
                        //             itemBuilder: (context, index) {
                        //               return GestureDetector(
                        //                 onTap: () async {
                        //                   planGrams.forEach((planGram) {
                        //                     planGram.isSelected = false;
                        //                   });
                        //                   setState(() {
                        //                     planGrams[index].isSelected = true;
                        //                   });
                        //                   var preferences =
                        //                       await SharedPreferences.getInstance();
                        //                   preferences.setInt('mealInGram',
                        //                       planGrams[index].gramsOfPlan);
                        //                 },
                        //                 child: Container(
                        //                     decoration: BoxDecoration(
                        //                         borderRadius:
                        //                             BorderRadius.circular(20),
                        //                         color: planGrams == null
                        //                             ? BeHealthyTheme.kLightOrange
                        //                             : planGrams[index].isSelected
                        //                                 ? BeHealthyTheme.kMainOrange
                        //                                 : BeHealthyTheme
                        //                                     .kLightOrange),
                        //                     height: 30,
                        //                     width: 100,
                        //                     child: Padding(
                        //                       padding: const EdgeInsets.fromLTRB(
                        //                           16, 5, 16, 5),
                        //                       child: Text(
                        //                         planGrams == null
                        //                             ? ""
                        //                             : "${planGrams[index].gramsOfPlan} g",
                        //                         style: TextStyle(
                        //                             color: planGrams == null
                        //                                 ? BeHealthyTheme
                        //                                     .kLightOrange
                        //                                 : planGrams[index]
                        //                                         .isSelected
                        //                                     ? Colors.white
                        //                                     : BeHealthyTheme
                        //                                         .kMainOrange),
                        //                         textAlign: TextAlign.center,
                        //                       ),
                        //                     )),
                        //               );
                        //             }),
                        //       )
                        //     ]),

                        SizedBox(height: 10),
                        Container(
                          height: 600,
                          width: 1500,
                          child: ListView.separated(
                            separatorBuilder: (context, int) => Divider(
                              indent: 24,
                              endIndent: 24,
                              thickness: 0.16,
                              color: Style.accent[50],
                            ),
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: meals == null ? 0 : meals.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  minVerticalPadding: 4,
                                  // minLeadingWidth: Get.width / 24,
                                  leading: CircleAvatar(
                                    maxRadius: 48.0,
                                    foregroundColor: Colors.red,
                                    backgroundColor:
                                        Style.prime[50]!.withOpacity(0.08),
                                    child: Center(
                                      child: Image(
                                        image: AssetImage(
                                            'assets/images/card.png'),
                                        fit: BoxFit.fill,
                                        color: Style.prime[900],
                                      ),
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (meals[index].quantity < 20) {
                                            setState(
                                              () {
                                                meals[index].quantity =
                                                    meals[index].quantity + 1;
                                              },
                                            );
                                            getTotalAmount();
                                          }
                                        },
                                        color: Style.prime.withOpacity(0.87),
                                        icon: Icon(
                                          Icons.add,
                                          color: Style.prime[700]!
                                              .withOpacity(0.87),
                                          size: 20,
                                        ),
                                      ),
                                      Text(
                                        "${meals[index].quantity}",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          if (meals[index].quantity > 0) {
                                            setState(
                                              () {
                                                meals[index].quantity =
                                                    meals[index].quantity - 1;
                                              },
                                            );
                                            getTotalAmount();
                                          }
                                        },
                                        icon: Icon(
                                          Icons.remove,
                                          color: Style.accent[300]!
                                              .withOpacity(0.87),
                                          size: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  title: Container(
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      meals[index].mealName,
                                      style: Style.subtitle.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Style.accent,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ),
                                  subtitle: RichText(
                                    text: TextSpan(
                                      text: 'Amount',
                                      style: Style.subtitle.copyWith(
                                        fontSize: 12,
                                        color: Style.accent[50],
                                        fontWeight: FontWeight.w600,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: ' : ',
                                        ),
                                        TextSpan(
                                          text:
                                              "${meals[index].itemExtraCost * meals[index].quantity}",
                                          style: Style.title.copyWith(
                                            color: Style.prime[700],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' kd',
                                          //also go with caption.
                                          style: Style.subtitle.copyWith(
                                            color: Style.prime[200],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  dense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 8),
                                ),
                              );
                            },
                          ),
                        ),

                        // return Column(
                        //   children: [
                        //     Container(
                        //       // decoration: BoxDecoration(
                        //       //   borderRadius: BorderRadius.circular(20),
                        //       //   color: BeHealthyTheme.kMainOrange
                        //       //       .withOpacity(0.1),
                        //       // ),
                        //       height: 80,
                        //       width: Get.width - 20,
                        //       child: Column(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           ,))}))

                        //                 // Padding(
                        //                 //   padding: const EdgeInsets.fromLTRB(
                        //                 //       16, 5, 16, 5),
                        //                 //   child: Row(
                        //                 //     children: [
                        //                 //       Image.asset(
                        //                 //         'assets/images/card.png',
                        //                 //         height: 25,
                        //                 //         width: 25,
                        //                 //       ),
                        //                 //       SizedBox(width: 10),
                        //                 //       Text(
                        //                 //         meals[index].mealName,
                        //                 //         style: TextStyle(
                        //                 //             color:
                        //                 //                 BeHealthyTheme.kMainOrange,
                        //                 //             fontSize: 18,
                        //                 //             fontWeight: FontWeight.bold),
                        //                 //         textAlign: TextAlign.center,
                        //                 //       ),
                        //                 //       Spacer(),
                        //                 //       Container(
                        //                 //         child: Row(
                        //                 //           children: [
                        //                 //             SizedBox.fromSize(
                        //                 //               size: Size(25,
                        //                 //                   25), // button width and height
                        //                 //               child: ClipOval(
                        //                 //                 child: Material(
                        //                 //                   color: BeHealthyTheme
                        //                 //                       .kMainOrange, // button color
                        //                 //                   child: InkWell(
                        //                 //                     splashColor: Colors
                        //                 //                         .green, // splash color
                        //                 //                     onTap: () {
                        //                 //                       // minus pressed
                        //                 //                       if (meals[index]
                        //                 //                               .quantity >
                        //                 //                           0) {
                        //                 //                         setState(() {
                        //                 //                           meals[index]
                        //                 //                               .quantity = meals[
                        //                 //                                       index]
                        //                 //                                   .quantity -
                        //                 //                               1;
                        //                 //                         });
                        //                 //                         getTotalAmount();
                        //                 //                       }
                        //                 //                     }, // button pressed
                        //                 //                     child: Column(
                        //                 //                       mainAxisAlignment:
                        //                 //                           MainAxisAlignment
                        //                 //                               .center,
                        //                 //                       children: <Widget>[
                        //                 //                         Icon(Icons.remove,
                        //                 //                             color: Colors
                        //                 //                                 .white)
                        //                 //                       ],
                        //                 //                     ),
                        //                 //                   ),
                        //                 //                 ),
                        //                 //               ),
                        //                 //             ),
                        //                 //             SizedBox(width: 5),
                        //                 //             Text(
                        //                 //               "${meals[index].quantity}",
                        //                 //               style: TextStyle(
                        //                 //                   color: BeHealthyTheme
                        //                 //                       .kMainOrange,
                        //                 //                   fontSize: 18),
                        //                 //               textAlign: TextAlign.center,
                        //                 //             ),
                        //                 //             SizedBox(width: 5),
                        //                 //             SizedBox.fromSize(
                        //                 //               size: Size(30,
                        //                 //                   30), // button width and height
                        //                 //               child: ClipOval(
                        //                 //                 child: Material(
                        //                 //                   color: BeHealthyTheme
                        //                 //                       .kMainOrange, // button color
                        //                 //                   child: InkWell(
                        //                 //                     splashColor: BeHealthyTheme
                        //                 //                         .kLightOrange, // splash color
                        //                 //                     onTap: () {
                        //                 //                       // add pressed
                        //                 //                       if (meals[index]
                        //                 //                               .quantity <
                        //                 //                           20) {
                        //                 //                         setState(() {
                        //                 //                           meals[index]
                        //                 //                               .quantity = meals[
                        //                 //                                       index]
                        //                 //                                   .quantity +
                        //                 //                               1;
                        //                 //                         });
                        //                 //                         getTotalAmount();
                        //                 //                       }
                        //                 //                     }, // button pressed
                        //                 //                     child: Column(
                        //                 //                       mainAxisAlignment:
                        //                 //                           MainAxisAlignment
                        //                 //                               .center,
                        //                 //                       children: <Widget>[
                        //                 //                         Icon(
                        //                 //                           Icons.add,
                        //                 //                           color:
                        //                 //                               Colors.white,
                        //                 //                         ), // icon// text
                        //                 //                       ],
                        //                 //                     ),
                        //                 //                   ),
                        //                 //                 ),
                        //                 //               ),
                        //                 //             ),
                        //                 //           ],
                        //                 //         ),
                        //                 //       ),
                        //                 //     ],
                        //                 //   ),
                        //                 // ),

                        //                 SizedBox(height: 5),
                        //                 Container(
                        //                   width: MediaQuery.of(context).size.width,
                        //                   child: Row(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment.end,
                        //                       children: [
                        //                         Text(
                        //                           "Amount : ",
                        //                           style: TextStyle(
                        //                               color: Style.prime,
                        //                               fontSize: 16,
                        //                               fontWeight: FontWeight.bold),
                        //                         ),
                        //                         Text(
                        //                             "${meals[index].itemExtraCost * meals[index].quantity} kd",
                        //                             style: TextStyle(fontSize: 16)),
                        //                         SizedBox(width: 16)
                        //                       ]),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //           SizedBox(height: 5),
                        //         ],
                        //       );
                        //     },
                        //   ),
                        // ),

                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          child: Column(children: [
                            SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Total Amount",
                                      style: TextStyle(
                                          color: Style.prime,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "$totalAmount kd",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () async {
                                    int totalMeal = 0;
                                    if (meals != null && meals.length > 0) {
                                      meals.forEach((meal) {
                                        totalMeal += meal.quantity;
                                      });
                                    }
                                    if (totalMeal == 0) {
                                      Get.snackbar(
                                        'Response',
                                        '',
                                        duration: Duration(seconds: 2),
                                        margin: EdgeInsets.all(16),
                                        padding: EdgeInsets.all(16),
                                        forwardAnimationCurve:
                                            Curves.easeInCubic,
                                        titleText: Text(
                                          "Please give at least one meal's quantity to continue.",
                                          style: Style.subtitle.copyWith(
                                            color: Style.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        messageText: Text(
                                          '',
                                          style: Style.subtitle.copyWith(
                                            color: Style.white,
                                          ),
                                        ),
                                        colorText: Style.white,
                                        borderRadius: 8,
                                        backgroundColor: Style.accent[300]!
                                            .withOpacity(0.87),
                                      );

                                      // Toast.show(
                                      //     "Please give at least one meal's quantity to continue.",
                                      //     context,
                                      //     duration: Toast.LENGTH_SHORT,
                                      //     gravity: Toast.BOTTOM);
                                    } else {
                                      mealTypesAndQuantities.clear();
                                      meals.forEach(
                                        (meal) {
                                          if (meal.quantity != 0) {
                                            var mealTypesAndQuantityClass =
                                                MealTypesAndQuantityClass();
                                            mealTypesAndQuantityClass.quantity =
                                                meal.quantity;
                                            mealTypesAndQuantityClass.mealType =
                                                meal.mealType;
                                            mealTypesAndQuantities
                                                .add(mealTypesAndQuantityClass);
                                          }
                                        },
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BasicPlan(),
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 30),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: 35,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Style.prime,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'confirm'.tr,
                                          style: Style.subtitle.copyWith(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                        Icon(Icons.arrow_forward_ios,
                                            size: 20, color: Colors.white)
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10)
                              ],
                            )
                          ]),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getDifferentMeals() async {
    final dbHelper = DatabaseHelper.instance;
    var rowsFuture = await dbHelper.selectPlanMealWithPlaId(widget.groupId);
    try {
      for (var meal in rowsFuture) {
        int mealType = meal["MealType"];
        double itemBasecost = meal["ItemBasecost"];
        double itemExtraCost = meal["ItemExtraCost"];
        double itemBaseCost = meal["ItemBasecost"];
        double planBaseCost = meal["PlanBasecost"];
        print('The meal is $meal');
        var mealNameFuture = await dbHelper.getMealName(mealType);
        print('The meal name future is $mealNameFuture');
        try {
          MealClass mealClass = MealClass();
          mealClass.mealName = mealNameFuture[0]["REFNAME1"];
          mealClass.itemCost = itemBasecost;
          mealClass.itemExtraCost = itemExtraCost;
          mealClass.itemBaseCost = itemBaseCost;
          mealClass.planBaseCost = planBaseCost;
          mealClass.mealType = mealType;
          setState(
            () {
              meals.add(mealClass);
            },
          );
        } catch (e) {
          print('Inside sub getDifferentMeals ${e.toString()}');
        }
      }
    } catch (e) {
      print('Inside getDifferentMeals function ${e.toString()}');
    }

    getTotalAmount();
  }

  getPlanDaysAndGrams() async {
    final dbHelper = DatabaseHelper.instance;
    var rowsFuture = await dbHelper.selectPlanMealWithPlaId(widget.groupId);
    try {
      int planDays = rowsFuture[0]["plandays"];
      int mealInGram = rowsFuture[0]["MealInGram"];
      int mealType = rowsFuture[0]["MealType"];
      PlanDaysClass planDay = PlanDaysClass();
      PlanGramsClass planGram = PlanGramsClass();
      planDay.isSelected = true;
      planGram.isSelected = true;
      var preferences = await SharedPreferences.getInstance();
      preferences.setInt('planDays', planDays);
      preferences.setInt('mealInGram', mealInGram);

      planDay.noOfDays = planDays;
      planGram.gramsOfPlan = mealInGram;

      setState(() {
        planClassDays.add(planDay);
        planGrams.add(planGram);
      });
    } catch (e) {
      print('getPlanDaysAndGrams ${e.toString()}');
    }
  }

  double totalAmount = 0.0;
  getTotalAmount() async {
    //double totalPrice = 0.0;
    if (meals.length > 0) {
      double baseCost = meals[0].itemBaseCost;
      meals.forEach(
        (meal) {
          baseCost += (meal.itemExtraCost * meal.quantity);
        },
      );
      setState(
        () {
          totalAmount = baseCost;
        },
      );
    }
    if (totalAmount != 0.0) {
      var preferences = await SharedPreferences.getInstance();
      preferences.setDouble('planAmount', totalAmount);
    }
    print("totalPrice $totalAmount ");
    return totalAmount;
  }
}

class MealClass {
  String mealName = "";
  String mealIconName = "";
  int quantity = 0;
  double itemCost = 0.0;
  double itemExtraCost = 0.0;
  double itemBaseCost = 0.0;
  double planBaseCost = 0.0;
  int mealType = 0;
}

class PlanDaysClass {
  int noOfDays = 0;
  bool isSelected = false;
}

class PlanGramsClass {
  int gramsOfPlan = 0;
  bool isSelected = false;
}

class MealTypesAndQuantityClass {
  int mealType = 0;
  int quantity = 0;

  MealTypesAndQuantityClass({
    this.mealType = 0,
    this.quantity = 0,
  });
}
