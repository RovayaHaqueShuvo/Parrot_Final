import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/Utills/_constant.dart';

class CurrentLoggedUser extends GetxController {

  final _user = FirebaseAuth.instance.currentUser;
  RxString uid = RxString('');
  RxString name = RxString('');
  RxString photourl = RxString('');
  RxString email = RxString('');

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
      email.value = data['EMAIL'];
      photourl.value = data['PHOTO_URL'];
      print("User UID: ${data['UID']}");
      print("User Name: ${data['NAME']}");
      print("User Email: ${data['EMAIL']}");
      print("User Photo: ${data['PHOTO_URL']}");
    } else {
      print("Document does not exist");
    }
  }
}
