import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subscription_mobile_app/LastPage/ColumnText.dart';

import '../Theme.dart';

class ContractPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contract Page'),
        centerTitle: true,
        backgroundColor: Style.prime[900],
        foregroundColor: Style.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: Get.height / 1.2,
            width: Get.width,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Card(
                    margin: EdgeInsets.all(32),
                    color: Style.white,
                    elevation: 20,
                    shadowColor: Style.accent[50]!.withOpacity(0.60),
                    borderOnForeground: true,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: ColumnText(
                                        title: 'Total Days', subtitle: '26')),
                                VerticalDivider(
                                  color: Style.accent[50],
                                  indent: 8,
                                  endIndent: 8,
                                  thickness: 0.60,
                                  width: 8,
                                ),
                                Expanded(
                                  child: ColumnText(
                                      title: 'Sub Days', subtitle: '26'),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.all(4),
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 24),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Style.accent[300]!,
                                  width: 0.4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.8, 1.6),
                                    color: Style.accent[50]!.withOpacity(0.60),
                                    blurRadius: 8,
                                    spreadRadius: 1.6,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(4),
                                color: Style.white,
                              ),
                              // color: Style.white,
                              // elevation: 20,
                              // shadowColor:
                              //     Style.accent[50]!.withOpacity(0.60),
                              // borderOnForeground: true,
                              child: Text(
                                '99 Kd',
                                style: Style.subtitle.copyWith(
                                  color: Style.prime[900],
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.8,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              NewWidget(
                                title: 'Contract Date',
                              ),
                              NewWidget(
                                title: 'Begin Date',
                              ),
                              NewWidget(
                                title: 'End Date',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 50.0,
                          // width: Get.width / 1.1,
                          width: 350,
                          child: Material(
                            borderRadius: BorderRadius.circular(24.0),
                            shadowColor: Style.accent,
                            color: Style.prime[900],
                            elevation: 7.0,
                            child: Center(
                              child: Text(
                                'Confirm',
                                style: Style.subtitle.copyWith(
                                  color: Style.white,
                                  letterSpacing: 2.0,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      // Expanded(child: Container())
                    ],
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

class NewWidget extends StatelessWidget {
  final String title;

  NewWidget({this.title = ''});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      initialValue:
          '${DateTime.now().day.toString()} - ${DateTime.now().month.toString()} - ${DateTime.now().year.toString()}',
      decoration: Style.inputTextDecoration(
        title: title,
      ).copyWith(
        prefixIcon: Icon(
          Icons.calendar_today_rounded,
          color: Style.prime[900],
        ),
        contentPadding: EdgeInsets.all(16),
        prefixStyle: Style.subtitle.copyWith(
          color: Style.prime[900],
        ),
      ),
      onTap: () async {
        var date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        // dateController.text = date.toString().substring(0,10);
      },
      cursorColor: Style.accent[700],
      style: Style.subtitle.copyWith(
        color: Style.accent[500],
        letterSpacing: 0.8,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
