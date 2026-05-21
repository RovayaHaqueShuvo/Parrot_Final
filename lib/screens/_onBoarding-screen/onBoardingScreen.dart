import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/getX/_screenManagement.dart';

import '../../globalWidget/_customeButton.dart';
import '../../globalWidget/_customeLocalImgesdecoration.dart';

class Onboardingscreen extends StatelessWidget {
  const Onboardingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
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
                    LocalImagesDecoration(imageName: "assets/fb.png", onPressed: () {}),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    LocalImagesDecoration(imageName: "assets/google.png", onPressed: () {}),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    LocalImagesDecoration(imageName: "assets/apple.png", onPressed: () {}),
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

              ],
            ),
          ),
        ),
      ),
    );
  }
}
