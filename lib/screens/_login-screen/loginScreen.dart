import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/getX/_screenManagement.dart';
import 'package:parrot_messaging/globalWidget/_customeButton.dart';
import 'package:parrot_messaging/globalWidget/_customeTextField.dart';

import '../_onBoarding-screen/_customWidget.dart';
import 'buttonFunction.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ButtonfunctionManagement());
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                "Log in to Parrot",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                "Welcome back! Sign in using your social account or email to continue us",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageIconBorder(imageName: "assets/fb.png", onPressed: () {}),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  ImageIconBorder(
                    imageName: "assets/google.png",
                    onPressed: () {},
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  ImageIconBorder(
                    imageName: "assets/apple.png",
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              Text(
                "Or",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              CustomTextField(
                hintText: "Email",
                prefixIcon: Icons.mail_outline,
                controller: controller.email,
              ),
              CustomTextField(
                hintText: "Password",
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                controller: controller.password,
              ),
              Obx(
                () =>
                    controller.isLoading.value==1
                        ? Column(
                          children: [
                            Center(
                              child: Container(
                                margin:EdgeInsets.all(MediaQuery.of(context).size.height * .03),
                                width: MediaQuery.of(context).size.height * .14,
                                height:
                                    MediaQuery.of(context).size.height * .14,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  // semi-transparent background
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.all(20),
                                child: CircularProgressIndicator(
                                  strokeWidth: 6, // thickness of the circle
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.blueAccent,
                                  ),
                                  backgroundColor: Colors.white24,
                                ),
                              ),
                            ),
                          ],
                        ):SizedBox(
                      height: MediaQuery.of(context).size.height * .16,
                    ),
              ),

              CustomeBotton(
                barColor: Colors.blue,
                text: "Let's Login",
                fontSize: 24,
                fontColor: Colors.white,
                barRadiusColor: Colors.white24,
                OnPressed: () => controller.loginWithEmaiPass(),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              CustomeBotton(
                barColor: Colors.white70,
                text: "Sign Up",
                fontSize: 24,
                fontColor: Colors.blue,
                barRadiusColor: Colors.black12,
                OnPressed: () => Get.toNamed(Routes.registerScreen),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
