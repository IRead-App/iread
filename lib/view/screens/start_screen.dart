import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iread/controller/start_screen_controller.dart';

import '../../core/constance.dart';


class StartScreen extends GetWidget<StartScreenController> {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: controller.screens[controller.currentScreen.value]),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        unselectedIconTheme: IconThemeData(color: mainColor),
        selectedIconTheme: IconThemeData(size: 28, color: mainColor),
        selectedItemColor: Colors.black,
        selectedLabelStyle: GoogleFonts.lateef(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        currentIndex: controller.currentScreen.value,
        onTap: (val) {
          controller.currentScreen.value = val;
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.house,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map,
            ),
            label: 'Road Maps',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.forum,
            ),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
            ),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
      )),
    ));
  }
}
