import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parrot_messaging/getX/_screenManagement.dart';

import '../firebase-Database/FirebaseDataBase.dart';

class AuthVerificationWithGoogleAndSignIn extends GetxController {
  final FirebaseDataBase createDatabase = Get.put(FirebaseDataBase());
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  var isLoading = false.obs;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      isLoading.value = true;
      // ১. গুগল সাইন-ইন ব্যবহারের জন্য serverClientId দিয়ে ইনিশিয়ালাইজ করতে হবে (অবশ্যই Web Client ID দিতে হবে)
      await _googleSignIn.initialize(
        serverClientId: '838942551991-2tflmu2u9fnrp313sadcd1vq80tni5p7.apps.googleusercontent.com',
      );

      // ২. গুগল সাইন-ইন পপআপ ওপেন করো
      final GoogleSignInAccount? googleAccount = await _googleSignIn.authenticate();
      
      if (googleAccount == null) return null;

      // ৩. অথেন্টিকেশন টোকেন সংগ্রহ করো
      final GoogleSignInAuthentication googleAuth = googleAccount.authentication;

      // ৪. Firebase Credential তৈরি করো
      final credential = GoogleAuthProvider.credential(
        accessToken: null,
        idToken: googleAuth.idToken,
      );

      // ৫. Firebase এ Sign In সম্পন্ন করো
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // ৬. ইউজার ডাটাবেসে সেভ করো
      if (userCredential.user != null) {
        createDatabase.getCurrentUserDetailsLogged(userCredential.user!, "Google");
      }

      // হোম স্ক্রিনে পাঠিয়ে দাও
      Get.offAllNamed(Routes.homeScreen);

      return userCredential;
    } catch (e) {
      print('Google Sign In Error: $e');
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
