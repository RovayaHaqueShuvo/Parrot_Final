import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed('/login');
      Get.snackbar(
        "✅ Logout Successfully",
        "You have successfully logged out from 'Parrot'",
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
    } catch (e) {
      Get.snackbar(
        "Logout Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
