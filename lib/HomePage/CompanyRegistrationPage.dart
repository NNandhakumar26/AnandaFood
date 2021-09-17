import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:subscription_mobile_app/Theme.dart';

class CompanyRegistrationpage extends StatelessWidget {
  const CompanyRegistrationpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register Your Company'),
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
        body: SingleChildScrollView(
          child: Container(
            color: Style.prime[50]!.withOpacity(0.068),
            height: Get.height / 1.12,
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //COMPANY NAME, OWNER NAME, MOBILE, EMAIL, REMARKS
                //SEARCH ROW WITH ADD YOUR COMPANY

                TextFormField(
                  decoration: inputTextDecoration(
                    title: 'Company Name',
                  ),
                  cursorColor: Style.accent[700],
                  style: Style.subtitle.copyWith(
                    color: Style.accent[600],
                    letterSpacing: 0.4,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextFormField(
                  decoration: inputTextDecoration(
                    title: 'Owner Name',
                  ),
                  cursorColor: Style.accent[700],
                  style: Style.subtitle.copyWith(
                    color: Style.accent[600],
                    letterSpacing: 0.4,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: inputTextDecoration(
                    title: 'Mobile Number',
                  ),
                  cursorColor: Style.accent[700],
                  style: Style.subtitle.copyWith(
                    color: Style.accent[600],
                    letterSpacing: 0.4,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: inputTextDecoration(
                    title: 'Email Address',
                  ),
                  cursorColor: Style.accent[700],
                  style: Style.subtitle.copyWith(
                    color: Style.accent[600],
                    letterSpacing: 0.4,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextFormField(
                  decoration: inputTextDecoration(
                    title: 'Remarks',
                  ),
                  cursorColor: Style.accent[700],
                  maxLines: 5,
                  style: Style.subtitle.copyWith(
                    color: Style.accent[600],
                    letterSpacing: 0.4,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 24, vertical: 8)),
                      backgroundColor:
                          MaterialStateProperty.all(Style.accent[500]),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Submit',
                      style: Style.subtitle.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: 0.8,
                        color: Style.white.withOpacity(0.87),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputTextDecoration({String title = ''}) {
    return InputDecoration(
      filled: true,
      fillColor: Style.accent[50]!.withOpacity(0.10),
      contentPadding: EdgeInsets.all(16),
      labelText: title,
      floatingLabelStyle: Style.caption.copyWith(
        color: Style.prime[900],
        letterSpacing: 0.8,
        fontSize: 12,
      ),
      labelStyle: Style.subtitle.copyWith(
        color: Style.accent[500],
        fontSize: 14,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        gapPadding: 4.0,
        borderSide: BorderSide(
          width: 0.8,
          color: Style.accent[600]!,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        gapPadding: 4.0,
        borderSide: BorderSide(
          width: 0.8,
          color: Style.prime[900]!,
        ),
      ),
    );
  }
}
