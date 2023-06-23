import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_flag_converter/emoji_flag_converter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../controlView.dart';
import '../core/constance.dart';
import '../model/user_model.dart';
import '../view/screens/auth/log_in.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final Rx<User?> firebaseUser = Rx<User?>(null);

  late UserModel currentUser;



  @override
  Future<void> onInit() async {
    super.onInit();
    firebaseUser.bindStream(auth.authStateChanges());
  }

  RxBool isLoading = false.obs;

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
      await firestore.collection('users').doc(value.user!.uid).set({
        "name": value.user?.displayName ?? 'user',
        "email": value.user?.email,
        "phone": value.user?.phoneNumber ?? '',
        "gender": 'male',
        "country": 'None Provide Yet',
      });
      Get.back(); // Close the loading dialog
      Get.to(() => LogIn());
      successSnackBar('Success', 'Successfully Signing Up, Now you can Log In');
      return null;
    });
  }


  void emailSignUp(String name, String email, String password, String phone,
      String gender, String country) async {
    try {
      isLoading.value = true;
      Get.defaultDialog(
        title: 'Loading...'.tr,
        content: SpinKitSpinningLines(color: mainColor),
      );

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await firestore.collection('users').doc(userCredential.user!.uid).set({
          "name": name,
          "email": email,
          "phone": phone,
          "gender": gender,
          "country": country,
        });
        Get.back(); // Close the loading dialog
        isLoading.value = false;
        Get.to(() => LogIn());
        successSnackBar('Success', 'Successfully Signing Up, Now you can Log In');
      }
    } catch (error) {
      Get.back(); // Close the loading dialog
      isLoading.value = false;
      successSnackBar('Error', 'Sign up error: $error');
    }
  }

  void emailLogIn(String email, String password) async {
    try {
      isLoading.value = true;
      Get.defaultDialog(
        title: 'Loading...'.tr,
        content: SpinKitSpinningLines(color: mainColor),
      );

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await firestore.collection('users').doc(firebaseUser.value?.uid).get().then((value) => currentUser = UserModel.fromJson(value));
        Get.back(); // Close the loading dialog
        isLoading.value = false;
        Get.offAll(()=> ControlView());
        successSnackBar('Success', 'Successfully Log In, Enjoy');
      }
    } catch (error) {
      Get.back();
      isLoading.value = false;
      errorSnackBar('Log in Error', '$error');
    }
  }

  Widget visibilityIcon(RxBool obscure) {
    return InkWell(
      onTap: () {
        obscure.value == false ? obscure.value = true : obscure.value = false;
      },
      child: obscure.value == false
          ? Icon(Icons.visibility)
          : Icon(Icons.visibility_off),
    );
  }

  logOut() async {
    await auth.signOut();
  }


  String getCountryFlagEmoji(String countryCode) {
    final flag = EmojiConverter.fromAlpha2CountryCode(countryCode);
    return flag;
  }

}
