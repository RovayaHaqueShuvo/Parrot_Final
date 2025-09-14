import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/_gobal-supply/_internetConnection.dart';
import 'package:parrot_messaging/globalWidget/_customeButton.dart';
import 'package:parrot_messaging/globalWidget/_customeTextField.dart';
import 'package:parrot_messaging/screens/_onBoarding-screen/_customWidget.dart';
import 'package:parrot_messaging/screens/_signUp-screen/signupButtonFunction.dart';

import '../../getX/_screenManagement.dart';

class Signupscreen extends StatelessWidget {
  const Signupscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpButtonfunctionManagement());
    final networkController = Get.put(NetworkController());

    return SafeArea(child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back)),
        centerTitle: true,
          title: Obx(
                () =>
            networkController.isConnected.value
                ? Text("")
                : Text(
              "❌ No Internet Connection",
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          )
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
              "Sign up to Parrot",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              "Get chatting with friends and family today by signing up for our chat app!",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .02),
            CustomTextField(
              hintText: "Full Name",
              prefixIcon: Icons.drive_file_rename_outline_rounded,
              controller: controller.name,
            ),
            CustomTextField(
              hintText: "Email",
              prefixIcon: Icons.mail_outline,
              controller: controller.email,
            ),
            CustomTextField(
              hintText: "Password",
              prefixIcon: Icons.lock_open,
              isPassword: true,
              controller: controller.password,
            ),
            CustomTextField(
              hintText: "Confirm Password",
              prefixIcon: Icons.lock_outline,
              isPassword: true,
              controller: controller.confirmpassword,
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
              text: "Sign Up",
              fontSize: 24,
              fontColor: Colors.white,
              barRadiusColor: Colors.white24,
              OnPressed: ()=>controller.signUpWithEmailPass(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .02),
            CustomeBotton(
              barColor: Colors.white10,
              text: "Go To Login",
              fontSize: 24,
              fontColor: Colors.blue,
              barRadiusColor: Colors.black12,
              OnPressed: ()=> Get.toNamed(Routes.loginScreen),
            )
          ],
        ),
      ),
    ));
  }
}
