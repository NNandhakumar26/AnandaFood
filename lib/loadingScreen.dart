import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
