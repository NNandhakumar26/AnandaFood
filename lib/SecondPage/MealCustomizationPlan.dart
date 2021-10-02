import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Theme.dart';

class CustomMealPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F7FB),
      appBar: AppBar(
        backgroundColor: Style.white.withOpacity(0.87),
        centerTitle: true,
        title: Text('Custom Plan Screen'),
        titleTextStyle: Style.subtitle.copyWith(
          fontSize: 16,
          color: Style.prime[900],
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            CupertinoIcons.back,
            size: 18,
            color: Style.accent[400],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: Get.height,
            width: Get.width,
            color: Style.prime[50]!.withOpacity(0.016),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      height: Get.height / 8,
                      width: Get.width,
                      // margin: EdgeInsets.symmetric(horizontal: 8),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: ListTile(
                        // minLeadingWidth: Get.width / 24,
                        leading: CircleAvatar(
                          radius: 30,
                          foregroundImage: AssetImage(
                            'assets/images/Food1.png',
                          ),
                        ),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {},
                              color: Style.prime.withOpacity(0.87),
                              icon: Icon(
                                Icons.add,
                                color: Style.prime.withOpacity(0.87),
                                size: 16,
                              ),
                            ),
                            Text(
                              '2',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.remove,
                                size: 16,
                                color: Style.accent.withOpacity(0.87),
                              ),
                            ),
                          ],
                        ),
                        title: Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Breakfast',
                            style: Style.subtitle.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Style.accent,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                            text: 'Amount',
                            style: Style.subtitle.copyWith(
                              fontSize: 12,
                              color: Style.accent[50],
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: ' : ',
                              ),
                              TextSpan(
                                text: '0.0',
                                style: Style.title.copyWith(
                                  color: Style.prime[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: ' kd',
                                //also go with caption.
                                style: Style.subtitle.copyWith(
                                  color: Style.prime[200],
                                ),
                              ),
                            ],
                          ),
                        ),
                        dense: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                      ),
                    ),
                    Divider(
                      color: Style.accent[50],
                      thickness: 0.45,
                      indent: Get.width / 16,
                      endIndent: Get.width / 16,
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
