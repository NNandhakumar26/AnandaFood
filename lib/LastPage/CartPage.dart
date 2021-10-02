import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Theme.dart';
import 'ItemCardListTile.dart';

class CartPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
        titleTextStyle: Style.subtitle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
          color: Style.white.withOpacity(0.87),
        ),
        centerTitle: true,
        shadowColor: Style.prime[50],
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: Style.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 8,
        backgroundColor: Style.prime[900],
      ),
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 16,
                ),
                Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Style.accent[300]!,
                      width: 0.8,
                    ),
                    borderRadius: BorderRadius.circular(4),
                    color: Style.accent[50]!.withOpacity(0.032),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: Icon(
                              Icons.calendar_today_sharp,
                              color: Style.accent[900],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 8,
                            ),
                            child: Text('26 - 06 - 199'),
                          )
                        ],
                      ),
                      ItemCardListTile(),
                      ItemCardListTile(),
                      ItemCardListTile(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Style.accent[300]!,
                      width: 0.8,
                    ),
                    borderRadius: BorderRadius.circular(4),
                    color: Style.accent[50]!.withOpacity(0.032),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: Icon(
                              Icons.calendar_today_sharp,
                              color: Style.accent[900],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 8,
                            ),
                            child: Text('26 - 06 - 199'),
                          )
                        ],
                      ),
                      ItemCardListTile(),
                      ItemCardListTile(),
                      ItemCardListTile(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Style.accent[300]!,
                      width: 0.8,
                    ),
                    borderRadius: BorderRadius.circular(4),
                    color: Style.accent[50]!.withOpacity(0.032),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: Icon(
                              Icons.calendar_today_sharp,
                              color: Style.accent[900],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 8,
                            ),
                            child: Text('26 - 06 - 199'),
                          )
                        ],
                      ),
                      ItemCardListTile(),
                      ItemCardListTile(),
                      ItemCardListTile(),
                    ],
                  ),
                ),
                ItemCardListTile(),
                ItemCardListTile(),
                ItemCardListTile(),
                ItemCardListTile(),
                ItemCardListTile(),
                ItemCardListTile(),
                ItemCardListTile(),
                ItemCardListTile(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
