import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/firebase-Database/FirebaseDataBase.dart';
import 'package:parrot_messaging/getX/_screenManagement.dart';

class AuthVerificationWithFacebookAndSignIn extends GetxController {
  final createDatabase = Get.put(FirebaseDataBase());
  var isLoading = false.obs;

  Future<UserCredential?> signInWithFacebook() async {
    try {
      isLoading.value = true;
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
            
        // Firebase এ Sign In সম্পন্ন করো
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);

        // ইউজার ডাটাবেসে সেভ করো
        if (userCredential.user != null) {
          createDatabase.getCurrentUserDetailsLogged(
            userCredential.user!,
            "Facebook",
          );
        }
        
        // হোম স্ক্রিনে পাঠিয়ে দাও
        Get.offAllNamed(Routes.homeScreen);

        return userCredential;
      } else {
        print('Facebook Sign In Status: ${loginResult.status}');
        return null;
      }
    } catch (e) {
      print('Facebook Sign In Error: $e');
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
