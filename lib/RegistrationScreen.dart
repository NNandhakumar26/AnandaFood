import 'dart:convert';
import 'package:flutter/animation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subscription_mobile_app/Theme.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController compName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  // TextEditingController countryId = TextEditingController();
  // TextEditingController state = TextEditingController();
  String add = 'ADD';
  List<bool> genderSelected = [true, false];

  List<StateData> stateList = [];
  List<DropdownMenuItem> menuItems = [];
  int _value = 0;

  List cityList = [];
  List<DropdownMenuItem> cityListItems = [];
  int _cityValue = 0;

  @override
  void initState() {
    getStateList();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    compName.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    // countryId.dispose();
    // state.dispose();
    // gender.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Registration Screen'),
          foregroundColor: Style.white.withOpacity(0.97),
          centerTitle: true,
          backgroundColor: Style.prime[700],
          elevation: 6,
          shadowColor: Style.accent[50],
          leading: IconButton(
            onPressed: () => Get.back(result: 1),
            icon: Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: Style.white,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: Get.height,
              width: Get.width,
              color: Style.prime[50]!.withOpacity(0.08),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height / 22,
                  ),
                  TextFormField(
                    controller: compName,
                    cursorColor: Style.accent,
                    style: thisPageStyle,
                    textAlign: TextAlign.left,
                    decoration: Style.inputTextDecoration(
                      title: "full_name".tr,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Style.accent,
                    style: thisPageStyle,
                    textAlign: TextAlign.left,
                    decoration: Style.inputTextDecoration(
                      title: "email_address".tr,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: phone,
                    cursorColor: Style.accent,
                    style: thisPageStyle,
                    textAlign: TextAlign.left,
                    decoration: Style.inputTextDecoration(
                      title: "phone_number".tr,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    cursorColor: Style.accent,
                    style: thisPageStyle,
                    textAlign: TextAlign.left,
                    decoration: Style.inputTextDecoration(
                      title: "password".tr,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: Get.width / 1.15,
                    child: DropdownButton<dynamic>(
                      focusColor: Style.accent[50],
                      hint: Text('your_state'.tr),
                      value: _value,
                      isExpanded: true,
                      style: Style.title.copyWith(fontSize: 14),
                      items: (stateList.isEmpty) ? [] : menuItems,
                      onChanged: (value) {
                        setState(
                          () {
                            _value = value as int;
                            _cityValue = 0;
                          },
                        );
                        getCityList();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: Get.width / 1.15,
                    child: DropdownButton<dynamic>(
                      focusColor: Style.accent,
                      hint: Text('your_city'.tr),
                      style:
                          Style.title.copyWith(fontSize: 14, color: Colors.red),
                      value: _cityValue,
                      isExpanded: true,
                      items: (cityListItems.isEmpty) ? [] : cityListItems,
                      onChanged: (value) {
                        setState(
                          () {
                            _cityValue = value;
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ToggleButtons(
                    color: Style.accent[300],
                    selectedColor: Style.white,
                    borderColor: Style.accent,
                    fillColor: Style.prime[300],
                    selectedBorderColor: Style.prime[500]!.withOpacity(0.87),
                    borderRadius: BorderRadius.circular(10),
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        width: Get.width * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Male'),
                            Icon(Icons.male),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        width: Get.width * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.female),
                            Text('Female'),
                          ],
                        ),
                      ),
                    ],
                    onPressed: (int index) {
                      setState(
                        () {
                          for (int buttonIndex = 0;
                              buttonIndex < genderSelected.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              genderSelected[buttonIndex] = true;
                            } else {
                              genderSelected[buttonIndex] = false;
                            }
                          }
                        },
                      );
                    },
                    isSelected: genderSelected,
                  ),
                  // ToggleButtons(
                  //   color: Style.accent.withOpacity(0.87),
                  //   selectedColor: Style.background,
                  //   borderColor: Style.accent,
                  //   fillColor: Style.accent.withOpacity(0.60),
                  //   selectedBorderColor: Style.primary.withOpacity(0.87),
                  //   borderRadius: BorderRadius.circular(10),
                  //   children: <Widget>[
                  //     Container(
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 10, vertical: 5),
                  //       width: MediaQuery.of(context).size.width * 0.25,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text('Male'),
                  //           Icon(Icons.male),
                  //         ],
                  //       ),
                  //     ),
                  //     Container(
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 10, vertical: 5),
                  //       width: MediaQuery.of(context).size.width * 0.25,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Icon(Icons.female),
                  //           Text('Female'),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  //   onPressed: (int index) {
                  //     setState(() {
                  //       for (int buttonIndex = 0;
                  //           buttonIndex < genderSelected.length;
                  //           buttonIndex++) {
                  //         if (buttonIndex == index) {
                  //           genderSelected[buttonIndex] = true;
                  //         } else {
                  //           genderSelected[buttonIndex] = false;
                  //         }
                  //       }
                  //     });
                  //   },
                  //   isSelected: genderSelected,
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      print(compName.text);
                      print(phone.text);
                      print(email.text);
                      print(password.text);
                      if (compName.text.isNotEmpty &&
                          phone.text.isNotEmpty &&
                          email.text.isNotEmpty &&
                          password.text.isNotEmpty) {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(
                              Duration(seconds: 2),
                              () async {
                                try {
                                  http.Response response = await http.post(
                                    Uri.parse(
                                        "https://foodapi.pos53.com/api/Food/CompanySetupSave"),
                                    body: {
                                      'TenentID': TenentID.toString(),
                                      'COMPNAME1': compName.text,
                                      'EMAIL': email.text,
                                      'MOBPHONE': phone.text,
                                      'CPASSWRD': password.text,
                                      'COUNTRYID': '1',
                                      'STATE': stateList[_value].stateName,
                                      'Gender':
                                          genderSelected[0] ? 'Male' : 'Female',
                                      'Action': 'ADD',
                                      'CITY': cityList[_cityValue]
                                    },
                                  );
                                  print(jsonDecode(response.body));
                                  if (jsonDecode(response.body)['status'] ==
                                      200) {
                                    Get.back();
                                    Get.back(result: 1);

                                    Get.snackbar(
                                      'Response',
                                      '${jsonDecode(response.body)['message']}',
                                      duration: Duration(seconds: 2),
                                      margin: EdgeInsets.all(16),
                                      padding: EdgeInsets.all(16),
                                      // animationDuration: Duration(milliseconds: 500),
                                      forwardAnimationCurve: Curves.easeInCubic,
                                      titleText: Text(
                                        'Response',
                                        style: Style.subtitle.copyWith(
                                          color: Style.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      messageText: Text(
                                        '${jsonDecode(response.body)['message']}',
                                        style: Style.subtitle.copyWith(
                                          color: Style.white,
                                        ),
                                      ),
                                      colorText: Style.white,
                                      borderRadius: 8,
                                      backgroundColor:
                                          Style.accent[300]!.withOpacity(0.87),
                                    );
                                  } else {
                                    Get.back();
                                    compName.clear();
                                    email.clear();
                                    password.clear();
                                    phone.clear();
                                    Get.snackbar(
                                      'Response',
                                      jsonDecode(response.body)['message'],
                                      duration: Duration(seconds: 2),
                                      margin: EdgeInsets.all(16),
                                      padding: EdgeInsets.all(16),
                                      forwardAnimationCurve: Curves.easeInCubic,
                                      titleText: Text(
                                        'Response',
                                        style: Style.subtitle.copyWith(
                                          color: Style.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      messageText: Text(
                                        jsonDecode(response.body)['message'],
                                        style: Style.subtitle.copyWith(
                                          color: Style.white,
                                        ),
                                      ),
                                      colorText: Style.white,
                                      borderRadius: 8,
                                      backgroundColor:
                                          Style.accent[300]!.withOpacity(0.87),
                                    );
                                  }
                                } catch (e) {
                                  Get.back();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('error'.tr),
                                        content: Text('some_error'.tr),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text('ok'.tr),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                            );
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                  Style.prime,
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        Get.snackbar(
                          '',
                          'enter_all_detail'.tr,
                          margin: EdgeInsets.all(16),
                          padding: EdgeInsets.all(16),
                          snackPosition: SnackPosition.BOTTOM,
                          // animationDuration: Duration(milliseconds: 500),
                          forwardAnimationCurve: Curves.easeInCubic,
                          titleText: Text(
                            'enter_all_detail'.tr,
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
                      }
                    },
                    child: Container(
                      height: 50.0,
                      width: 350,
                      child: Material(
                        borderRadius: BorderRadius.circular(24.0),
                        shadowColor: Style.accent[50]!.withOpacity(0.60),
                        color: Style.prime[900],
                        elevation: 8.0,
                        child: Center(
                          child: Text(
                            'signup'.tr,
                            style: Style.title.copyWith(
                              color: Style.white.withOpacity(0.87),
                              letterSpacing: 1.6,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle thisPageStyle = Style.subtitle.copyWith(
    color: Style.accent[600],
    letterSpacing: 0.4,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  Future getStateList() async {
    var response = await http
        .post(Uri.parse('https://foodapi.pos53.com/api/Food/DeliveryStateGet'));

    List<StateData> statesToAdd = [];
    List<DropdownMenuItem> itemList = [];

    if (response.statusCode <= 299) {
      var body = jsonDecode(response.body)['data'];
      int index = 0;
      for (var state in body) {
        var newState =
            StateData(state['StateName'] as String, state['StateID']);
        statesToAdd.add(newState);
        itemList.add(DropdownMenuItem(
          child: Text(
            state['StateName'] as String,
            style: Style.subtitle.copyWith(
              letterSpacing: 0.4,
              color: Style.accent[300],
            ),
          ),
          value: index,
        ));
        index++;
      }
    }

    setState(() {
      if (statesToAdd.isNotEmpty) {
        stateList.addAll(statesToAdd);
        menuItems.addAll(itemList);
      }
    });
    getCityList();
  }

  Future<void> getCityList() async {
    var stateId = stateList[_value].stateId;
    var cities = [];
    List<DropdownMenuItem> cityItems = [];
    var response = await http.post(
        Uri.parse('https://foodapi.pos53.com/api/Food/DeliveryCityGet'),
        body: {'StateID': stateId.toString()});
    print(response.statusCode);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      print(body['data']);
      int i = 0;
      for (var city in body['data']) {
        cities.add(city['CityEnglish']);
        cityItems.add(DropdownMenuItem(
          child: Text(
            city['CityEnglish'],
            style: Style.subtitle.copyWith(
              letterSpacing: 0.4,
              color: Style.accent[300],
            ),
          ),
          value: i,
        ));
        i++;
        print(city);
      }
    }

    setState(() {
      if (cities.isNotEmpty) {
        if (cityList.isNotEmpty) {
          cityList.clear();
          cityListItems.clear();
        }
        cityList.addAll(cities);
        cityListItems.addAll(cityItems);
      }
    });
    print(cityList);
  }
}

class StateData {
  String stateName;
  int stateId;

  StateData(this.stateName, this.stateId);

  @override
  String toString() {
    return 'stateName: $stateName, stateId: $stateId';
  }
}
