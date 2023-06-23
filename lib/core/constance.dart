import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

final box = GetStorage('boxData');

void changeLocale(String langCode) async {
  final box = GetStorage();
  await box.write('languageCode', langCode);

  final Locale locale = Locale(langCode);
  Get.updateLocale(locale);
}

successSnackBar(String title, String message){
  return Get.snackbar('', '',titleText: Text(title,style: GoogleFonts.lateef(fontSize: 26, fontWeight: FontWeight.bold),),messageText: Text(message,style: GoogleFonts.lateef(fontSize: 18, fontWeight: FontWeight.bold),),backgroundColor: Colors.transparent,colorText: Colors.black,icon: Image.asset('assets/icons/success.png'),borderRadius: 15.0,borderColor: Colors.green[700],borderWidth: 2.0);
}

errorSnackBar(String title, String message){
  return Get.snackbar('', '',titleText: Text(title,style: GoogleFonts.lateef(fontSize: 26, fontWeight: FontWeight.bold),),messageText: Text(message,style: GoogleFonts.lateef(fontSize: 18, fontWeight: FontWeight.bold),),backgroundColor: Colors.transparent,colorText: Colors.black,icon: Image.asset('assets/icons/error.png'),borderRadius: 15.0,borderColor: Colors.red[700],borderWidth: 2.0);
}

/// Colors
Color mainColor = Colors.teal;

/// fonts
TextStyle appBar = GoogleFonts.lateef(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black);
TextStyle headLine1 = GoogleFonts.lateef(fontSize: 50, fontWeight: FontWeight.bold, color: mainColor);
TextStyle style1 = GoogleFonts.lateef(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);
TextStyle style2 = GoogleFonts.lateef(fontSize: 26, fontWeight: FontWeight.bold, color: mainColor);
TextStyle style3 = GoogleFonts.lateef(fontSize: 22, fontWeight: FontWeight.bold);
TextStyle style4 = GoogleFonts.lateef(fontSize: 16, fontWeight: FontWeight.w600);
TextStyle sectionStyle = GoogleFonts.lateef(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal);
TextStyle bookHeadLine1 = GoogleFonts.lateef(fontSize: 26, fontWeight: FontWeight.bold);
TextStyle bookHeadLine2 = GoogleFonts.lateef(fontSize: 24, fontWeight: FontWeight.w600);
TextStyle bookBody1 = GoogleFonts.lateef(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.grey[600]);