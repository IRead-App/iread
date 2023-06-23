import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iread/view/screens/auth/sign_up.dart';

import '../../../controller/auth_controller.dart';
import '../../../controller/localization_controller.dart';
import '../../../core/constance.dart';
import '../../widgets/custom_auth_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../summary.dart';


class LogIn extends GetWidget<AuthController> {
   LogIn({Key? key}) : super(key: key);

  final LocalizationController localizationController =
  Get.find<LocalizationController>();


  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> logInForm = GlobalKey<FormState>();
    RxString email = ''.obs;
    RxString password = ''.obs;
    RxBool obscure = true.obs;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(alignment: Alignment.topLeft,child: Text('Log In'.tr,style: appBar,),),
              SizedBox(height: Get.height * 0.02,),
              Text('iRead',style: headLine1,),
              SizedBox(height: Get.height * 0.02,),
              SizedBox(
                height: Get.height * 0.2,
                width: Get.width * 0.8,
                child: Image.asset('assets/images/log_in.png',fit: BoxFit.cover,),
              ),
              SizedBox(height: Get.height * 0.05,),
              Form(
                key: logInForm,
                child: Column(
                  children: [
                    CustomTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      label: 'Email'.tr,
                      icon: Icon(Icons.email),
                      onChanged: (val) {
                        email.value = val;
                      },
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Obx(() => CustomTextFormField(
                      label: 'Password'.tr,
                      icon: controller.visibilityIcon(obscure),
                      obscure: obscure.value,
                      onChanged: (val) {
                        password.value = val;
                      },
                    )),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    SizedBox(
                      height: Get.height * 0.07,
                      width: Get.width * 0.7,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10)))),
                          onPressed: () async {
                            controller.emailLogIn(email.value.trim(), password.value.trim());
                            // Get.offAll(()=> Home());
                          },
                          child: Text(
                            'Log In'.tr,
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              InkWell(
                onTap: () {
                  Get.to(()=> SignUp());
                },
                child: Text.rich(TextSpan(
                    children: [
                      TextSpan(
                          text: "Don't have account ? ".tr,
                          style: style1),
                      TextSpan(
                          text: " "),
                      TextSpan(
                          text: "Sign Up".tr,
                          style: style2),
                    ]
                )),
              ),
              SizedBox(height: Get.height * 0.01,),
              Center(child: Text('- OR -'.tr,style: style3,),),
              SizedBox(height: Get.height * 0.01,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthButton(image: 'assets/icons/facebook.png',onTap: (){},),
                  SizedBox(width: Get.width * 0.03,),
                  AuthButton(image: 'assets/icons/googleNew.png',onTap: (){
                    controller.signInWithGoogle();
                  },fit: BoxFit.contain,),
                ],
              ),
              SizedBox(height: Get.height * 0.02,),
            ],
          ).paddingSymmetric(horizontal: 20),
        ),
      ),
    );
  }
}