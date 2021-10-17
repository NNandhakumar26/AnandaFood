import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subscription_mobile_app/SecondPage/SubMenuScreen.dart';
import 'package:subscription_mobile_app/Services/dataApiProvider.dart';
import 'package:subscription_mobile_app/database/dbhelper.dart';
import 'package:subscription_mobile_app/groupPage.dart';
import 'dart:convert';

import '../BasicPlan.dart';
import '../Theme.dart';
import 'dashboard_items_dbprovider.dart';

class MealsAvailableScreen extends StatefulWidget {
  final String? planName;
  final int? planId;
  final int id;
  final String groupName;
  const MealsAvailableScreen({
    Key? key,
    required this.planName,
    required this.planId,
    required this.id,
    required this.groupName,
  }) : super(key: key);

  @override
  _MealsAvailableScreenState createState() => _MealsAvailableScreenState();
}

class _MealsAvailableScreenState extends State<MealsAvailableScreen> {
  var isLoading = false;

  Map<String, int> mealType = {
    'Breakfast': 1401,
    'Lunch': 1402,
    'Dinner': 1403,
    'Snack': 1404,
    'Salad': 1405,
    'Soup': 1406
  };

  Map<String, dynamic> meals = {'meals': [], 'details': {}};
  List filtered = [];

  @override
  void initState() {
    getDifferentMeals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: LoginChecker(),
      body: SafeArea(
          child: Container(
        color: Style.prime[50]!.withOpacity(0.008),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                // shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: filtered != null
                    ? filtered.length
                    : 0, //(snapshot.data['meals'] as List).length,
                itemBuilder: (context, index) {
                  return CustomCard(
                    title: (meals["meals"][index] as String).split(' ')[1],
                    allowedMeal: int.parse(
                        (meals["meals"][index] as String).split(' ')[0]),
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.setInt('id', widget.planId!);
                      preferences.setString('planTitle', widget.planName!);
                      var mealType = filtered[index]['MealType'];
                      var id = meals['details']['id'];
                      var mealName =
                          (meals['meals'][index] as String).split(' ')[1];
                      preferences.setInt('mealType', mealType);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubMenuScreen(
                            widget.planName,
                            mealName,
                            id,
                            mealType,
                            'Menu',
                            widget.groupName,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }

  getPackageWithPlanID() async {
    // print(widget.id);
    http.Response response = await http.post(
        Uri.parse('https://foodapi.pos53.com/api/Food/Getpackagewithplanid'),
        body: {'TenentID': TenentID.toString(), 'PlanId': '${widget.id}'});
    if (response.statusCode == 200) {
      // print(response.body);
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  getDifferentMeals() async {
    final dbHelper = DatabaseHelper.instance;
    var rowsFuture = dbHelper.selectPlanMealWithPlaId(widget.planId);
    var groupId = widget.id;
    rowsFuture.then(
      (dataList) async {
        filtered = dataList
            .where((element) => element['GroupID'] == groupId.toString())
            .toList();
        int planDays = dataList[0]["plandays"];
        int mealInGram = dataList[0]["MealInGram"];
        var preferences = await SharedPreferences.getInstance();
        preferences.setInt('planDays', planDays);
        preferences.setInt('mealInGram', mealInGram);
        if (filtered.length > 0) {
          var disc = (filtered[0]['switch3'] as String).split(',');
          for (String value in disc) {
            if (value.trim() != '') {
              meals['meals'].add(value.trim());
            }
          }
        }
        for (var items in filtered) {
          if (items['GroupName'] == widget.groupName &&
              items['plandesc'] == widget.planName) {
            setState(
              () {
                meals['details']['planTitle'] = items['plandesc'];
                meals['details']['id'] = items['planid'];
                meals['details']['mealType'] = items['MealType'];
                meals['details']['groupName'] = widget.groupName;
                if ((meals['meals'] as List).isNotEmpty) {}
              },
            );
          }
        }
      },
    );
  }

  //unused API's
  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = DataApiProvider();
    await apiProvider.getAllPackages();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  getData() async {
    await _loadFromApi();
  }

  _buildEmployeeListView() {
    return FutureBuilder(
      future: DBProvider.db.getAllPackages(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // print(showData);
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.black12,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Text(
                  "${index + 1}",
                  style: TextStyle(fontSize: 20.0),
                ),
                title: Text(
                    "ID: ${snapshot.data[index].planID} ${snapshot.data[index].planName} "),
                subtitle: Text('Price: ${snapshot.data[index].planPrice}'),
              );
            },
          );
        }
      },
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final Function onTap;
  final int? allowedMeal;
  final String? image;
  final bool isSubscreen;
  const CustomCard({
    this.allowedMeal,
    required this.onTap,
    required this.title,
    this.image,
    this.isSubscreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Style.white,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      elevation: 8,
      // shadowColor: Colors.black45,
      shadowColor: Style.accent[50]!.withOpacity(0.32),
      child: InkWell(
        onTap: () {
          return onTap();
        },
        child: Container(
          constraints: BoxConstraints(
            minHeight: Get.height / 8.8,
          ),
          alignment: Alignment.center,
          child: ListTile(
            minLeadingWidth: Get.width / 8,
            leading: CircleAvatar(
              radius: 45,
              foregroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              child: (!isSubscreen)
                  ? Image(
                      image: (image == null)
                          ? AssetImage('assets/images/$title.png')
                          : AssetImage('assets/images/$image.png'),
                      color: Style.prime[900],
                    )
                  : (image == null)
                      ? Image(image: AssetImage('assets/images/haha2.png'))
                      : Image(
                          image: NetworkImage(image!),
                        ),
            ),
            title: Text(
              (allowedMeal != null)
                  ? '$title ($allowedMeal)'
                  : title.capitalizeFirst!,
              style: Style.subtitle.copyWith(
                fontSize: 14,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w500,
                color: Style.accent[700],
              ),
            ),
            trailing: Icon(
              Icons.arrow_right,
              color: Style.prime[700],
            ),
          ),
        ),
      ),
    );
  }
}
