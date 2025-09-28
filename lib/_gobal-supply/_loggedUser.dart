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

  Future<void> getCurrentUserDetailsLoggedGoogle() async {
    DocumentSnapshot doc =
    await FirebaseFirestore.instance
        .collection(USER_DETAILS) // collection name
        .doc(_user!.email) // document id
        .get();

    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      uid.value = data['UID'];
      name.value = data['NAME'];
      currentEmail.value = data['EMAIL'];
      photourl.value = data['PHOTO_URL'];

      print("User UID: ${data['UID']}");
      print("User Name: ${data['NAME']}");
      print("User Email: ${data['EMAIL']}");
      print("User Photo: ${data['PHOTO_URL']}");
    } else {
      print("Document does not exist");
    }
  }

  // Future<void> fetchAllUsers() async {
  //   QuerySnapshot snapshot =
  //   await FirebaseFirestore.instance.collection("USER_DETAILS").get();
  //
  //   userEmails.value = snapshot.docs.map((doc) {
  //     final data = doc.data() as Map<String, dynamic>;
  //     return UserModel.fromMap(data);
  //   }).where((user) => user.email != currentEmail.value) // 🔥 filter
  //       .toList();
  // }
  Future<void> fetchActiveOthersUsers() async {
    final snapshot = await FirebaseFirestore.instance
        .collection(USER_DETAILS)
        .where("isActive", isEqualTo: true)
        .get();

    // প্রতিটা document এর data map আকারে activeUsersData variable-এ set করা
    activeUsersData.value = snapshot.docs
        .map((doc) => doc.data())
        .toList();
  }


  Future<void> fetchAllUsers() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("USER_DETAILS")
        .where("isActive",  whereIn: [true, false]) // শুধু active users
        .get();

    // map to UserModel & remove current user
    userEmails.value = snapshot.docs
        .map((doc) {
      final data = doc.data();
      return UserModel.fromMap(data);
    })
        .where((user) => user.email != currentEmail.value) // current user বাদ
        .toList();
  }
}
