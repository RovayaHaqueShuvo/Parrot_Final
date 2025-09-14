import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/Utills/_constant.dart';

import '../../getX/_screenManagement.dart';

class SignUpButtonfunctionManagement extends GetxController {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();
  RxInt isLoading = RxInt(0);

  Future<void> signUpWithEmailPass() async {
    if (name.text.isEmpty ||
        email.text.isEmpty ||
        password.text.isEmpty ||
        confirmpassword.text.isEmpty) {
      Get.snackbar(
        "❌ Failed",
        "Please fill all the fields",
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
      return;
    } else if (password.text.isEmpty != confirmpassword.text.isEmpty) {
      Get.snackbar(
        "❌ Failed",
        "Both password must be same",
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
      return;
    }

    try {
      isLoading.value = 1;
      // Sign Up with Firebase
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email.text.trim(),
            password: password.text.trim(),
          );
      User? user = userCredential.user;

      if (user != null) {
        // 2️⃣ Save user data in Firestore
        await FirebaseFirestore.instance
            .collection(USER_DETAILS) // collection name
            .doc(email.text.trim()) // document id = uid
            .set({
              UID: user.uid,
              NAME: name.text.trim(),
              EMAIL: email.text.trim(),
              TIME: FieldValue.serverTimestamp(),
            });
      }
      // Sign Up successful
      Get.offAllNamed(Routes.homeScreen);
      Get.snackbar(
        "✅ Sign Up Successful",
        "Welcome! Your account has been created.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        isLoading.value = 404;
        Get.snackbar(
          "❌ Login Failed",
          "Password is too weak!",
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
      } else if (e.code == 'email-already-in-use') {
        isLoading.value = 402;
        Get.snackbar(
          "❌ Login Failed",
          "Email is already registered!!",
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
        isLoading.value = 401;
        Get.snackbar(
          "❌ Login Failed",
          "Something went wrong!",
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
      Get.snackbar(
        "❌ Sign Up Failed",
        "Opps! Something went wrong!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade300,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = 0;
    }
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
