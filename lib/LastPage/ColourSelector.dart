import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subscription_mobile_app/Lang/localization_service.dart';
import 'package:subscription_mobile_app/LastPage/AddressList.dart';

import 'package:subscription_mobile_app/groupPage.dart';

import '../LoginScreen.dart';
import '../Theme.dart';
import 'ContractScreen.dart';

class ColourPicker extends StatefulWidget {
  const ColourPicker({Key? key}) : super(key: key);

  @override
  _ColourPickerState createState() => _ColourPickerState();
}

class _ColourPickerState extends State<ColourPicker> {
  final storage = GetStorage();
  String? userID;
  String? lng;

  late Color dialogSelectColor;

  @override
  void initState() {
    super.initState();
    lng = LocalizationService().getCurrentLang();

    // A purple color.,
    dialogSelectColor = Color(int.parse('0xFF' + storage.read('primary')));
  }

  Future sharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      setState(() {
        userID = prefs.get('custID').toString();
      });
      return prefs;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // const Color guidePrimary = Color(0xFF6200EE);
    // const Color guidePrimaryVariant = Color(0xFF3700B3);
    // const Color guideSecondary = Color(0xFF03DAC6);
    // const Color guideSecondaryVariant = Color(0xFF018786);
    // const Color guideError = Color(0xFFB00020);
    // const Color guideErrorDark = Color(0xFFCF6679);
    // const Color blueBlues = Color(0xFF174378);
    // final Map<ColorSwatch<Object>, String> customSwatches =
    //     <ColorSwatch<Object>, String>{
    //   const MaterialColor(
    //     0xFFb03a56,
    //     <int, Color>{
    //       50: Color(0xFFfffee9),
    //       100: Color(0xFFfff9c6),
    //       200: Color(0xFFfff59f),
    //       300: Color(0xFFfff178),
    //       400: Color(0xFFfdec59),
    //       500: Color(0xFFfae738),
    //       600: Color(0xFFf3dd3d),
    //       700: Color(0xFFdfc735),
    //       800: Color(0xFFcbb02f),
    //       900: Color(0xFFab8923),
    //     },
    //   ): 'Alpine',
    //   ColorTools.createPrimarySwatch(const Color(0xFFBC350F)): 'Rust',
    //   ColorTools.createAccentSwatch(const Color(0xFFB062DB)): 'Lavender',
    // };

