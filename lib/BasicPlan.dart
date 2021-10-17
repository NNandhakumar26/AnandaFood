import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:subscription_mobile_app/CustomPlan.dart';
import 'package:subscription_mobile_app/Theme.dart';
import 'package:subscription_mobile_app/utils.dart';
import 'dart:convert';
import 'Services/Constants.dart';
import 'database/dbhelper.dart';
import 'database/table_fields.dart';
import 'models/generate_contract_response.dart';
import 'models/plan_days_response.dart';

class BasicPlan extends StatefulWidget {
  const BasicPlan({Key? key}) : super(key: key);

  @override
  State<BasicPlan> createState() => _BasicPlanState();
}

class _BasicPlanState extends State<BasicPlan> {
  bool value = false;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool showCalendar = false;
  int? myTransId;
  final dbHelper = DatabaseHelper.instance;
  int totalMealAllowed = 0;
  List mealPlan = [];
  List<String> mealNames = [];
  var planDays = 0;
  //or make it to late
  GenerateContractResponse? generateContractResponse;

  List<PlanDaysClass> planClassDays = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNextMyTransId();
    planMealCustomerInvoiceMoreHd();
    setPlaDays();
    getPlanDays();
    generateCustomerContract();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 18,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Style.prime[900],
          foregroundColor: Style.white,
          title: FutureBuilder(
            future: getInstances(),
            builder: (context, AsyncSnapshot snap) {
              if (snap.hasData) {
                var planTitle = snap.data.get('planTitle');
                //var arabicName = snap.data.get('arabicName');
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width * 0.72,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            planTitle.toString(),
                            style: Style.title.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8,
                                color: Style.white.withOpacity(0.87)),
                          ),
                          Text(
                            "Menu",
                            style: Style.title.copyWith(
                              color: Style.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Text('ERROR');
              }
            },
          ),
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Style.accent[300]!,
                          width: 0.8,
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                    Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width - 120,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount:
                            planClassDays == null ? 0 : planClassDays.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              planClassDays.forEach(
                                (planDay) {
                                  planDay.isSelected = false;
                                },
                              );
                              setState(
                                () {
                                  planClassDays[index].isSelected = true;
                                },
                              );
                              var preferences =
                                  await SharedPreferences.getInstance();
                              preferences.setInt(
                                  'planDays', planClassDays[index].noOfDays);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: planClassDays == null
                                    ? Style.prime
                                    : planClassDays[index].isSelected
                                        ? Style.prime[700]
                                        : Style.prime[300],
                              ),
                              height: 48,
                              width: 72,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 5, 16, 5),
                                child: Text(
                                  planClassDays == null
                                      ? ""
                                      : "${planClassDays[index].noOfDays} day(s)",
                                  style: Style.subtitle.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    letterSpacing: 0.4,
                                    color: planClassDays == null
                                        ? Style.prime[300]
                                        : planClassDays[index].isSelected
                                            ? Style.white
                                            : Style.accent,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),

                Card(
                  elevation: 8,
                  shadowColor: Style.black.withOpacity(0.60),
                  color: Style.white,
                  borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  margin: EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListTile(
                      onTap: () {
                        _selectDate(context);
                      },
                      leading: Icon(
                        Icons.calendar_today_rounded,
                        size: 18,
                        color: Style.prime[600],
                      ),
                      trailing: Text(
                        generateContractResponse != null
                            ? generateContractResponse!
                                .generateContractModel!.startDate!
                            : "",
                        style: Style.subtitle.copyWith(
                          color: Style.prime[700],
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: 0.8,
                        ),
                      ),
                      title: Text(
                        'Begin Date',
                        style: Style.subtitle.copyWith(
                          color: Style.accent[300],
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                //KINDA LOADING SCREEN..
                FutureBuilder(
                  future: dbHelper.querySubscriptionSetup(),
                  builder: (context, AsyncSnapshot snap) {
                    if (snap.connectionState == ConnectionState.done) {
                      return Text(
                        'Delivery starts ${snap.data['Delivery_in_day']} days after the selected Date',
                        style: Style.subtitle.copyWith(
                          color: Style.accent[200],
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          letterSpacing: 0.4,
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),

                Card(
                  elevation: 8,
                  shadowColor: Style.black.withOpacity(0.60),
                  color: Style.white,
                  borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  margin: EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListTile(
                      // onTap: () {
                      //   _selectDate(context);
                      // },
                      leading: Icon(
                        Icons.calendar_today_rounded,
                        size: 18,
                        color: Style.prime[600],
                      ),
                      trailing: Text(
                        generateContractResponse != null
                            ? generateContractResponse!
                                .generateContractModel!.endDate!
                            : "",
                        style: Style.subtitle.copyWith(
                          color: Style.prime[700],
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: 0.8,
                        ),
                      ),
                      title: Text(
                        'End Date',
                        style: Style.subtitle.copyWith(
                          color: Style.accent[300],
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CupertinoSwitch(
                        activeColor: Style.prime,
                        value: this.value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        }),
                    //SizedBox
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Deliver me on Holidays',
                        style: Style.subtitle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Style.accent[500],
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.9, 3),
                          color: Style.prime[50]!.withOpacity(0.60),
                          blurRadius: 12,
                          spreadRadius: 0.8,
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ThisPageColumn(
                          generateContractResponse: generateContractResponse,
                          text1: generateContractResponse != null
                              ? '${generateContractResponse!.generateContractModel!.totalWeek}'
                              : " ",
                          text2: 'Weeks',
                        ),
                        ThisPageColumn(
                          generateContractResponse: generateContractResponse,
                          text1: '$planDays',
                          text2: 'Days',
                        ),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       '$planDays',
                        //       style: Style.subtitle.copyWith(
                        //         color: Style.prime[3000],
                        //         fontSize: 30,
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       height: 7,
                        //     ),
                        //     Text(
                        //       'Days',
                        //       style: Style.subtitle.copyWith(
                        //         color: Colors.black87,
                        //         fontSize: 20,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
                FutureBuilder(
                  future: getMealsOfAPlan(),
                  builder: (context, snap) {
                    if (snap.data != null) {
                      return Container(
                        height: Get.height / 5.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Style.accent[300]!,
                            width: 0.6,
                          ),
                          // color: Style.prime[50]!.withOpacity(0.60),
                          color: Style.white,
                        ),
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemCount: mealNames != null ? mealNames.length : 0,
                          itemBuilder: (context, index) {
                            String item = "";
                            mealNames != null
                                ? item = mealNames[index]
                                : item = "";
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image:
                                        AssetImage('assets/images/$item.png'),
                                    fit: BoxFit.scaleDown,
                                    height: Get.height / 13,
                                    width: Get.width / 5.6,
                                    color: Style.prime[300],
                                  ),
                                  Text(
                                    '$item',
                                    style: Style.subtitle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      // color: Style.accent.withOpacity(0.87),
                                      color: Style.accent[300],
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                GestureDetector(
                  onTap: () async {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        Future.delayed(
                          Duration(seconds: 5),
                          () {
                            try {
                              _insert(generateContractResponse!
                                  .generateContractModel!.planmealinvoiceHD);
                              _insertMoreHd().then(
                                (value) {
                                  // mealPlan.clear();
                                },
                              );
                            } catch (e) {
                              Get.snackbar(
                                'Response',
                                '',
                                duration: Duration(seconds: 2),
                                margin: EdgeInsets.all(16),
                                padding: EdgeInsets.all(16),
                                forwardAnimationCurve: Curves.easeInCubic,
                                titleText: Text(
                                  "Your Plan is Already Active",
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
                                backgroundColor:
                                    Style.accent[300]!.withOpacity(0.87),
                              );

                              // Toast.show("Your Plan is Already Active",
                              //     context,
                              //     duration: 5);
                            }
                            Navigator.pop(context);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => PackageDetails(
                            //       genratedContract: snapshot.data,
                            //       transId: myTransId,
                            //     ),
                            //   ),
                            // );
                          },
                        );
                        return Center(child: CircularProgressIndicator());
                      },
                    );
                  },
                  child: Container(
                    width: Get.width / 2,
                    height: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Style.accent[700],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Confirm',
                      style: Style.title.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                        color: Style.white.withOpacity(0.87),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getNextMyTransId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Toast.show("Calling GetNextMyTransId", context, duration: 5);
    http.Response respo = await http.post(
        Uri.parse('https://foodapi.pos53.com/api/Food/GetNextMyTransId'),
        body: {'TenantID': '14'});
    if (jsonDecode(respo.body)['status'] == 200) {
      print(jsonDecode(respo.body)['data'][0]['MYTRANSID']);
      prefs.setInt('myTransId', jsonDecode(respo.body)['data'][0]['MYTRANSID']);
      myTransId = jsonDecode(respo.body)['data'][0]['MYTRANSID'];
    } else {
      Get.snackbar(
        'Response',
        '',
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        forwardAnimationCurve: Curves.easeInCubic,
        titleText: Text(
          "error in api status code" +
              jsonDecode(respo.body)['status'] +
              " message " +
              jsonDecode(respo.body)['message'],
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
      //     "error in api status code" +
      //         jsonDecode(respo.body)['status'] +
      //         " message " +
      //         jsonDecode(respo.body)['message'],
      //     context,
      //     duration: 5);
    }
  }

  getInstances() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      return prefs;
    } else {
      return null;
    }
  }

  planMealCustomerInvoiceMoreHd() async {
    var prefs = await getInstances();
    var planId = prefs.get('id');
    var rowsFuture = await dbHelper.selectPlanMealWithPlaId(planId);

    try {
      if (rowsFuture[0]["CustomAllow"] == "1") {
        mealTypesAndQuantities.forEach(
          (data) {
            var mealNameFuture = dbHelper.getMealName(data.mealType);
            mealNameFuture.then(
              (item) {
                mealNames.add(item[0]["REFNAME1"]);
              },
            );
          },
        );
        mealTypesAndQuantities.forEach(
          (mealTypeQuantity) {
            rowsFuture.forEach(
              (data) {
                if (data['planid'] == planId &&
                    mealTypeQuantity.mealType == data["MealType"]) {
                  //  data["MealAllowed"] = mealTypeQuantity.quantity;
                  mealPlan.add(data);
                }
              },
            );
          },
        );
//TODO: CHECK HERE... INT.PARSE OR AS INT

        mealPlan.forEach((element) {
          totalMealAllowed += element!['MealAllowed'] as int;
        });
      } else {
        rowsFuture.forEach((data) {
          var mealNameFuture = dbHelper.getMealName(data["MealType"]);
          mealNameFuture.then((item) {
            mealNames.add(item[0]["REFNAME1"]);
          });

          if (data['planid'] == planId) {
            //aDDED
            var mealTypesAndQuantityClass = MealTypesAndQuantityClass();
            mealTypesAndQuantityClass.mealType = data["MealType"];
            mealTypesAndQuantityClass.quantity = data["MealAllowed"];
            mealTypesAndQuantities.add(mealTypesAndQuantityClass);
            //aDDED
            mealPlan.add(data);
          }
        });
        mealPlan.forEach((element) {
          totalMealAllowed += int.parse(element['MealAllowed']);
        });
      }
    } catch (e) {
      print('Plan Meal Customer invoice Method ${e.toString()}');
    }

    // rowsFuture.then(
    //   (dataList) async {
    //     if (dataList[0]["CustomAllow"] == "1") {
    //       mealTypesAndQuantities.forEach(
    //         (data) {
    //           var mealNameFuture = dbHelper.getMealName(data.mealType);
    //           mealNameFuture.then(
    //             (item) {
    //               mealNames.add(item[0]["REFNAME1"]);
    //             },
    //           );
    //         },
    //       );

    //       mealTypesAndQuantities.forEach(
    //         (mealTypeQuantity) {
    //           dataList.forEach(
    //             (data) {
    //               if (data['planid'] == planId &&
    //                   mealTypeQuantity.mealType == data["MealType"]) {
    //                 //  data["MealAllowed"] = mealTypeQuantity.quantity;
    //                 mealPlan.add(data);
    //               }
    //             },
    //           );
    //         },
    //       );

    //       mealPlan.forEach((element) {
    //         totalMealAllowed += int.parse(element['MealAllowed']);
    //       });
    //     } else {
    //       dataList.forEach((data) {
    //         var mealNameFuture = dbHelper.getMealName(data["MealType"]);
    //         mealNameFuture.then((item) {
    //           mealNames.add(item[0]["REFNAME1"]);
    //         });

    //         if (data['planid'] == planId) {
    //           mealPlan.add(data);
    //         }
    //       });
    //       mealPlan.forEach((element) {
    //         totalMealAllowed += int.parse(element['MealAllowed']);
    //       });
    //     }
    //   },
    // );
  }

  setPlaDays() async {
    var preferences = await SharedPreferences.getInstance();
    planDays = preferences.getInt('planDays')!;
  }

//aDDED
  getPlanDays() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = 1; //preferences.get('PlanID');
    var dataMapToPost = {'TenentID': '$TenentID', 'PlanId': '${id.toString()}'};
    print(dataMapToPost);
    http.Response response = await http.post(
        Uri.parse('https://foodapi.pos53.com/api/Food/GetPlanDaysInPlanMeal'),
        body: dataMapToPost);
    if (jsonDecode(response.body)['status'] == 200) {
      var responseBody = jsonDecode(response.body);
      var planDaysResponse = PlanDaysResponse.fromJson(responseBody);
      var planDays = planDaysResponse.planDaysModel;
      preferences.setStringList("planDaysList", planDays!);
      planDays.forEach((element) {
        PlanDaysClass planDay = PlanDaysClass();
        planDay.noOfDays = int.parse(element);
        planDay.isSelected = true;
        setState(() {
          planClassDays.add(planDay);
        });
      });
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  generateCustomerContract() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime? requiredDate = _selectedDay != null ? _selectedDay : _focusedDay;
    DateTime beginDate = requiredDate!.add(const Duration(days: 2));

    var planId = prefs.get('id');
    var tenentID = TenentID.toString();
    var custID = prefs.get('custID');
    var contractDate =
        '${requiredDate.month}/${requiredDate.day}/${requiredDate.year}';
    var beginDateStr = '${beginDate.month}/${beginDate.day}/${beginDate.year}';

    //ERROR OCCURS HERE
    final dbHelper = DatabaseHelper.instance;
    var rowsFuture = await dbHelper.selectPlanMealWithPlaId(planId);

    try {
      int planDays = rowsFuture[0]["plandays"];
      var map = {
        'PlanId': '$planId',
        'TenentID': tenentID.toString(),
        'CustomerId': '$custID',
        'ContractDate': '$contractDate',
        'BeginDate': beginDateStr,
        'AllowWeekend': '$value',
        'PlanDays': '$planDays'
      };
      print(map);
      http.Response response = await http.post(
          Uri.parse(
              'https://foodapi.pos53.com/api/Food/GenerateCustomerContract'),
          body: map);
      var json = jsonDecode(response.body);
      print(json);
      if (json['status'] == 200) {
        setState(
          () {
            generateContractResponse = GenerateContractResponse.fromJson(json);
          },
        );
        print(generateContractResponse!.generateContractModel);
      }
    } catch (e) {
      print('From GenerateCustomerContract APi ${e.toString()}');
    }

    // var response = await http.post(
    //   Uri.parse('https://foodapi.pos53.com/api/Food/GenerateCustomerContract'),
    //   body: {
    //     'PlanId': '$planId',
    //     'TenentID': tenentID,
    //     'CustomerId': '$custID',
    //     'ContractDate': '$contractDate',
    //     'BeginDate': beginDateStr,
    //     'AllowWeekend': '$value'
    //   },
    // );
    // print('response is that ${response.body}');
    // print(response.statusCode);
    // // var json = jsonDecode(response.body);
    // try {
    //   if (jsonDecode(response.body)['status'] == 200) {
    //     return jsonDecode(response.body);
    //   } else if (jsonDecode(response.body)['status'] == 400) {
    //     return jsonDecode(response.body);
    //   } else {
    //     return jsonDecode(response.body);
    //   }
    // } catch (e) {
    //   print('From Customer Contract Screen ${e.toString()}');
    // }
  }
//aDDED

  _selectDate(BuildContext context) async {
    final row = await dbHelper.querySubscriptionSetup();
    int? holidayNumber;
    switch (row['Week_Holiday']) {
      case "Monday":
        {
          setState(() {
            holidayNumber = 1;
          });
        }
        break;
      case "Tuesday":
        {
          setState(() {
            holidayNumber = 2;
          });
        }
        break;
      case "Wednesday":
        {
          setState(() {
            holidayNumber = 3;
          });
        }
        break;
      case "Thursday":
        {
          setState(() {
            holidayNumber = 4;
          });
        }
        break;
      case "Friday":
        {
          setState(() {
            holidayNumber = 5;
          });
        }
        break;
      case "Saturday":
        {
          setState(() {
            holidayNumber = 6;
          });
        }
        break;
      case "Sunday":
        {
          setState(() {
            holidayNumber = 7;
          });
        }
        break;
    }

    final picked = await showDatePicker(
      selectableDayPredicate: (dateTime) =>
          dateTime.weekday == holidayNumber ? false : true,
      context: context,
      initialDate: _focusedDay.weekday == holidayNumber
          ? _focusedDay.add(Duration(days: 1))
          : _focusedDay, // Refer step 1
      firstDate: kFirstDay,
      lastDate: kLastDay,
    );
    if (picked != null && picked != _selectedDay) {
      setState(() {
        _selectedDay = picked;
      });
    }
  }

  Future<List> getMealsOfAPlan() async {
    var textData = await DefaultAssetBundle.of(context)
        .loadString("assets/json/newplan2.json");
    var preference = await SharedPreferences.getInstance();
    var custId = preference.get('id');
    var json = jsonDecode(textData)['NEwPlanMeal'] as List;
    var filtered = json
        .where((element) => element['planid'] == custId.toString())
        .toList()
        .first['switch3']
        .split(',')
        .toList()
        .where((element) => element != '')
        .map((String element) => element.trim())
        .toList();

    return filtered;
  }

  _insert(var dataForSql) async {
    //var planDays = 26;

    Map<String, dynamic> row = {
      DatabaseHelper.columntenentId: dataForSql['TenentID'],
      DatabaseHelper.columnmytransid: myTransId,
      DatabaseHelper.columnlocationId: dataForSql['LOCATION_ID'],
      DatabaseHelper.columncustomerId: dataForSql['CustomerID'],
      DatabaseHelper.columnplanid: dataForSql['planid'],
      DatabaseHelper.columndayNumber: "$planDays",
      DatabaseHelper.columntransId: dataForSql['TransID'],
      DatabaseHelper.columncontractId: dataForSql['ContractID'],
      DatabaseHelper.columndefaultDriverId: dataForSql['DefaultDriverID'],
      DatabaseHelper.columncontractDate: dataForSql['ContractDate'],
      DatabaseHelper.columnweekofDay: dataForSql['WeekofDay'],
      DatabaseHelper.columnstartDate: dataForSql['StartDate'],
      DatabaseHelper.columnendDate: dataForSql['EndDate'],
      DatabaseHelper.columntotalSubDays: dataForSql['TotalSubDays'],
      DatabaseHelper.columndeliveredDays: 0,
      DatabaseHelper.columnnExtDeliveryDate: dataForSql['NExtDeliveryDate'],
      DatabaseHelper.columnnExtDeliveryNum: dataForSql['NExtDeliveryNum'],
      DatabaseHelper.columnweek1TotalCount: dataForSql['Week1TotalCount'],
      DatabaseHelper.columnweek1Count: dataForSql['Week1Count'],
      DatabaseHelper.columnweek2Count: dataForSql['Week2Count'],
      DatabaseHelper.columnweek2TotalCount: dataForSql['Week2TotalCount'],
      DatabaseHelper.columnweek3Count: dataForSql['Week3Count'],
      DatabaseHelper.columnweek3TotalCount: dataForSql['Week3TotalCount'],
      DatabaseHelper.columnweek4Count: dataForSql['Week4Count'],
      DatabaseHelper.columnweek4TotalCount: dataForSql['Week4TotalCount'],
      DatabaseHelper.columnweek5Count: dataForSql['Week5Count'],
      DatabaseHelper.columnweek5TotalCount: dataForSql['Week5TotalCount'],
      DatabaseHelper.columncontractTotalCount: dataForSql['ContractTotalCount'],
      DatabaseHelper.columncontractSelectedCount:
          dataForSql['ContractSelectedCount'],
      DatabaseHelper.columnisFullPlanCopied: dataForSql['IsFullPlanCopied'],
      DatabaseHelper.columnsubscriptionOnHold: dataForSql['SubscriptionOnHold'],
      DatabaseHelper.columnholdDate: dataForSql['HoldDate'],
      DatabaseHelper.columnunHoldDate: dataForSql['UnHoldDate'],
      DatabaseHelper.columnholdbyuser: dataForSql['Holdbyuser'],
      DatabaseHelper.columnholdREmark: dataForSql['HoldREmark'],
      DatabaseHelper.columnsubscriptonDayNumber:
          dataForSql['SubscriptonDayNumber'],
      DatabaseHelper.columntotalPrice: dataForSql['Total_price'],
      DatabaseHelper.columnshortRemark: dataForSql['ShortRemark'],
      DatabaseHelper.columnactive: dataForSql['ACTIVE'],
      DatabaseHelper.columncrupId: dataForSql['CRUP_ID'],
      DatabaseHelper.columnchangesDate: dataForSql['ChangesDate'],
      DatabaseHelper.columndriverId: dataForSql['DriverID'],
      DatabaseHelper.columncStatus: dataForSql['CStatus'],
      DatabaseHelper.columnuploadDate: dataForSql['UploadDate'],
      DatabaseHelper.columnuploadby: dataForSql['Uploadby'],
      DatabaseHelper.columnsyncDate: dataForSql['SyncDate'],
      DatabaseHelper.columnsyncby: dataForSql['Syncby'],
      DatabaseHelper.columnsynId: dataForSql['SynID'],
      DatabaseHelper.columnpaymentStatus: dataForSql['PaymentStatus'],
      DatabaseHelper.columnsyncStatus: dataForSql['syncStatus'],
      DatabaseHelper.columnlocalId: dataForSql['LocalID'],
      DatabaseHelper.columnofflineStatus: dataForSql['OfflineStatus'],
      DatabaseHelper.columnallergies: dataForSql['Allergies'],
      DatabaseHelper.columncarbs: dataForSql['Carbs'],
      DatabaseHelper.columnprotein: dataForSql['Protein'],
      DatabaseHelper.columnremarks: dataForSql['Remarks'],
    };
    final id = await dbHelper.insertToplanMealCustInvoiceHD(row);
    print('Inserted row id: $id');
    dataForSql['MYTRANSID'] = myTransId;
    var prams = {
      "\$id": '2',
      "TenentID": '${dataForSql['TenentID']}',
      "MYTRANSID": '$myTransId',
      "LOCATION_ID": '${dataForSql['LOCATION_ID']}',
      "CustomerID": '${dataForSql['CustomerID']}',
      "planid": '${dataForSql['planid']}',
      "DayNumber":
          "$planDays", //dataForSql['TotalSubDays'] != null ? '${dataForSql['TotalSubDays']}' : '26',
      "TransID": '$myTransId',
      "ContractID": '$myTransId',
      "DefaultDriverID": '${dataForSql['DefaultDriverID']}',
      "ContractDate": '${dataForSql['ContractDate']}',
      "WeekofDay": '${dataForSql['WeekofDay']}',
      "StartDate": '${dataForSql['StartDate']}',
      "EndDate": '${dataForSql['EndDate']}',
      "TotalSubDays": "$planDays",
      "DeliveredDays": '0',
      "NExtDeliveryDate": '${dataForSql['NExtDeliveryDate']}',
      "NExtDeliveryNum": '${dataForSql['NExtDeliveryNum']}',
      "Week1TotalCount": '${dataForSql['Week1TotalCount']}',
      "Week1Count": '${dataForSql['Week1Count']}',
      "Week2Count": '${dataForSql['Week2Count']}',
      "Week2TotalCount": '${dataForSql['Week2TotalCount']}',
      "Week3Count": '${dataForSql['Week3Count']}',
      "Week3TotalCount": '${dataForSql['Week3TotalCount']}',
      "Week4Count": '${dataForSql['Week4Count']}',
      "Week4TotalCount": '${dataForSql['Week4TotalCount']}',
      "Week5Count": '${dataForSql['Week5Count']}',
      "Week5TotalCount": '${dataForSql['Week5TotalCount']}',
      "ContractTotalCount": '${dataForSql['ContractTotalCount']}',
      "ContractSelectedCount": '${dataForSql['ContractSelectedCount']}',
      "IsFullPlanCopied": '${dataForSql['IsFullPlanCopied']}',
      "SubscriptionOnHold": '${dataForSql['SubscriptionOnHold']}',
      "HoldDate": '${dataForSql['HoldDate']}',
      "UnHoldDate": '${dataForSql['UnHoldDate']}',
      "Holdbyuser": '${dataForSql['Holdbyuser']}',
      "HoldREmark": '${dataForSql['HoldREmark']}',
      "SubscriptonDayNumber": '${dataForSql['SubscriptonDayNumber']}',
      "Total_price": '${dataForSql['Total_price']}',
      "ShortRemark": '${dataForSql['ShortRemark']}',
      "ACTIVE": '${dataForSql['ACTIVE']}',
      "CRUP_ID": '${dataForSql['CRUP_ID']}',
      "ChangesDate": '${dataForSql['ChangesDate']}',
      "DriverID": '${dataForSql['DriverID']}',
      "CStatus": '${dataForSql['CStatus']}',
      "UploadDate": '${dataForSql['UploadDate']}',
      "Uploadby": '${dataForSql['Uploadby']}',
      "SyncDate": '${dataForSql['SyncDate']}',
      "Syncby": '${dataForSql['Syncby']}',
      "SynID": '${dataForSql['SynID']}',
      "PaymentStatus": '${dataForSql['PaymentStatus']}',
      "syncStatus": '${dataForSql['syncStatus']}',
      "LocalID": '${dataForSql['LocalID']}',
      "OfflineStatus": '${dataForSql['OfflineStatus']}',
      "Allergies": '${dataForSql['Allergies']}',
      "Carbs": '${dataForSql['Carbs']}',
      "Protein": '${dataForSql['Protein']}',
      "Remarks": ""
    };
    print(prams);
    try {
      http.Response res = await http.post(
          Uri.parse(
              'https://foodapi.pos53.com/api/Food/PlanmealcustinvoiceHD_Save'),
          body: prams);
      print("123 $res");
      // print({"\$id": '2', "TenentID": '${dataForSql['TenentID']}', "MYTRANSID": '$myTransId', "LOCATION_ID": '${dataForSql['LOCATION_ID']}',
      //   "CustomerID": '${dataForSql['CustomerID']}',
      //   "planid": '${dataForSql['planid']}',
      //   "DayNumber": '${dataForSql['DayNumber']}',
      //   "TransID": '$myTransId',
      //   "ContractID": '$myTransId',
      //   "DefaultDriverID": '${dataForSql['DefaultDriverID']}',
      //   "ContractDate": '${dataForSql['ContractDate']}',
      //   "WeekofDay": '${dataForSql['WeekofDay']}',
      //   "StartDate": '${dataForSql['StartDate']}',
      //   "EndDate": '${dataForSql['EndDate']}',
      //   "TotalSubDays": '${dataForSql['TotalSubDays']}',
      //   "DeliveredDays": '0',
      //   "NExtDeliveryDate": '${dataForSql['NExtDeliveryDate']}',
      //   "NExtDeliveryNum": '${dataForSql['NExtDeliveryNum']}',
      //   "Week1TotalCount": '${dataForSql['Week1TotalCount']}',
      //   "Week1Count": '${dataForSql['Week1Count']}',
      //   "Week2Count": '${dataForSql['Week2Count']}',
      //   "Week2TotalCount": '${dataForSql['Week2TotalCount']}',
      //   "Week3Count": '${dataForSql['Week3Count']}',
      //   "Week3TotalCount": '${dataForSql['Week3TotalCount']}',
      //   "Week4Count": '${dataForSql['Week4Count']}',
      //   "Week4TotalCount": '${dataForSql['Week4TotalCount']}',
      //   "Week5Count": '${dataForSql['Week5Count']}',
      //   "Week5TotalCount": '${dataForSql['Week5TotalCount']}',
      //   "ContractTotalCount": '${dataForSql['ContractTotalCount']}',
      //   "ContractSelectedCount": '${dataForSql['ContractSelectedCount']}',
      //   "IsFullPlanCopied": '${dataForSql['IsFullPlanCopied']}',
      //   "SubscriptionOnHold": '${dataForSql['SubscriptionOnHold']}',
      //   "HoldDate": '${dataForSql['HoldDate']}',
      //   "UnHoldDate": '${dataForSql['UnHoldDate']}',
      //   "Holdbyuser": '${dataForSql['Holdbyuser']}',
      //   "HoldREmark": '${dataForSql['HoldREmark']}',
      //   "SubscriptonDayNumber": '${dataForSql['SubscriptonDayNumber']}',
      //   "Total_price": '${dataForSql['Total_price']}',
      //   "ShortRemark": '${dataForSql['ShortRemark']}',
      //   "ACTIVE": '${dataForSql['ACTIVE']}',
      //   "CRUP_ID": '${dataForSql['CRUP_ID']}',
      //   "ChangesDate": '${dataForSql['ChangesDate']}',
      //   "DriverID": '${dataForSql['DriverID']}',
      //   "CStatus": '${dataForSql['CStatus']}',
      //   "UploadDate": '${dataForSql['UploadDate']}',
      //   "Uploadby": '${dataForSql['Uploadby']}',
      //   "SyncDate": '${dataForSql['SyncDate']}',
      //   "Syncby": '${dataForSql['Syncby']}',
      //   "SynID": '${dataForSql['SynID']}',
      //   "PaymentStatus": '${dataForSql['PaymentStatus']}',
      //   "syncStatus": '${dataForSql['syncStatus']}',
      //   "LocalID": '${dataForSql['LocalID']}',
      //   "OfflineStatus": '${dataForSql['OfflineStatus']}',
      //   "Allergies": '${dataForSql['Allergies']}',
      //   "Carbs": '${dataForSql['Carbs']}',
      //   "Protein": '${dataForSql['Protein']}',
      //   "Remarks": '${dataForSql['Remarks']}'
      // });
      //print('Hd Save: ${res.body}');

      // if (jsonDecode(res.body)['status'] == 200) {
      //   Toast.show( "PlanmealcustinvoiceHD_Save Api call message " +jsonDecode(res.body)['message'], context, duration: 3);
      // } else{
      //   Toast.show("error in api status code" + jsonDecode(res.body)['status'] + " message " + jsonDecode(res.body)['message'], context, duration: 3);
      // }
    } catch (e) {
      Get.snackbar(
        'Response',
        '',
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        forwardAnimationCurve: Curves.easeInCubic,
        titleText: Text(
          "Error in the API response ${e.toString()}",
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
      // Toast.show("Error in the API response ${e.toString()}", context,
      //     duration: 3);
    }
  }

  _insertMoreHd() async {
    int i = 1;
    dbHelper.deleteAllFromMoreHD();
    mealPlan.forEach((element) async {
      Map<String, dynamic> newRow = {
        TableFields.tenentid: element['TenentID'],
        TableFields.mytransid: myTransId,
        TableFields.mealtype: element['MealType'],
        TableFields.planid: element['planid'],
        TableFields.customized: element['MealFixFlexible'],
        TableFields.totalmealallowed: element['TotalAllowed'],
        TableFields.planingram: element['PlanInGram'],
        TableFields.mealfixflexible: element['MealFixFlexible'],
        TableFields.uom: element['UOM'],
        TableFields.mealingram: element['MealInGram'],
        TableFields.planbasecost: element['PlanBasecost'],
        TableFields.itembasecost: element['ItemBasecost'],
        TableFields.basemeal: mealTypesAndQuantities[mealPlan.indexOf(element)]
            .quantity, //element['MealAllowed'],
        TableFields.extrameal: null,
        TableFields.extramealcost: element['ItemExtraCost'],
        TableFields.amt: element['PlanBasecost'],
        TableFields.uploaddate: element['UploadDate'],
        TableFields.uploadby: element['Uploadby'],
        TableFields.syncdate: element['SyncDate'],
        TableFields.syncby: 'Flutter',
        TableFields.synid: element['SynID'],
        TableFields.totalamount: element['PlanBasecost'],
        TableFields.paidamount: null,
        TableFields.alloweekend: value,
        TableFields.updatedate:
            '${_focusedDay.month}/${_focusedDay.day}/${_focusedDay.year}'
      };
      try {
        final id = await dbHelper.insertInToMoreHD(newRow);
        print('inserted row in more hd id: $id');
      } catch (e) {
        Get.snackbar(
          'Response',
          '',
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          forwardAnimationCurve: Curves.easeInCubic,
          titleText: Text(
            e.toString(),
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
        // Toast.show(e.toString(), context, duration: 5);
      }
      var body = {
        "\$id": "${i++}",
        "TenentID": '${element['TenentID']}',
        "MYTRANSID": '$myTransId',
        "MealType": '${element['MealType']}',
        "PlanId": '${element['planid']}',
        "Customized": "No",
        "MealFixFlexible": '${element['MealFixFlexible']}',
        "UOM": '${element['UOM']}',
        "TotalMealAllowed": '$totalMealAllowed',
        //need to change this meal allowed to the actual as used above
        "WeekMealAllowed": '$totalMealAllowed',
        "PlanInGram": '${element['PlanInGram']}',
        "plandays": '$planDays',
        "MealInGram": '${element['MealInGram']}',
        "PlanBasecost": '${element['PlanBasecost']}',
        "ItemBasecost": '${element['ItemBasecost']}',
        "BaseMeal": '${element['MealAllowed']}',
        "ExtraMeal": "null",
        "ExtraMealCost": "${element['ItemExtraCost']}",
        "Amt": '${element['PlanBasecost']}',
        "UploadDate": '${element['UploadDate']}',
        "Uploadby": '${element['Uploadby']}',
        "SyncDate": '${element['SyncDate']}',
        "Syncby": "Flutter",
        "SynID": '${element['SynID']}',
        "TotalAmount": '${element['PlanBasecost']}',
        "PaidAmount": "null",
        "AlloWeekend": '$value',
        "UpdateDate":
            '${_focusedDay.month}/${_focusedDay.day}/${_focusedDay.year}'
      };
      http.Response res = await http.post(
          Uri.parse(
              'https://foodapi.pos53.com/api/Food/PlanmealcustinvoiceMoreHD_Save'),
          body: body);
      print('More Hd Save $i :${res.body}');
      //  if (res.statusCode == 200){
      //    Toast.show("Plan meal customer invoice More HD Save Api call message " + jsonDecode(res.body)['message'], context, duration: 5);
      //  }else{
      //    Toast.show("error in api status code" + jsonDecode(res.body)['status'] + " message " + jsonDecode(res.body)['message'], context, duration: 5);
      //  }
    });
  }
}

class ThisPageColumn extends StatelessWidget {
  const ThisPageColumn({
    Key? key,
    required this.generateContractResponse,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  final GenerateContractResponse? generateContractResponse;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //aDDED
        Text(
          text1,
          style: Style.title.copyWith(
            color: Style.prime[700],
            fontWeight: FontWeight.w500,
            letterSpacing: 0.4,
            fontSize: 26,
          ),
        ),
        //aDDED

        // SizedBox(
        //   height: 7,
        // ),
        Text(
          text2,
          style: Style.subtitle.copyWith(
            color: Style.accent[300],
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class NewWidget extends StatelessWidget {
  final String title;

  NewWidget({this.title = ''});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      initialValue: title,
      decoration: Style.inputTextDecoration(
        title: title,
      ).copyWith(
        prefixIcon: Icon(
          Icons.calendar_today_rounded,
          color: Style.prime[900],
        ),
        contentPadding: EdgeInsets.all(16),
        prefixStyle: Style.subtitle.copyWith(
          color: Style.prime[900],
        ),
      ),

      // onTap: () async {
      //   var date = await showDatePicker(
      //     context: context,
      //     initialDate: DateTime.now(),
      //     firstDate: DateTime(1900),
      //     lastDate: DateTime(2100),
      //   );
      //   // dateController.text = date.toString().substring(0,10);
      // },
      cursorColor: Style.accent[700],
      style: Style.subtitle.copyWith(
        color: Style.accent[500],
        letterSpacing: 0.8,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
