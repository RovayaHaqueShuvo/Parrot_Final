import 'package:get/get.dart';
import 'package:parrot_messaging/screens/_home-screen/homeScreen.dart';
import 'package:parrot_messaging/screens/_onBoarding-screen/onBoardingScreen.dart';
import 'package:parrot_messaging/screens/_splash-screen/splashScreen.dart';

import '../screens/_login-screen/loginScreen.dart';
import '../screens/_signUp-screen/signUpScreen.dart';

class Routes{
   static String splashScreen = "/splash";
   static String onBoardingScreen = "/onboarding";
   static String loginScreen = "/login";
   static String registerScreen = "/register";
   static String homeScreen = "/home";
}
class RoutesPages{
  static List<GetPage<dynamic>>? routes=[
    GetPage(name: Routes.splashScreen, page: ()=>Splashscreen()),
    GetPage(name: Routes.onBoardingScreen, page: ()=>Onboardingscreen()),
    GetPage(name: Routes.loginScreen, page: ()=>Loginscreen()),
    GetPage(name: Routes.registerScreen, page: ()=>Signupscreen()),
   GetPage(name: Routes.homeScreen, page: ()=>Homescreen()),
  ];
}