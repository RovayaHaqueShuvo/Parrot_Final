import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parrot_messaging/Utills/_constant.dart';
import 'package:parrot_messaging/getX/_ScreenManagement/_screenManagement.dart';

class AuthController extends GetxController {
  void showLogoutDialog() {
    Get.defaultDialog(
      title: "Logout",
      middleText: "Are you sure you want to logout?",
      textConfirm: "Logout",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.red,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back(); // Close the dialog
        logout();   // Perform logout
      },
      onCancel: () {
        Navigator.of(Get.overlayContext!).pop();
      },
    );
  }

  void logout() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection(USER_DETAILS)
            .doc(user.uid)
            .update({
          "isOnline": false,
          "lastSeen": DateTime.now().toIso8601String(),
        });
      }

      // Firebase থেকে sign out
      await FirebaseAuth.instance.signOut();

      // Local storage clear
      final box = GetStorage();
      await box.erase();

      // Clear dependencies (don't use force: true to keep permanent controllers like Theme)
      Get.deleteAll();

      // Onboarding Screen এ redirect
      Get.offAllNamed(Routes.onBoardingScreen);

      // Snackbar দেখাও
      Get.snackbar(
        "✅ Logout Successfully",
        "You have successfully logged out from 'Parrot'",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade300,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 12,
        icon: const Icon(Icons.logout, color: Colors.white),
        shouldIconPulse: true,
        duration: const Duration(seconds: 2),
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
