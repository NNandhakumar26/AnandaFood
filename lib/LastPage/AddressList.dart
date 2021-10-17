import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subscription_mobile_app/LastPage/addressPage.dart';
import 'package:subscription_mobile_app/SecondPage/MealsAvailableScreen.dart';

import '../Theme.dart';

class AddressList extends StatefulWidget {
  const AddressList({Key? key}) : super(key: key);

  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  List addressList = [];
  bool _isLoading = true;

  @override
  void initState() {
    getAddressList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(AddressPage());
        },
        backgroundColor: Style.accent[700],
        elevation: 8,
        extendedPadding: EdgeInsets.all(8),
        icon: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: Icon(
            Icons.add,
            color: Style.white.withOpacity(0.87),
            size: 16,
          ),
        ),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Text(
            "add_address".tr,
            style: Style.subtitle.copyWith(
              fontSize: 16,
              letterSpacing: 0.8,
              color: Style.white.withOpacity(0.87),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              // Expanded(
              //   flex: 1,
              //   child: Container(),
              // ),
              Expanded(
                flex: 8,
                child: (_isLoading)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : (addressList.isEmpty)
                        ? Center(
                            child: Container(
                              child: Text(
                                'empty'.tr,
                                style: Style.subtitle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Style.accent[900],
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: addressList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return AddressCard(
                                  name: addressList[index]['GoogleName'],
                                  address: addressList[index]['AddressName1'],
                                  city: addressList[index]['CITY'],
                                  state: addressList[index]['STATE'],
                                  country: addressList[index]['STATE'],
                                );
                              },
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getAddressList() async {
    var pref = await SharedPreferences.getInstance();
    var custId = pref.get('custID');
    Map<String, String> body = {
      'TenentID': TenentID.toString(),
      'CUSERID': custId.toString(),
    };

    var response = await http.post(
        Uri.parse('https://foodapi.pos53.com/api/Food/FetchAddressList'),
        body: body);
    if (response.statusCode < 299) {
      var body = jsonDecode(response.body)['data'] as List;
      List values = [];
      for (var address in body) {
        values.add(address);
      }
      setState(() {
        addressList.addAll(values);
        _isLoading = false;
      });
    }
    for (var val in addressList) {
      print(val);
    }
  }
}

class AddressCard extends StatelessWidget {
  final String name;
  final String address;
  final String city;
  final String state;
  final String country;

  AddressCard({
    this.name = '',
    this.address = '',
    this.city = '',
    this.state = '',
    this.country = '',
  });

  final thisStyle = Style.subtitle.copyWith(
    fontSize: 14,
    color: Style.accent[300],
    letterSpacing: 0.4,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 4.2,
      width: Get.width,
      // decoration: BoxDecoration(
      //   color: Style.prime[50]!.withOpacity(0.60),
      //   borderRadius: BorderRadius.circular(8),
      // ),
      child: Card(
        color: Style.white,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        elevation: 8,
        shadowColor: Style.accent[50]!.withOpacity(0.32),
        child: ListTile(
          tileColor: Style.prime[50]!.withOpacity(0.08),
          leading: Text(
            name,
            style: thisStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Style.prime[700],
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Expanded(
                //   child: Text(
                //     name,
                //     style: thisStyle.copyWith(
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //       color: Style.prime,
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Text(
                    '$address,',
                    style: thisStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    '$city,',
                    style: thisStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    state,
                    style: thisStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
