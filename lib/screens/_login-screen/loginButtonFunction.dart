import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../getX/_screenManagement.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginButtonfunctionManagement extends GetxController {
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

  Future<void> signInWithGoogle() async {
    try {
      // Trigger authentication flow
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the login
        print("User cancelled Google sign in");
        return;
      }

      // Get authentication details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Ensure at least one token is available
      if (googleAuth.idToken == null && googleAuth.accessToken == null) {
        print("Error: Google auth tokens are null!");
        return;
      }

      // Create a credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      // Sign in with Firebase
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
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

      print("✅ Login successful: ${userCredential.user?.uid}");

      // Navigate to next page (Home)
      Get.offAllNamed('/home'); // <-- তোমার next page route দিন
    } catch (e) {
      print("❌ Google sign in error: $e");
      Get.snackbar(
        "❌ Login Failed",
        "Google sign in failed",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
