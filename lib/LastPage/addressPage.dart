import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddressPage'),
      ),
      body: SafeArea(
        child: Text('AddressController'),
      ),
    );
  }
}
