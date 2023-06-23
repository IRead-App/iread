import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../controller/community_controller.dart';
import '../controller/home_controller.dart';
import '../controller/localization_controller.dart';
import '../controller/start_screen_controller.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LocalizationController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => StartScreenController(), fenix: true);
  }
}