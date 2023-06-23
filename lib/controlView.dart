import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iread/view/screens/auth/log_in.dart';
import 'package:iread/view/screens/summary.dart';
import 'package:iread/view/screens/start_screen.dart';

import 'controller/auth_controller.dart';

class ControlView extends StatelessWidget {
  const ControlView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => AuthController.instance.firebaseUser.value != null  ? StartScreen() : LogIn());
  }
}
