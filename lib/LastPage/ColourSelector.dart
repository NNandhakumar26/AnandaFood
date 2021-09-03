import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class ColourPicker extends StatefulWidget {
  const ColourPicker({Key? key}) : super(key: key);

  @override
  _ColourPickerState createState() => _ColourPickerState();
}

class _ColourPickerState extends State<ColourPicker> {
  final storage = GetStorage();

  late Color dialogSelectColor;

  @override
  void initState() {
    super.initState();

    // A purple color.,
    dialogSelectColor = Color(int.parse('0xFF' + storage.read('primary')));
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
      child: Column(
        children: [
          SizedBox(
            height: 32,
          ),
          // ColourTool(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ColourTool(
              type: 'primary',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ColourTool(
              type: 'accent',
            ),
          ),
        ],
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
      child: ListTile(
        dense: false,
        title: Text('${widget.type.toUpperCase()} Colour'.toUpperCase()),
        subtitle: Text(
          '${ColorTools.materialNameAndCode(
            dialogSelectColor,
          )} '
          ' --->   ${ColorTools.nameThatColor(dialogSelectColor)}',
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
        ),
      ),
    );
  }
}
