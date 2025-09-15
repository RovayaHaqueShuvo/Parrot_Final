import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CurrentLoggedUser extends GetxController{

  getCurrentUserDetailsLoggedGoogle(){
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String? uid = user.uid;             // Firebase user ID
      String? name = user.displayName;    // User name
      String? email = user.email;         // User email
      String? photoUrl = user.photoURL;   // Profile picture URL

      print("User UID: $uid");
      print("User Name: $name");
      print("User Email: $email");
      print("User Photo: $photoUrl");
    }
  }
}