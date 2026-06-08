import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/Utills/_constant.dart';

class Currrentuserdatamodify extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // TextEditingController for username
  final TextEditingController usernameController = TextEditingController();

  // Observable variables to store user data
  RxString uid = "".obs;
  RxString name = "".obs;
  RxString email = "".obs;
  RxString phoneNumber = "".obs;
  RxString photoUrl = "".obs;
  RxString loginType = "".obs;
  RxString bio = "".obs;
  RxString username = "".obs;
  RxBool isOnline = false.obs;
  RxBool isActive = false.obs;
  RxBool isVerified = false.obs;
  RxString hideUserOption = "".obs;
  RxString activeStatusOption = "".obs;
  RxString createdAt = "".obs;
  RxString lastSeen = "".obs;
  RxString updatedAt = "".obs;
  RxList friends = [].obs;
  RxList blockedUsers = [].obs;
  RxString pushToken = "".obs;

  // Loading state
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUserData();
  }

  @override
  void onClose() {
    usernameController.dispose();
    super.onClose();
  }

  /// Fetches the current logged-in user's data from Firestore
  Future<void> fetchCurrentUserData() async {
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) return;

    // প্রাথমিক ভাবে ফায়ারবেস অথ থেকে ইউআইডি নিয়ে নিচ্ছি
    uid.value = currentUser.uid;

    try {
      isLoading.value = true;
      DocumentSnapshot doc = await _firestore
          .collection(USER_DETAILS)
          .doc(currentUser.uid)
          .get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // যদি ডাটাবেসে uid ফিল্ড থাকে তবে সেটি নাও, নাহলে ডকুমেন্ট আইডি (doc.id) ব্যবহার করো
        uid.value = data['uid'] ?? doc.id;
        name.value = data['name'] ?? "";
        email.value = data['email'] ?? "";
        phoneNumber.value = data['phoneNumber'] ?? "";
        photoUrl.value = data['photoUrl'] ?? "";
        loginType.value = data['loginType'] ?? "";
        bio.value = data['bio'] ?? "Hey there 👋";
        username.value = data['username'] ?? "";
        
        // Update controller text
        usernameController.text = username.value;

        isOnline.value = data['isOnline'] ?? false;
        isActive.value = data['isActive'] ?? false;
        isVerified.value = data['isVerified'] ?? false;
        hideUserOption.value = data['hideUserOption'] ?? "";
        activeStatusOption.value = data['activeStatusOption'] ?? "";
        createdAt.value = data['createdAt'] ?? "";
        lastSeen.value = data['lastSeen'] ?? "";
        updatedAt.value = data['updatedAt'] ?? "";
        friends.value = data['friends'] ?? [];
        blockedUsers.value = data['blockedUsers'] ?? [];
        pushToken.value = data['pushToken'] ?? "";
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Updates a specific field in Firebase
  Future<void> updateProfileField(String fieldName, String newValue) async {
    if (newValue.isEmpty) {
      Get.snackbar("Warning", "$fieldName cannot be empty");
      return;
    }

    try {
      isLoading.value = true;
      await _firestore
          .collection(USER_DETAILS)
          .doc(uid.value)
          .update({fieldName: newValue});

      // Update local observable based on field
      if (fieldName == 'username') {
        username.value = newValue;
      } else if (fieldName == 'photoUrl') {
        photoUrl.value = newValue;
      }
      
      Get.back();
      Get.snackbar(
        "Success",
        "${fieldName.capitalizeFirst} updated successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.7),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar("Error", "Failed to update: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
