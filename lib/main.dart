import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:subscription_mobile_app/Theme.dart';
import 'package:subscription_mobile_app/splashScreen.dart';

import 'Lang/localization_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  //WRITE CODES FOR NOTIFICATION SERVICES
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    final storage = GetStorage();
    storage.writeIfNull('primary', '74B04C');
    storage.writeIfNull('accent', '4D434B');
    // storage.write('primary', '74B04C');
    // storage.write('accent', '4D434B');

    return GetMaterialApp(
        debugShowMaterialGrid: false,
        translations: LocalizationService(), // your translations
        locale: LocalizationService()
            .getCurrentLocale(), // translations will be displayed in that locale
        fallbackLocale: Locale(
          'en',
          'US',
        ),
        title: 'Mobile Subscription App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Style.prime,
          textTheme: Style.textTheme,
        ),
        home: Splash(),
      // ),
    );
  }
}
