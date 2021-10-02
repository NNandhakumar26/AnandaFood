import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subscription_mobile_app/SecondPage/Second_Main.dart';
import 'package:subscription_mobile_app/loadingScreen.dart';

import 'LoginScreen.dart';
import 'Theme.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  bool isLoading = true;
  var prefs;
  Map<String, List<Group>> groups = {'active': [], 'inActive': []};

  @override
  void initState() {
    super.initState();
    _loadJson(); //P->readJson // loading from local data
  }

  Future<bool> onWillPop() async {
    return await Get.dialog(
      AlertDialog(
        title: Text(
          'you_sure'.tr,
          style: Style.subtitle.copyWith(
            color: Style.accent[700],
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 16,
        actionsPadding: EdgeInsets.symmetric(
          horizontal: 8,
        ),
        content: Text(
          'exit_app'.tr,
          style: Style.subtitle.copyWith(
            color: Style.accent[500],
            fontSize: 14,
            letterSpacing: 0.4,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
              foregroundColor: MaterialStateProperty.all(Colors.black87),
            ),
            onPressed: () {
              // Get.back(canPop: false);
              Navigator.of(context).pop(false);
            },
            child: Text(
              'no'.tr,
              style: Style.subtitle.copyWith(
                color: Style.accent[700],
                fontSize: 16,
                letterSpacing: 0.8,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
              backgroundColor: MaterialStateProperty.all(Style.prime),
              foregroundColor: MaterialStateProperty.all(
                Colors.white,
              ),
            ),
            onPressed: () async {
              // Get.back(canPop: true);
              Navigator.of(context).pop(true);
            },
            child: Text(
              'yes'.tr,
              style: Style.subtitle.copyWith(
                color: Style.white,
                fontSize: 16,
                letterSpacing: 0.8,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
    // return showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //         title: Text('you_sure'.tr),
    //         content: Text('exit_app'.tr),
    //         actions: <Widget>[
    //           ElevatedButton(
    //             onPressed: () => Navigator.of(context).pop(false),
    //             child: Text('no'.tr),
    //           ),
    //           ElevatedButton(
    //             onPressed: () => exit(0),
    //             /*Navigator.of(context).pop(true)*/
    //             child: Text('yes'.tr),
    //           ),
    //         ],
    //       ),
    //     );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        floatingActionButton: LoginChecker(),
        body: SafeArea(
          child: (isLoading)
              ? LoadingScreen()
              : SecondPage(
                  groups: groups,
                  isLoggedIn: false,
                ),
        ),
      ),
    );
  }

  Future<void> _loadJson() async {
    setState(
      () {
        isLoading = true;
      },
    );
    //TODO: TRY REMOVING THESE TWO SETS
    Set<Group> uniqueGroupActive = {};
    Set<Group> uniqueGroupInActive = {};
    var txtData = await DefaultAssetBundle.of(context)
        .loadString("assets/json/newplan2.json");
    var jsonData = jsonDecode(txtData);
    var dataList = jsonData['NEwPlanMeal'] as List;

    for (var element in dataList) {
      var item = Group(
          groupName: element['GroupName'],
          groupId: int.parse(element['GroupID']));
      if (element['ACTIVE'] != '0') {
        uniqueGroupActive.add(item);
      } else {
        uniqueGroupInActive.add(item);
      }
    }

    print(uniqueGroupActive);
    print(uniqueGroupInActive);
    setState(
      () {
        groups['active']!.addAll(uniqueGroupActive);
        groups['inActive']!.addAll(uniqueGroupInActive);
        isLoading = false;
      },
    );
    print(groups);
  }
}

class LoginChecker extends StatelessWidget {
  const LoginChecker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPreferences(),
      builder: (context, AsyncSnapshot snap) {
        if (snap.connectionState == ConnectionState.done) {
          if (snap.data.get('custID') != null) {
            return Container();
          } else {
            return FloatingActionButton.extended(
              backgroundColor: Style.accent[700],
              extendedPadding: EdgeInsets.all(20),
              elevation: 8,
              isExtended: true,
              onPressed: () async {
                Get.dialog(
                  Container(
                    margin: EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: Get.height / 8,
                    ),
                    child: LoginPopupContainer(),
                  ),
                  barrierDismissible: false,
                );
              },
              label: Text(
                'login'.tr,
                style: Style.subtitle.copyWith(
                  color: Style.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.8,
                ),
              ),
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}

class Group {
  String? groupName;
  int? groupId;

  Group({
    this.groupName,
    this.groupId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Group &&
          runtimeType == other.runtimeType &&
          groupName == other.groupName &&
          groupId == other.groupId;

  @override
  int get hashCode => groupName.hashCode ^ groupId.hashCode;

  @override
  String toString() {
    return '${this.groupName} -> ${this.groupId}';
  }
}
