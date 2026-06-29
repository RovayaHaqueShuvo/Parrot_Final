import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:parrot_messaging/Utills/_constant.dart';

class NetworkController extends GetxController {
  var isConnected = true.obs;
  late StreamSubscription<InternetConnectionStatus> listener;
  StreamSubscription<DocumentSnapshot>? _userStatusSubscription;

  RxBool isActive = RxBool(true);
  Rx<DateTime?> lastLogin = Rx<DateTime?>(null);

  // Helper to get current user securely
  User? get _currentUser => FirebaseAuth.instance.currentUser;

// 🔹 Realtime bind (auto update on change)
  void bindUserStatus() {
    final user = _currentUser;
    if (user == null || user.uid.isEmpty) {
      print("NetworkController: No user logged in to bind status.");
      return;
    }

    _userStatusSubscription?.cancel();
    _userStatusSubscription = FirebaseFirestore.instance
        .collection(USER_DETAILS)
        .doc(user.uid)
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
    final user = _currentUser;
    if (user == null || user.uid.isEmpty) return;

    await FirebaseFirestore.instance
        .collection(USER_DETAILS)
        .doc(user.uid)
        .update({
      "isActive": status,
      if (isConnected.value)
        "lastLogin": FieldValue.serverTimestamp(), // ✅ optional: update time
    });
  }

// 🔹 One-time data retrieve
  Future<void> fetchUserStatus() async {
    final user = _currentUser;
    if (user == null || user.uid.isEmpty) return;

    final snapshot = await FirebaseFirestore.instance
        .collection(USER_DETAILS)
        .doc(user.uid)
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
    _userStatusSubscription?.cancel();
    super.onClose();
  }
}
