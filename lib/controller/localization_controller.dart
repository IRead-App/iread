import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../core/constance.dart';

class LocalizationController extends GetxController {

  final _language = ''.obs;
  String get language => _language.value;

  void changeLanguage(String lang) {
    _language.value = lang;
    box.write('language', lang);
    Get.updateLocale(Locale(lang));
  }

  @override
  void onInit() {
    super.onInit();
    if (box.hasData('language')) {
      _language.value = box.read('language');
    } else {
      _language.value = 'en';
      box.write('language', 'en');
    }
  }
}
