import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'constance.dart';

class TranslationService extends Translations {

  final languagesMap = {
    'en': {
      'Home': 'Home',
      'LogIn': 'LogIn',
    },
    'ar': {
      'Home': 'الصفحة الرئيسية',
      'LogIn': 'تسجيل الدخول',
    },
  };

  @override
  Map<String, Map<String, String>> get keys => languagesMap;

  Future<void> init() async {
    final String lang =  box.read<String>('languageCode') ?? 'en';
    Get.updateLocale(Locale(lang));
  }
}
