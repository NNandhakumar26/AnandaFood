import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Theme.dart';

class ColumnText extends StatelessWidget {
  final String title;
  final String subtitle;
  ColumnText({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: Style.subtitle.copyWith(
              color: Style.accent[300],
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            subtitle,
            style: Style.subtitle.copyWith(
              color: Style.accent[900],
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
