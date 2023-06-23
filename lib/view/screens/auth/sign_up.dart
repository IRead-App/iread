import 'package:country_picker/country_picker.dart';
import 'package:emoji_flag_converter/emoji_flag_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/localization_controller.dart';
import '../../../core/constance.dart';
import '../../widgets/custom_auth_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/gender_button.dart';
import 'log_in.dart';

class SignUp extends GetWidget<AuthController> {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> signUpForm = GlobalKey<FormState>();
    RxString name = ''.obs;
    RxString password = ''.obs;
    RxString rePassword = ''.obs;
    RxString selectedGender = 'male'.obs;
    RxString email = ''.obs;
    RxString phone = ''.obs;
    RxString countryCode = ''.obs;
    RxString countryPhoneCode = ''.obs;
    TextEditingController country = TextEditingController();
    FocusNode countryFocus = FocusNode();
    RxBool firstScreen = true.obs;
    RxBool obscure = true.obs;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.01,),
              Align(alignment: Alignment.topLeft,child: Text('Sign Up'.tr,style: appBar,),),
              Text('iRead',style: headLine1,),
              SizedBox(
                height: Get.height * 0.2,
                width: Get.width * 0.7,
                child: Image.asset('assets/images/sign_up2.png',fit: BoxFit.cover,),
              ),
              SizedBox(height: Get.height * 0.03,),
              Obx(
                    () => AnimatedCrossFade(
                    firstChild: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                            height: Get.height * 0.02,
                          ),
                          Obx(() => CustomTextFormField(
                            label: 'RePassword'.tr,
                            icon: null,
                            obscure: obscure.value,
                          )),
                          SizedBox(
                            height: Get.height * 0.03,
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
                                onPressed: () {
                                  firstScreen.value = false;
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Continue'.tr),
                                    Icon(Icons.arrow_forward_ios)
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(()=> LogIn());
                            },
                            child: Text.rich(TextSpan(
                                children: [
                                  TextSpan(
                                      text: "Have account ? ".tr,
                                      style: style1),
                                  TextSpan(
                                      text: " "),
                                  TextSpan(
                                      text: "Log In".tr,
                                      style: style2),
                                ]
                            )),
                          ),
                          Center(child: Text('- OR -',style: style3,),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AuthButton(image: 'assets/icons/facebook.png'),
                              SizedBox(width: Get.width * 0.03,),
                              AuthButton(image: 'assets/icons/googleNew.png',onTap: (){
                                controller.signInWithGoogle();
                              },fit: BoxFit.contain,),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.02,),
                        ],
                      ),
                    ),
                    secondChild: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomTextFormField(
                            label: 'Name'.tr,
                            icon: Icon(Icons.drive_file_rename_outline),
                            hint: 'example : User'.tr,
                            onChanged: (val) {
                              name.value = val.trim();
                            },
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          CustomTextFormField(
                            controller: country,
                            focusNode: countryFocus,
                            label: 'Select Country'.tr,
                            icon: Icon(Icons.public),
                            readOnly: true,
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: true, // optional. Shows phone code before the country name.
                                onSelect: (c) {
                                  countryFocus.unfocus();
                                  country.text = c.name;
                                  countryCode.value = c.countryCode;
                                  countryPhoneCode.value = c.phoneCode;

                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          CustomTextFormField(
                            label: 'Phone',
                            keyboardType: TextInputType.phone,
                            icon: Icon(Icons.phone),
                            prefix: Obx(
                                  () {
                                    final countryCodeValue = countryCode.value;
                                    String flagEmoji = '';
                                    if (countryCodeValue.length == 2) {
                                      flagEmoji = EmojiConverter.fromAlpha2CountryCode(countryCodeValue);
                                    }
                                return Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: flagEmoji,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      TextSpan(text: ' | ', style: TextStyle(fontSize: 20)),
                                      TextSpan(text: '+ ${countryPhoneCode.value}  ', style: TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                );
                              },
                            ),
                            onChanged: (val){
                              phone.value = val;
                            },
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          GenderButton(selectedGender: selectedGender,),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          IconButton(
                              onPressed: () {
                                firstScreen.value = true;
                              },
                              icon: Icon(Icons.arrow_back_ios)),
                          SizedBox(
                            height: Get.height * 0.01,
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
                                  controller.emailSignUp(name.value, email.value, password.value, phone.value, selectedGender.value, country.text);
                                },
                                child: Text(
                                  'Sign Up'.tr,style: style3,
                                )),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(()=> LogIn());
                            },
                            child: Text.rich(TextSpan(
                                children: [
                                  TextSpan(
                                      text: "Have account ? ".tr,
                                      style: style1),
                                  TextSpan(
                                      text: " "),
                                  TextSpan(
                                      text: "Log In".tr,
                                      style: style2),
                                ]
                            )),
                          ),
                          Center(child: Text('- OR -'.tr,style: style3,),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AuthButton(image: 'assets/icons/facebook.png'),
                              SizedBox(width: Get.width * 0.03,),
                              AuthButton(image: 'assets/icons/googleNew.png',onTap: (){
                                controller.signInWithGoogle();
                              },fit: BoxFit.contain,),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.02,),
                        ],
                      ),
                    ),
                    crossFadeState: firstScreen.value
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: Duration(milliseconds: 500)),
              ),
            ],
          ).paddingSymmetric(horizontal: 20),
        ),
      ),
    );
  }
}



