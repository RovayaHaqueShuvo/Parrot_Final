import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:parrot_messaging/Utills/_constant.dart';

class NetworkController extends GetxController {
  var isConnected = true.obs;
  late StreamSubscription<InternetConnectionStatus> listener;

  final _user = FirebaseAuth.instance.currentUser;
  RxBool isActive = RxBool(true);
  Rx<DateTime?> lastLogin = Rx<DateTime?>(null);

  // Future<void> setUserActive() async {
  //   final docRef = FirebaseFirestore.instance.collection(USER_DETAILS).doc(_user!.email);
  //   await docRef.set({
  //     "isActive": true,
  //     "lastLogin": FieldValue.serverTimestamp(),
  //   }, SetOptions(merge: true)); // 👈 merge:true দিলে পুরোনো data মুছে যাবে না
  // }

// 🔹 Realtime bind (auto update on change)
  void bindUserStatus() {
    FirebaseFirestore.instance
        .collection(USER_DETAILS)
        .doc(_user!.email)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data()!;
        isActive.value = data["isActive"] ?? false;
        if (isConnected.value) {
          lastLogin.value = (data["lastLogin"] != null)
            ? (data["lastLogin"] as Timestamp).toDate()
            : null;
        }
      }
    });
  }

// 🔹 Update status (active/inactive)
  Future<void> updateUserStatus(bool status) async {
    await FirebaseFirestore.instance
        .collection(USER_DETAILS)
        .doc(_user!.email)
        .update({
      "isActive": status,
      if (isConnected.value)"lastLogin": FieldValue.serverTimestamp(), // ✅ optional: update time
    });
  }

// 🔹 One-time data retrieve
  Future<void> fetchUserStatus() async {
    final snapshot = await FirebaseFirestore.instance
        .collection(USER_DETAILS)
        .doc(_user!.email)
        .get();

    if (snapshot.exists) {
      final data = snapshot.data()!;
      isActive.value = data["isActive"] ?? false;
      lastLogin.value = (data["lastLogin"] != null)
          ? (data["lastLogin"] as Timestamp).toDate()
          : null;
    }
  }

  @override
  void onInit() {
    super.onInit();

    // InternetConnectionChecker singleton instance ব্যবহার
    final checker = InternetConnectionChecker.createInstance();

    listener = checker.onStatusChange.listen((status) {
      isConnected.value = (status == InternetConnectionStatus.connected);
    });
  }

  @override
  void onClose() {
    listener.cancel();
    super.onClose();
  }
}
