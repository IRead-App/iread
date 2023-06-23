import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iread/controller/home_controller.dart';
import 'package:iread/controller/start_screen_controller.dart';
import 'package:iread/core/constance.dart';
import 'package:iread/model/user_model.dart';
import 'package:iread/view/screens/saved_posts.dart';
import 'package:iread/view/screens/setting.dart';
import 'package:iread/view/widgets/custom_text_form_field.dart';

import '../../controller/auth_controller.dart';


class Profile extends StatelessWidget {
  const Profile({Key? key, required this.user}) : super(key: key);

  final UserModel user;


  @override
  Widget build(BuildContext context) {
    RxBool edit = false.obs;
    RxString name = ''.obs;
    RxString email = ''.obs;
    RxString phone = ''.obs;
    RxString country = ''.obs;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',style: appBar,),
        centerTitle: true,
        actions: [
            IconButton(onPressed: (){
              Get.to(()=> Setting());
            }, icon: Icon(Icons.settings, color: Colors.black,))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15,),
            Container(
              height: Get.height * 0.15,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/${AuthController.instance.currentUser.gender}.png',), scale: 3, ),
                  border: Border.all(color: mainColor,width: 2),
                  shape: BoxShape.circle
              ),
            ),
            SizedBox(height: Get.height * 0.04,),
            Obx(() => CustomTextFormField(label: 'Name', icon: Icon(Icons.person), value: user.name, readOnly: !edit.value,onChanged: (val){
              name.value = val;
            },)),
            SizedBox(height: 25,),
            Obx(() => CustomTextFormField(label: 'Email', icon: Icon(Icons.email), value: user.email,enabled: !edit.value, readOnly: true,onChanged: (val){
              email.value = val;
            },)),
            SizedBox(height: 25,),
            Obx(() => CustomTextFormField(label: 'Phone', icon: Icon(Icons.phone), value: user.phone, readOnly: !edit.value,onChanged: (val){
              phone.value = val;
            },)),
            SizedBox(height: 25,),
            Obx(() => CustomTextFormField(label: 'Country', icon: Icon(Icons.public), value: user.country, readOnly: !edit.value,onChanged: (val){
              country.value = val;
            },)),
            SizedBox(height: 25,),
            Card(
              elevation: 1.5,
              child: ListTile(
                title: Text('Saved Posts',style: style2,),
                trailing: Icon(Icons.archive),
                onTap: (){
                  Get.to(()=> SavedPosts());
                },
              ),
            ),
            SizedBox(height: 25,),
            SizedBox(
              width: Get.width * 0.6,
              height: Get.height * 0.06,
              child: Obx(() => ElevatedButton(onPressed: (){
                if(edit.value == false) {
                  edit.value = true;
                  name.value = user.name;
                  phone.value = user.phone;
                  country.value = user.country;
                }else {
                  FirebaseFirestore.instance.collection('users').doc(AuthController.instance.firebaseUser.value!.uid).update({
                    'name':name.value,
                    'phone':phone.value,
                    'country':country.value,
                  });
                  edit.value = false;
                }
              }, child: edit.value == false ? Text('Edit') : Text('Save'))),
            ),


          ],
        ).paddingSymmetric(horizontal: 15),
      ),
    );
  }
}
