import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iread/controller/auth_controller.dart';
import 'package:iread/controller/theme_controller.dart';
import 'package:iread/core/constance.dart';
import 'package:iread/view/widgets/custom_text_form_field.dart';


class Setting extends StatelessWidget {
  Setting({Key? key}) : super(key: key);

  final themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting',style: appBar,),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Card(
            elevation: 1.5,
            child: Obx(() => ListTile(
              title: themeController.themeMode == ThemeMode.dark ? Text('Light Mood',style: style2,) : Text('Dark Mood',style: style2,),
              trailing: themeController.themeMode == ThemeMode.dark ? Icon(Icons.light_mode) : Icon(Icons.dark_mode),
              onTap: (){
                themeController.toggleTheme();
              },
            )),
          ),
          SizedBox(height: 20,),
          Card(
            elevation: 1.5,
            child: ListTile(
              title: Text('Delete Account',style: style2,),
              trailing: Icon(Icons.delete),
              onTap: (){
                AuthController.instance.auth.currentUser?.delete();
                AuthController.instance.logOut();
                FirebaseFirestore.instance.collection('users').doc( AuthController.instance.auth.currentUser?.uid).delete();
              },
            ),
          ),
          SizedBox(height: 20,),
          Card(
            elevation: 1.5,
            child: ListTile(
              title: Text('Change password',style: style2,),
              trailing: Icon(Icons.delete),
              onTap: (){
                RxString newPassword = ''.obs;
                Get.defaultDialog(
                  title: 'Changing password',
                  content: SizedBox(width: Get.width,height: Get.height * 0.2,child: Center(child: CustomTextFormField(label: 'New Password', icon: Icon(Icons.password), onChanged: (val){newPassword.value = val;},).paddingAll(20))),
                  onConfirm: (){AuthController.instance.auth.currentUser?.updatePassword(newPassword.value); AuthController.instance.logOut();},
                  onCancel: (){Get.back();}
                );
              },
            ),
          ),
          SizedBox(height: 20,),
          Card(
            elevation: 1.5,
            child: ListTile(
              title: Text('Log out',style: style2,),
              trailing: Icon(Icons.logout),
              onTap: (){
                AuthController.instance.logOut();
              },
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 10),
    );
  }
}
