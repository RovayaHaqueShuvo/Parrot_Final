import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/screens/_chatboard-screen/chatBoardScreen.dart';
import 'package:parrot_messaging/screens/_home-screen/homeScreen.dart';
import 'package:parrot_messaging/screens/_onBoarding-screen/onBoardingScreen.dart';
import 'package:parrot_messaging/screens/_splash-screen/splashScreen.dart';


import '../screens/_home-screen/_bottomNotification.dart';
import '../screens/_home-screen/_menuSetting/_menuSetting.dart';
import '../screens/_userProfile-screen/_userProfileSetting.dart';
import '../screens/_login-screen/loginScreen.dart';
import '../screens/_signUp-screen/signUpScreen.dart';

class Routes {
  static String splashScreen = "/splash";
  static String onBoardingScreen = "/onboarding";
  static String loginScreen = "/login";
  static String registerScreen = "/register";
  static String homeScreen = "/home";
  static String chatBoardScreen = "/chatBoard";
  static String homeScreenSetting = "/homeScreenSetting";
  static String bottomNotification = "/bottomNotification";
  static String userProfileSetting = "/userProfileSetting";
}

class RoutesPages {
  static List<GetPage<dynamic>>? routes = [
    GetPage(name: Routes.splashScreen, page: () => Splashscreen()),
    GetPage(name: Routes.onBoardingScreen, page: () => Onboardingscreen()),
    GetPage(name: Routes.loginScreen, page: () => Loginscreen()),
    GetPage(name: Routes.registerScreen, page: () => Signupscreen()),
    GetPage(name: Routes.homeScreen, page: () => Homescreen()),
    GetPage(
      name: Routes.chatBoardScreen,
      page: () {
        final userData = Get.arguments as Map<String, dynamic>?;

        if (userData == null || userData.isEmpty) {
          return const Scaffold(
            body: Center(child: Text('Invalid user data')),
          );
        }

        return Chatboardscreen(userData: userData); // Map safely পাঠানো হচ্ছে
      },
    ),
    GetPage(name: Routes.homeScreenSetting, page: () => MenuSetting()),
    GetPage(name: Routes.bottomNotification, page: () => BottomNotification()),
    GetPage(name: Routes.userProfileSetting, page: () => UserProfileSetting()),
  ];
}
