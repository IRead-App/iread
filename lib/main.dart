import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../view/screens/auth/log_in.dart';
import 'package:get/get.dart';
import 'controller/localization_controller.dart';
import 'controller/theme_controller.dart';
import 'core/localization.dart';
import 'core/binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
   MyApp({super.key});

  final LocalizationController localizationController =
  Get.put(LocalizationController());

   final themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeController.themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
      ),
      translations: TranslationService(),
      locale: Locale(localizationController.language),
      fallbackLocale: Locale('en'),
      initialBinding: Binding(),
      home: LogIn(),
    ));
  }
}
