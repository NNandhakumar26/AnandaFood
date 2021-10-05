import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:subscription_mobile_app/SecondPage/MealDetailPage.dart';
import 'package:subscription_mobile_app/SecondPage/MealsAvailableScreen.dart';
import 'package:subscription_mobile_app/groupPage.dart';
import 'dart:convert';
import '../Theme.dart';

class SubMenuScreen extends StatefulWidget {
  final String? planTitle;
  final String? title;
  final int? id;
  final int? mealType;
  final String? arabicName;
  final String? groupName;
  SubMenuScreen(this.planTitle, this.title, this.id, this.mealType,
      this.arabicName, this.groupName);

  @override
  _SubMenuScreenState createState() => _SubMenuScreenState();
}

class _SubMenuScreenState extends State<SubMenuScreen> {
  List selectedItemsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: LoginChecker(),
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          child: FutureBuilder(
            future: planmealsetupGet(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                print(snapshot.data);
              }
              print(snapshot.connectionState);
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data['data'][0]['ShortName'] != null) {
                  var showData = snapshot.data;
                  var showDataList = showData["data"];

                  //INCLUDE A DIVIDER IF REQUIRED
                  return Container(
                    // height: 500,
                    // color: Colors.blue,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: showData['data'].length,
                      itemBuilder: (context, index) {
                        // return Container(
                        //   height: 150,
                        //   width: 150,
                        //   color: Colors.red,
                        // );
                        return CustomCard(
                          isSubscreen: true,
                          onTap: () {
                            Get.to(
                              MealDetailPage(),
                              arguments: showData['data'][index],
                            );
                          },
                          image: showData['data'][index]['ProdName3'],
                          title: showData['data'][index]['ProdName1'],
                        );
                      },
                    ),
                  );
                }
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
              return Center(
                child: Text(snapshot.data['data'][0]['ShortName']),
              );
            },
          ),
        ),
      ),
    );
  }

  Future planmealsetupGet() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('title', widget.title!);
    preferences.setString('arabicName', widget.arabicName!);
    DateTime dateTime = DateTime.now();
    print("Meal type:${widget.mealType}");
    var params = {
      'TenentID': TenentID.toString(),
      'PlanID': widget.id.toString(),
      'MealType': widget.mealType.toString(),
      'Date': '${dateTime.month}-${dateTime.day}-${dateTime.year}'
    };
    http.Response response = await http.post(
        Uri.parse(
            'https://foodapi.pos53.com/api/Food/Planmealsetupkitchen_Get'),
        body: params);
    if (jsonDecode(response.body)['status'] == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
