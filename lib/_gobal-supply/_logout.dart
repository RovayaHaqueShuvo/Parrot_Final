import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parrot_messaging/getX/_ScreenManagement/_screenManagement.dart';

class AuthController extends GetxController {
  void logout() async {
    try {
      // Firebase থেকে sign out
      await FirebaseAuth.instance.signOut();

      // Local storage clear (GetStorage ব্যবহার করলে)
      final box = GetStorage();
      await box.erase();

      // যদি SharedPreferences ব্যবহার করো তাহলে:
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.clear();

      // Hive হলে:
      // await Hive.deleteFromDisk();

      // Login Screen এ redirect
      Get.offAllNamed(Routes.loginScreen);

      // Snackbar দেখাও
      Get.snackbar(
        "✅ Logout Successfully",
        "You have successfully logged out from 'Parrot'",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade300,
        colorText: Colors.white,
        margin: EdgeInsets.all(12),
        borderRadius: 12,
        icon: Icon(Icons.logout, color: Colors.white), // 👈 logout icon দিলাম
        shouldIconPulse: true,
        duration: Duration(seconds: 2),
        animationDuration: Duration(milliseconds: 150),
        forwardAnimationCurve: Curves.easeOut,
        reverseAnimationCurve: Curves.easeInCubic,
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
