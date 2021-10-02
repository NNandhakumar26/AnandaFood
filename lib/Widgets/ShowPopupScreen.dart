import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopupContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final String? primaryText;
  final String? secondaryText;

  PopupContainer({
    required this.title,
    required this.subTitle,
    this.primaryText,
    this.secondaryText,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      elevation: 16,
      actionsPadding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 16,
      ),
      content: Text(subTitle),
      actions: [
        TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
            ),
            foregroundColor: MaterialStateProperty.all(Colors.black87),
          ),
          onPressed: () {
            Get.back();
          },
          child: Text(
            secondaryText ?? 'cancel'.tr,
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.all(16),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.purple),
            foregroundColor: MaterialStateProperty.all(
              Colors.white.withOpacity(0.87),
            ),
          ),
          onPressed: () async {
            Get.back();
          },
          child: Text(
            primaryText ?? 'ok'.tr,
          ),
        ),
      ],
    );
  }
}
