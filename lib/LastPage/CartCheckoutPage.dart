import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subscription_mobile_app/database/dbhelper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Theme.dart';

class CartCheckout extends StatefulWidget {
  const CartCheckout({Key? key}) : super(key: key);

  @override
  _CartCheckoutState createState() => _CartCheckoutState();
}

class _CartCheckoutState extends State<CartCheckout> {
  List addressList = [];
  bool _isLoading = true;
  var _currentAddress;
  DateTime? _selectedDay;
  DateClass? _currentValue;
  var db = DatabaseHelper.instance;
  String? name;

  bool isLoading = false;
  List months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  List<DateClass> dates = [];
  Map<String, String> foodNames = {
    '1401': 'BreakFast',
    '1402': 'Lunch',
    '1403': 'Dinner',
    '1404': 'Snack',
    '1405': 'Salad',
    '1406': 'Soup'
  };

  Map<String, List> food = {
    '1401': [],
    '1402': [],
    '1403': [],
    '1404': [],
    '1405': [],
    '1406': []
  };

  @override
  void initState() {
    super.initState();
    getAddressList();
    getUniqueDate();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void getUniqueDate() async {
    var rows = await db.getFirstWeekUniqueData();
    List<DateClass> datesToAdd = [];
    for (var row in rows) {
      List<int> dateString = (row['expectedDelDate'] as String)
          .split('/')
          .map((e) => int.parse(e))
          .toList();
      DateTime date = DateTime(dateString[2], dateString[0], dateString[1]);
      var newDate = DateClass(date, row['dayNumber']);
      datesToAdd.add(newDate);
      datesToAdd.sort();
    }
    setState(() {
      dates.addAll(datesToAdd);
      // _selectedDay = dates.first.date;
      // _currentValue = dates.first;
    });
    for (var date in dates) {
      print(date);
    }
    // await getDatesData() ;
  }

  Future<void> getAddressList() async {
    var pref = await SharedPreferences.getInstance();
    var custId = pref.get('custID');
    setState(() {
      name = pref.getString('compName');
    });
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
        if (values.isNotEmpty) {
          addressList.addAll(values);
          _isLoading = false;
          _currentAddress = addressList.first;
        }
      });
    }
    for (var val in addressList) {
      print(val);
    }
  }
}

class DateClass implements Comparable<DateClass> {
  DateTime date;
  int dayNumber;

  DateClass(this.date, this.dayNumber);

  @override
  int compareTo(DateClass other) {
    return this.date.compareTo(other.date);
  }

  @override
  String toString() {
    return '${date.month}/${date.day}/${date.year} -> $dayNumber';
  }
}
