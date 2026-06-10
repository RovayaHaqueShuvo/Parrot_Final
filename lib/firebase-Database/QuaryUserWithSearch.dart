import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/Utills/_constant.dart';

class Quaryuserwithsearch extends GetxController {
  // সার্চ রেজাল্ট রাখার জন্য লিস্ট
  var searchResults = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  /// একাধিক ফিল্ড দিয়ে ইউজার সার্চ করার ফাংশন
  Future<void> searchUsers(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      isLoading.value = true;

      // Filter.or ব্যবহার করে ইমেইল, ফোন নাম্বার, ইউআইডি অথবা ইউজারনেম দিয়ে খোঁজা হচ্ছে
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance
              .collection(USER_DETAILS)
              .where(
                Filter.or(
                  Filter("email", isEqualTo: query.trim()),
                  Filter("phoneNumber", isEqualTo: query.trim()),
                  Filter("uid", isEqualTo: query.trim()),
                  Filter("username", isEqualTo: query.trim()),
                ),
              )
              .get();

      // রেজাল্ট ম্যাপ আকারে লিস্টে জমা করা
      searchResults.value =
          snapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();
    } catch (e) {
      print("Search Error: $e");
      Get.snackbar(
        "Error",
        "Something went wrong while searching",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
