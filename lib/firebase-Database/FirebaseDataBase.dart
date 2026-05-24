import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/Utills/_constant.dart';

import '../models/_userModel.dart';
import '_internetConnection.dart';

class CurrentLoggedUser extends GetxController {
  final _user = FirebaseAuth.instance.currentUser;
  RxString uid = RxString('');
  RxString name = RxString('');
  RxString photourl = RxString('');
  RxString currentEmail = RxString('');
  RxList userEmails = RxList<UserModel>([]);
  RxList<Map<String, dynamic>> activeUsersData = <Map<String, dynamic>>[].obs;


  Future<void> getCurrentUserDetailsLogged(User user, String loginType) async {
    final userRef =
    FirebaseFirestore.instance.collection(USER_DETAILS).doc(user.uid);

    final doc = await userRef.get();

    final now = DateTime.now().toIso8601String();

    if (!doc.exists) {
      // 🆕 NEW USER CREATE
      await userRef.set({
        "uid": user.uid,
        "name": user.displayName ?? "",
        "email": user.email ?? "",
        "phoneNumber": user.phoneNumber ?? "",
        "photoUrl": user.photoURL ?? "",
        "loginType": loginType,

        "bio": "Hey there 👋",
        "username": "",

        "isOnline": true,
        "isActive": true,
        "isVerified": user.emailVerified,

        // 🔥 PRIVACY SETTINGS (NEW)
        "hideUserOption": HideUser.nobody.toString(),
        "activeStatusOption": ActiveStatus.everyone.toString(),

        "createdAt": now,
        "lastSeen": now,
        "updatedAt": now,

        "friends": [],
        "blockedUsers": [],
        "pushToken": "",
      });
    } else {
      // 🔄 EXISTING USER UPDATE
      await userRef.update({
        "isOnline": true,
        "updatedAt": now,
        "lastSeen": now,
      });
    }
  }
  Future<void> fetchActiveOthersUsers() async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection(USER_DETAILS)
            .where("isActive", isEqualTo: true)
            .get();

    // প্রতিটা document এর data map আকারে activeUsersData variable-এ set করা
    activeUsersData.value = snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> fetchAllUsers() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection("USER_DETAILS")
              .where(
                "isActive",
                whereIn: [true, false],
              ) // সব user (active/inactive)
              .get();

      userEmails.value =
          snapshot.docs
              .map((doc) => UserModel.fromMap(doc.data()))
              .where(
                (user) => user.email != currentEmail.value,
              ) // Current user বাদ
              .toList();
    } catch (e) {
      print('Error fetching users: $e');
      Get.snackbar(
        'Error',
        'Failed to fetch users: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();

    Future.delayed(Duration.zero, () async {
      await fetchActiveOthersUsers();
      await fetchAllUsers();
    });
  }
}
