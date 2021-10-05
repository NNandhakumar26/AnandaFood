import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subscription_mobile_app/SecondPage/Second_Main.dart';
import 'package:subscription_mobile_app/Theme.dart';
import 'package:subscription_mobile_app/database/dbhelper.dart';
import 'package:subscription_mobile_app/groupPage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Map<String, List<Group>> groups = {'active': [], 'inActive': []};
  Map<String, String> images = {
    'Building': 'muscle.png',
    'Diet': 'diet (2).png',
    'Slimming': 'diet (1).png',
    'Healthy': 'Soup.png',
    'Ramadan': 'dish.png'
  };

  final dbHelper = DatabaseHelper.instance;
  List planTitlesList = [];
  List queryListForHd = [];
  List itemsList = [];
  List mealPlans = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   leading: Container(),
        //   title: RichText(
        //     text: TextSpan(
        //       children: [
        //         TextSpan(
        //           text: 'your_existing'.tr,
        //         ),
        //         TextSpan(
        //           text: 'plan'.tr,
        //         )
        //       ],
        //     ),
        //   ),
        // ),

        body: Container(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                  future: _queryMain(),
                  builder: (context, AsyncSnapshot snap) {
                    if (snap.connectionState == ConnectionState.done) {
                      if (snap.data != null &&
                          snap.data.isNotEmpty &&
                          queryListForHd.isNotEmpty) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.28,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: snap.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Container();
                                        // return MealSelection(
                                        //   planId: queryListForHd[index]
                                        //       ['planid'],
                                        //   transId: queryListForHd[index]
                                        //       ['mytransid'],
                                        // );
                                      },
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.28,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Style.prime.withOpacity(0.11),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              child: Image(
                                                fit: BoxFit.fitWidth,
                                                image: AssetImage(
                                                    'assets/images/haha2.png'),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                    child: Text(
                                                      '${planTitlesList.length != 0 ? planTitlesList[index] : ""}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Text(
                                                    '${queryListForHd[index]['mytransid']}',
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 30),
                          child: Text(
                            'no_active_plan'.tr,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                SecondPage(
                  groups: groups,
                  isLoggedIn: true,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> readJsonBasic() async {
    Set<Group> uniqueGroupActive = {};
    Set<Group> uniqueGroupActiveAllowedCustom = {};
    var rowsFuture = dbHelper.selectPlanMeal();
    rowsFuture.then(
      (rows) {
        rows.forEach((element) {
          var groupName = element['GroupName'];
          var groupID = element['GroupID'];
          var active = element['ACTIVE'];
          var customAllow = element['CustomAllow'];
          var item = Group(groupName: groupName, groupId: int.parse(groupID));
          if (customAllow == "0") {
            //active != 0 &&
            uniqueGroupActive.add(item);
          }
          if (customAllow == "1") {
            uniqueGroupActiveAllowedCustom.add(item);
          }
        });
        setState(
          () {
            groups['active']!.addAll(uniqueGroupActive);
            groups['inActive']!.addAll(uniqueGroupActiveAllowedCustom);
          },
        );
      },
    );
  }

  _queryMain() async {
    queryListForHd.clear();
    final allRows = await dbHelper.queryAllRows();
    // print('query all rows:');
    //allRows.forEach(print);
    getPlanNames(allRows);
    allRows.forEach(
      (element) {
        queryListForHd.add(element);
      },
    );
    return allRows;
  }

  getData() async {
    http.Response response = await http
        .post(Uri.parse('https://foodapi.pos53.com/api/Food/GetPackage'));
    if (jsonDecode(response.body)['status'] == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  getPlanNames(rQueryList) async {
    final String response =
        await rootBundle.loadString('assets/json/newplan2.json');
    var rData = jsonDecode(response.toString());
    rQueryList.forEach((element) {
      planTitlesList.add((rData['NEwPlanMeal'] as List)
          .where((value) => value['planid'] == element['planid'].toString())
          .first['GroupName']);
    });

    // rData[element['planid'].toString()][0]['Plan_Display']
  }

  getInstances() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      return prefs;
    } else {
      return null;
    }
  }

  @override
  void didChangeDependencies() async {
    await readJsonBasic();
    super.didChangeDependencies();
  }
}
