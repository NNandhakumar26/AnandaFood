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
          child: Scaffold(
            extendBody: true,
            bottomNavigationBar: BottomSide(
              title: "Total Amount",
              amount: "$totalAmount kd",
              buttonText: 'confirm'.tr,
              onPressed: () async {
                {
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
                      forwardAnimationCurve: Curves.easeInCubic,
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
                      backgroundColor: Style.accent[300]!.withOpacity(0.87),
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
                          mealTypesAndQuantityClass.quantity = meal.quantity;
                          mealTypesAndQuantityClass.mealType = meal.mealType;
                          mealTypesAndQuantities.add(mealTypesAndQuantityClass);
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
                }
              },
            ),
            body: Container(
              height: Get.height,
              width: Get.width,
              color: Style.prime[50]!.withOpacity(0.08),
              margin: EdgeInsets.only(left: 8),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 6),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Style.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Style.accent[300]!,
                                      width: 0.56,
                                    ),
                                  ),
                                  child: Text(
                                    "Days",
                                    style: Style.subtitle.copyWith(
                                      color: Style.accent,
                                      fontSize: 14,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  height: 30,
                                  margin: EdgeInsets.all(8),
                                  width:
                                      MediaQuery.of(context).size.width - 120,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: planClassDays == null
                                          ? 0
                                          : planClassDays.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () async {
                                            planClassDays.forEach((planDay) {
                                              planDay.isSelected = false;
                                            });
                                            setState(() {
                                              planClassDays[index].isSelected =
                                                  true;
                                            });
                                            var preferences =
                                                await SharedPreferences
                                                    .getInstance();
                                            preferences.setInt('planDays',
                                                planClassDays[index].noOfDays);
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: planClassDays == null
                                                    ? Style.prime[200]
                                                    : planClassDays[index]
                                                            .isSelected
                                                        ? Style.prime
                                                        : Style.prime[200],
                                              ),
                                              height: 56,
                                              width: 120,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        16, 5, 16, 5),
                                                child: Text(
                                                  planClassDays == null
                                                      ? ""
                                                      : "${planClassDays[index].noOfDays} day(s)",
                                                  style:
                                                      Style.subtitle.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    letterSpacing: 0.4,
                                                    color: planClassDays == null
                                                        ? Style.prime[300]
                                                        : planClassDays[index]
                                                                .isSelected
                                                            ? Style.white
                                                            : Style.accent,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  // style: TextStyle(
                                                  //     color: planClassDays == null
                                                  //         ? Style.prime[200]
                                                  //         : planClassDays[index]
                                                  //                 .isSelected
                                                  //             ? Colors.white
                                                  //             : Style.prime),
                                                  // textAlign: TextAlign.center,
                                                ),
                                              )),
                                        );
                                      }),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 6),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: Style.accent[300]!,
                                        width: 0.56,
                                      ),
                                    ),
                                    child: Text(
                                      "Weight",
                                      style: Style.subtitle.copyWith(
                                        color: Style.accent,
                                        fontSize: 14,
                                        letterSpacing: 0.4,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ),
                                // SizedBox(width: 8),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: 30,
                                    width:
                                        MediaQuery.of(context).size.width - 120,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        itemCount: planGrams == null
                                            ? 0
                                            : planGrams.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () async {
                                              planGrams.forEach((planGram) {
                                                planGram.isSelected = false;
                                              });
                                              setState(() {
                                                planGrams[index].isSelected =
                                                    true;
                                              });
                                              var preferences =
                                                  await SharedPreferences
                                                      .getInstance();
                                              preferences.setInt('mealInGram',
                                                  planGrams[index].gramsOfPlan);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: planClassDays == null
                                                    ? Style.prime[200]
                                                    : planClassDays[index]
                                                            .isSelected
                                                        ? Style.prime
                                                        : Style.prime[200],
                                              ),
                                              height: 56,
                                              width: 120,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        16, 5, 16, 5),
                                                child: Text(
                                                  planGrams == null
                                                      ? ""
                                                      : "${planGrams[index].gramsOfPlan} g",
                                                  style:
                                                      Style.subtitle.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    letterSpacing: 0.4,
                                                    color: planGrams == null
                                                        ? Style.prime[300]
                                                        : planGrams[index]
                                                                .isSelected
                                                            ? Style.white
                                                            : Style.accent,
                                                  ),
                                                  // textAlign: TextAlign.center,
                                                  // style: TextStyle(
                                                  //     color: planGrams == null
                                                  //         ? BeHealthyTheme.kLightOrange
                                                  //         : planGrams[index].isSelected
                                                  //             ? Colors.white
                                                  //             : BeHealthyTheme
                                                  //                 .kMainOrange),
                                                  // textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      // height: Get.height / 1.48,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      decoration: BoxDecoration(
                        color: Style.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Style.prime[300]!,
                          width: 0.32,
                        ),
                      ),
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
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ListTile(
                              // minVerticalPadding: 4,
                              // // minLeadingWidth: Get.width / 24,
                              // minLeadingWidth: 8,
                              leading: CircleAvatar(
                                maxRadius: 30.0,
                                backgroundColor:
                                    Style.prime[900]!.withOpacity(0.08),
                                child: Image(
                                  image: AssetImage('assets/images/card.png'),
                                  fit: BoxFit.fill,
                                  color: Style.prime[900],
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
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
                                      color:
                                          Style.accent[300]!.withOpacity(0.87),
                                      size: 16,
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
                                      color:
                                          Style.prime[700]!.withOpacity(0.87),
                                      size: 20,
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
                  ),
                ],
              ),
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

class BottomSide extends StatelessWidget {
  final String? title;
  final String? amount;
  final Function? onPressed;
  final String? buttonText;

  BottomSide({this.title, this.amount, this.onPressed, this.buttonText});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        // backgroundBlendMode: BlendMode.overlay,
        boxShadow: [
          BoxShadow(
            color: Style.accent[50]!.withOpacity(0.60),
            blurRadius: 5,
            spreadRadius: 0.5,
            offset: Offset(0.5, 1.5),
          ),
        ],
        color: Style.white.withOpacity(0.87),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: Style.subtitle.copyWith(
                    fontSize: 14,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w600,
                    color: Style.accent[300],
                  ),
                ),
                Text(
                  amount!,
                  style: Style.subtitle.copyWith(
                    fontSize: 16,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w400,
                    color: Style.accent[700],
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                backgroundColor: Style.accent,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              ),
              onPressed: () {
                return onPressed!();
              },
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  buttonText!,
                  style: Style.title.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    letterSpacing: 0.8,
                    color: Style.white.withOpacity(0.87),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
