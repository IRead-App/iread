import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final _themeMode = ThemeMode.system.obs;

  ThemeMode get themeMode => _themeMode.value;

  void toggleTheme() {
    if (_themeMode.value == ThemeMode.light) {
      _themeMode.value = ThemeMode.dark;
    } else if (_themeMode.value == ThemeMode.dark) {
      _themeMode.value = ThemeMode.light;
    } else {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      if (brightness == Brightness.dark) {
        _themeMode.value = ThemeMode.dark;
      } else {
        _themeMode.value = ThemeMode.light;
      }
    }
  }
}