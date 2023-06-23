import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../view/screens/auth/log_in.dart';
import 'package:get/get.dart';
import 'controller/localization_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // bottomSheetTheme: BottomSheetThemeData(elevation: 0),
        // appBarTheme: AppBarTheme(
        //     iconTheme: IconThemeData(color: Colors.black),
        //     titleTextStyle: TextStyle(color: Colors.black),
        //     backgroundColor: Colors.transparent,
        //     elevation: 0),
        primarySwatch: Colors.teal,
      ),
      translations: TranslationService(),
      locale: Locale(localizationController.language),
      fallbackLocale: Locale('en'),
      initialBinding: Binding(),
      home: LogIn(),
    );
  }
}
