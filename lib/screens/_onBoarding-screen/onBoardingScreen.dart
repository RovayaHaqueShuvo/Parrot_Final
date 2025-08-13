import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/getX/_screenManagement.dart';

import '../../globalWidget/_customeButton.dart';
import '_customWidget.dart';

class Onboardingscreen extends StatelessWidget {
  const Onboardingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/parrot.png",
                  height: MediaQuery.of(context).size.height * .05,
                  fit: BoxFit.cover,
                ),
                Text(
                  "Parrot",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .04),
            Image.asset(
              "assets/theme.png",
              width: MediaQuery.of(context).size.width * .99,
              fit: BoxFit.cover,
            ),
            Text(
              "Our chat app is the perfect way to stay connected with friends and family.",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIconBorder(imageName: "assets/fb.png", onPressed: () {}),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                ImageIconBorder(imageName: "assets/google.png", onPressed: () {}),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                ImageIconBorder(imageName: "assets/apple.png", onPressed: () {}),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .02),
            Text(
              "Or",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white54,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .02),
            CustomeBotton(
              barColor: Colors.white,
              text: "Log In",
              fontSize: 24,
              fontColor: Colors.black,
              barRadiusColor: Colors.transparent,
              OnPressed: () {
                // Navigate to the login screen
                Get.toNamed(Routes.loginScreen);
                print("Button Pressed");
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to the sign up screen
                    Get.toNamed(Routes.registerScreen);
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
