import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getX/_screenManagement.dart';

class Authverificationwithphoneandsignin extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Observable variables for UI
  var isOtpSent = false.obs;
  var isLoading = false.obs;
  var verificationId = ''.obs;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  // Send OTP
  Future<void> sendOTP() async {
    if (phoneController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please enter phone number");
      return;
    }

    String phone = "+88${phoneController.text.trim()}";

    isLoading.value = true;

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar(
            "Verification Failed",
            e.message ?? "Something went wrong",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        },
        codeSent: (String verId, int? resendToken) {
          Get.toNamed(Routes.otpScreen);
          verificationId.value = verId;
          isOtpSent.value = true;
          Get.snackbar("Success", "OTP sent successfully");
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId.value = verId;
        },
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Verify OTP
  Future<void> verifyOTP() async {
    if (otpController.text.trim().length != 6) {
      Get.snackbar("Error", "Enter valid 6 digit OTP");
      return;
    }

    if (verificationId.value.isEmpty) {
      Get.snackbar("Error", "Verification ID not found");
      return;
    }

    isLoading.value = true;

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otpController.text.trim(),
      );

      await _signInWithCredential(credential);
    } catch (e) {
      Get.snackbar("Invalid OTP", "Please check OTP and try again");
    } finally {
      isLoading.value = false;
    }
  }

  // Common sign in method
  Future<void> _signInWithCredential(PhoneAuthCredential credential) async {
    final UserCredential userCredential =
    await auth.signInWithCredential(credential);

    if (userCredential.user != null) {
      Get.snackbar("Success", "Login Successful", backgroundColor: Colors.green);
      Get.offAllNamed('/home'); // Change route as needed
    }
  }

  // Resend OTP
  Future<void> resendOTP() async {
    if (phoneController.text.trim().isEmpty) return;
    await sendOTP();
  }

  @override
  void onClose() {
    phoneController.dispose();
    otpController.dispose();
    super.onClose();
  }
}