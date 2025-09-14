import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../getX/_screenManagement.dart';

class ButtonfunctionManagement extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  RxInt isLoading = RxInt(0);

  Future<void> loginWithEmaiPass() async {
    try {
      isLoading.value = 1;
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email.text.trim(),
            password: password.text.trim(),
          );
      print("✅ Login successful: ${userCredential.user?.uid}");
      isLoading.value = 1;
      Get.offAllNamed(Routes.homeScreen);
      Get.snackbar(
        "✅ Login Successful",
        "Welcome back!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
        // total visible time
        animationDuration: Duration(milliseconds: 150),
        // fast slide-in
        forwardAnimationCurve: Curves.easeOut,
        // slide in fast
        reverseAnimationCurve: Curves.easeInCubic, // hide slowly
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        isLoading.value = 404;
        Get.snackbar(
          "❌ Login Failed",
          "Wrong email or password",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade300,
          colorText: Colors.white,
          margin: EdgeInsets.all(12),
          borderRadius: 12,
          icon: Icon(Icons.error, color: Colors.white),
          shouldIconPulse: true,
          duration: Duration(seconds: 2),
          // total visible time
          animationDuration: Duration(milliseconds: 150),
          // fast slide-in
          forwardAnimationCurve: Curves.easeOut,
          // slide in fast
          reverseAnimationCurve: Curves.easeInCubic, // hide slowly
        );
      } else if (email.text.isEmpty || password.text.isEmpty) {
        isLoading.value = 202;
        Get.snackbar(
          "❌ Login Failed",
          "Write email or password accurately",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade300,
          colorText: Colors.white,
          margin: EdgeInsets.all(12),
          borderRadius: 12,
          icon: Icon(Icons.error, color: Colors.white),
          shouldIconPulse: true,
          duration: Duration(seconds: 2),
          // total visible time
          animationDuration: Duration(milliseconds: 150),
          // fast slide-in
          forwardAnimationCurve: Curves.easeOut,
          // slide in fast
          reverseAnimationCurve: Curves.easeInCubic, // hide slowly
        );
      } else {
        isLoading.value = 500;
        Get.snackbar(
          "❌ Login Failed",
          e.message ?? "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade300,
          colorText: Colors.white,
          margin: EdgeInsets.all(12),
          borderRadius: 12,
          icon: Icon(Icons.error, color: Colors.white),
          shouldIconPulse: true,
          duration: Duration(seconds: 2),
          // total visible time
          animationDuration: Duration(milliseconds: 150),
          // fast slide-in
          forwardAnimationCurve: Curves.easeOut,
          // slide in fast
          reverseAnimationCurve: Curves.easeInCubic, // hide slowly
        );
      }
    }
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
