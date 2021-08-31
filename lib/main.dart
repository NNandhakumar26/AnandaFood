import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:subscription_mobile_app/Theme.dart';
import 'package:subscription_mobile_app/splashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    storage.writeIfNull('primary', '828CC8');
    // storage.write('primary', '828CC8');
    Style.tempr.value = Color(int.parse('0xFF' + storage.read('primary')));
    return Obx(
      () => GetMaterialApp(
        title: 'Mobile Subscription App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Style.primary,
          accentColor: Style.accent,
          textTheme: Style.textTheme,
        ),
        home: Splash(),
      ),
    );
  }
}