    // // final Map<ColorSwatch<Object>, String> colorsNameMap =
    // //     <ColorSwatch<Object>, String>{
    // //   ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
    // //   ColorTools.createPrimarySwatch(guidePrimaryVariant):
    // //       'Guide Purple Variant',
    // //   ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
    // //   ColorTools.createAccentSwatch(guideSecondaryVariant):
    // //       'Guide Teal Variant',
    // //   ColorTools.createPrimarySwatch(guideError): 'Guide Error',
    // //   ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
    // //   ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
    // // };

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Row(
        //     children: [
        //       Container(
        //         alignment: Alignment.topRight,
        //         child: Text(
        //           'الملف الشخصي',
        //           style: Style.subtitle
        //               .copyWith(fontSize: 32, color: Colors.white),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(left: 10),
        //         child: Text(
        //           'Profile',
        //           style: Style.subtitle
        //               .copyWith(color: Colors.white, fontSize: 19),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Style.white,
                  elevation: 24,
                  shadowColor: Style.accent[50]!.withOpacity(0.24),
                  child: FutureBuilder(
                    future: sharedPref(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState != ConnectionState.none) {
                        if (snapshot.hasData) {
                          var email = snapshot.data.get('email');
                          var number = snapshot.data.get('number');
                          return ListTile(
                            onTap: () {
                              // Get.to(AboutPage());
                            },
                            contentPadding: EdgeInsets.all(10),
                            dense: true,
                            title: Container(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                email.toString(),
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.8,
                                  color: Style.accent[900]!.withOpacity(0.87),
                                ),
                              ),
                            ),
                            leading: CircleAvatar(
                              radius: 40,
                              foregroundColor: Style.prime,
                              backgroundColor: Style.prime,
                              foregroundImage:
                                  AssetImage('assets/images/Profile2.jpg'),
                              // child: (controller.imageUrl.value == null)
                              //     ? Container(
                              //         color: Styling.primary,
                              //       )
                              //     : Container(
                              //         height: 150.h,
                              //         width: 150.w,
                              //         decoration: new BoxDecoration(
                              //           shape: BoxShape.circle,
                              //           image: new DecorationImage(
                              //             fit: BoxFit.cover,
                              //             image: NetworkImage(
                              //                 controller.imageUrl.value.toString()),
                              //           ),
                              //         ),
                              //       ),
                            ),
                            trailing: SizedBox(
                              width: Get.width / 8,
                              child: Icon(
                                Icons.edit_outlined,
                                color: Style.accent[700],
                                size: 20,
                              ),
                            ),
                            subtitle: Text(
                              number.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.4,
                                color: Style.accent[300]!.withOpacity(0.60),
                                // color: lightTextColor,
                              ),
                            ),
                          );
                        } else
                          return Container(
                            child: Text(snapshot.hasError.toString()),
                          );
                      }
                      return Container();
                    },
                  ),
                  // ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ColourTool(
                  type: 'primary',
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ColourTool(
                  type: 'accent',
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Style.accent[300]!,
                    width: 0.4,
                  ),
                  borderRadius: BorderRadius.circular(4),
                  color: Style.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Others'.toUpperCase(),
                        style: Style.subtitle.copyWith(
                          color: Style.accent[900],
                          fontSize: 16,
                          letterSpacing: 0.48,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SettingsCard(
                          image: 'location (1).png',
                          title: 'address'.tr,
                          onPressed: () {
                            return Get.to(AddressList());
                          },
                        ),
                        SettingsCard(
                          image: 'support (1).png',
                          title: 'nutri_support'.tr,
                          onPressed: () {
                            Get.dialog(
                              Container(
                                margin: EdgeInsets.only(
                                  left: 24,
                                  right: 24,
                                  top: 48,
                                ),
                                child: LoginPopupContainer(),
                              ),
                              barrierDismissible: false,
                            );
                          },
                        ),
                        SettingsCard(
                          image: 'support (1).png',
                          title: 'tech_support'.tr,
                          onPressed: () {
                            Get.to(ContractPage());
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SettingsCard(
                          image: 'translation.png',
                          title: 'language'.tr,
                          onPressed: () {
                            Get.dialog(
                              Scaffold(
                                backgroundColor: Colors.transparent,
                                body: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 16),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 60, vertical: 260),
                                  color: Style.white,
                                  child: SingleChildScrollView(
                                    // child: Column(
                                    //   children: [
                                    //     RadioListTile(value: value, groupValue: groupValue, onChanged: onChanged)
                                    //     RadioListTile(value: value, groupValue: groupValue, onChanged: onChanged)
                                    //   ],
                                    // )
                                    child: Column(
                                      children: LocalizationService.langs.map(
                                        (String value) {
                                          return RadioListTile(
                                            title: Text(
                                              value.toString(),
                                              style: Style.subtitle.copyWith(
                                                fontSize: 16,
                                                color: Style.accent[700],
                                                letterSpacing: 0.8,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            tileColor:
                                                Style.white.withOpacity(0.87),
                                            value: value,
                                            groupValue: this.lng,
                                            onChanged: (String? values) async {
                                              setState(
                                                () {
                                                  this.lng = values;
                                                  LocalizationService()
                                                      .changeLocale(values!);
                                                },
                                              );
                                              Get.back();
                                            },
                                            // ),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            );
                            // Get.to(CartPage());
                          },
                        ),
                        SettingsCard(
                          image: 'whatsapp.png',
                          title: 'support'.tr,
                        ),
                        SettingsCard(
                          image: 'exit.png',
                          title: 'logout'.tr,
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.clear();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GroupPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  final String? image;
  final String? title;
  final Function? onPressed;

  SettingsCard({this.image, this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed!(),
      child: Card(
        elevation: 8,
        shadowColor: Style.accent[50]!.withOpacity(0.24),
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Style.accent[50]!.withOpacity(0.32),
            width: 0.8,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Image(
                  image: AssetImage('assets/images/$image'),
                  height: 40,
                  width: 40,
                  color: (image != 'whatsapp.png')
                      ? Style.prime[900]
                      : Colors.red.withOpacity(0.1),
                ),
              ),
              Container(
                width: Get.width / 4,
                height: Get.height / 16,
                margin: EdgeInsets.symmetric(vertical: 4),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    title ?? '',
                    textAlign: TextAlign.center,

                    style: Style.subtitle.copyWith(
                      fontSize: 14,
                      color: Style.accent[300],
                      fontWeight: FontWeight.w500,
                    ),
                    softWrap: true,
                    // overflow: ,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColourTool extends StatefulWidget {
  final String type;
  const ColourTool({Key? key, required this.type}) : super(key: key);

  @override
  _ColourToolState createState() => _ColourToolState();
}

class _ColourToolState extends State<ColourTool> {
  final storage = GetStorage();

  late Color dialogSelectColor;

  @override
  void initState() {
    super.initState();

    // A purple color.,
    dialogSelectColor = Color(int.parse('0xFF' + storage.read(widget.type)));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Style.accent[50]!.withOpacity(0.32),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: ListTile(
          onTap: () async {
            final Color newColor = await showColorPickerDialog(
              // The dialog needs a context, we pass it in.
              context,
              // We use the dialogSelectColor, as its starting color.
              dialogSelectColor,
              title: Text('ColorPicker',
                  style: Theme.of(context).textTheme.headline6),
              width: 40,
              height: 40,
              spacing: 0,
              runSpacing: 0,
              borderRadius: 0,
              wheelDiameter: 165,
              enableOpacity: true,
              showColorCode: true,
              colorCodeHasColor: true,
              //CHECK WHAT IT IS
              // customColorSwatchesAndNames: customSwatches,

              pickersEnabled: <ColorPickerType, bool>{
                ColorPickerType.wheel: true,
                ColorPickerType.primary: false,
                ColorPickerType.accent: false,
              },
              copyPasteBehavior: const ColorPickerCopyPasteBehavior(
                copyButton: true,
                pasteButton: false,
                longPressMenu: false,
              ),
              actionButtons: const ColorPickerActionButtons(
                okButton: true,
                closeButton: true,
                dialogActionButtons: true,
              ),
              constraints: const BoxConstraints(
                minHeight: 480,
                minWidth: 320,
                maxWidth: 320,
              ),
            );

            setState(
              () {
                dialogSelectColor = newColor;
                storage.write(
                    widget.type,
                    dialogSelectColor
                        .toString()
                        .toUpperCase()
                        .replaceAll('COLOR(0XFF', '')
                        .replaceAll(')', ''));
                Get.snackbar(
                    'Hey User', 'Restart Application to see colour change');
                print('colur value is ${storage.read(widget.type)}');
              },
            );
          },
          dense: true,
          title: Text(
            '${widget.type.toUpperCase()} Colour'.toUpperCase(),
            style: Style.subtitle.copyWith(
              fontWeight: FontWeight.w600,
              color: Style.accent[500],
            ),
          ),
          subtitle: Text(
            '${ColorTools.materialNameAndCode(
              dialogSelectColor,
            )} '
            ' --->   ${ColorTools.nameThatColor(dialogSelectColor)}',
            style: Style.subtitle.copyWith(
              fontWeight: FontWeight.w400,
              color: Style.accent[300],
              fontSize: 12,
            ),
          ),
          leading: ColorIndicator(
            width: 40,
            height: 40,
            borderRadius: 0,
            color: dialogSelectColor,
            elevation: 1,
            onSelectFocus: false,
            onSelect: () async {
              // Wait for the dialog to return color selection result.
              // final Color newColor = await showColorPickerDialog(
              //   // The dialog needs a context, we pass it in.
              //   context,
              //   // We use the dialogSelectColor, as its starting color.
              //   dialogSelectColor,
              //   title: Text('ColorPicker',
              //       style: Theme.of(context).textTheme.headline6),
              //   width: 40,
              //   height: 40,
              //   spacing: 0,
              //   runSpacing: 0,
              //   borderRadius: 0,
              //   wheelDiameter: 165,
              //   enableOpacity: true,
              //   showColorCode: true,
              //   colorCodeHasColor: true,
              //   //CHECK WHAT IT IS
              //   // customColorSwatchesAndNames: customSwatches,

              //   pickersEnabled: <ColorPickerType, bool>{
              //     ColorPickerType.wheel: true,
              //     ColorPickerType.primary: false,
              //     ColorPickerType.accent: false,
              //   },
              //   copyPasteBehavior: const ColorPickerCopyPasteBehavior(
              //     copyButton: true,
              //     pasteButton: false,
              //     longPressMenu: false,
              //   ),
              //   actionButtons: const ColorPickerActionButtons(
              //     okButton: true,
              //     closeButton: true,
              //     dialogActionButtons: true,
              //   ),
              //   constraints: const BoxConstraints(
              //     minHeight: 480,
              //     minWidth: 320,
              //     maxWidth: 320,
              //   ),
              // );

              // setState(
              //   () {
              //     dialogSelectColor = newColor;
              //     storage.write(
              //         widget.type,
              //         dialogSelectColor
              //             .toString()
              //             .toUpperCase()
              //             .replaceAll('COLOR(0XFF', '')
              //             .replaceAll(')', ''));
              //     Get.snackbar(
              //         'Hey User', 'Restart Application to see colour change');
              //     print('colur value is ${storage.read(widget.type)}');
              //   },
              // );
            },
          ),
        ),
      ),
    );
  }
}
