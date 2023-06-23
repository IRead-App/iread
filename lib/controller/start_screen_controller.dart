import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iread/view/screens/community/community.dart';
import 'package:iread/view/screens/summary.dart';
import 'package:iread/view/screens/profile.dart';
import 'package:iread/view/screens/road_maps.dart';

import '../model/user_model.dart';
import '../view/screens/chat.dart';
import 'auth_controller.dart';

class StartScreenController extends GetxController{


  RxInt currentScreen = 0.obs;
  RxList<Widget> screens = <Widget>[
    Summary(),
    RoadMaps(),
    Community(),
    Chat(),
    Profile(user: AuthController.instance.currentUser,)
  ].obs;


}