import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/_gobal-supply/_internetConnection.dart';
import 'package:parrot_messaging/getX/_screenManagement.dart';
import 'package:parrot_messaging/globalWidget/_customeButton.dart';
import 'package:parrot_messaging/globalWidget/_customeTextField.dart';

import '../../_gobal-supply/authVerificationWithPhoneAndSignIN.dart';
import '../../globalWidget/_customeLocalImgesdecoration.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();
    final phoneVerifiedController = Get.put(
      Authverificationwithphoneandsignin(),
    );
    final networkController = Get.put(NetworkController());

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          title: Obx(
            () =>
                networkController.isConnected.value
                    ? Text("")
                    : Text(
                      "❌ No Internet Connection",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
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
                  LocalImagesDecoration(
                    imageName: "assets/fb.png",
                    onPressed: () {
                      print("pressed google");
                    },
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  LocalImagesDecoration(
                    imageName: "assets/google.png",
                    onPressed: () {},
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  LocalImagesDecoration(
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
                hintText: "Phone Number",
                controller: phoneVerifiedController.phoneController,
                prefixtext: '+88 ',
              ),
              // CustomTextField(
              //   hintText: "Password",
              //   prefixIcon: Icons.lock_outline,
              //   isPassword: true,
              //   controller: controller.password,
              // ),
              Obx(
                () =>
                    networkController.isActive.value == true
                        ? CustomeBotton(
                          barColor: Colors.grey,
                          text: "Let's Login",
                          fontSize: 24,
                          fontColor: Colors.white,
                          barRadiusColor: Colors.white24,
                          OnPressed: () {
                            if (phoneVerifiedController
                                .phoneController
                                .value
                                .text
                                .isNotEmpty) {
                              Get.snackbar(
                                "No Internet",
                                "Check your internet conncetion. Something went Wrong!",
                              );
                            }
                          },
                        )
                        : CustomeBotton(
                          barColor: Colors.blue,
                          text: "Let's Login",
                          fontSize: 24,
                          fontColor: Colors.white,
                          barRadiusColor: Colors.white24,
                          OnPressed: () {
                            print(phoneController.text);
                            phoneVerifiedController.sendOTP();
                          },
                        ),
              ),

              // SizedBox(height: MediaQuery.of(context).size.height * .02),
              // CustomeBotton(
              //   barColor: Colors.white70,
              //   text: "Sign Up",
              //   fontSize: 24,
              //   fontColor: Colors.blue,
              //   barRadiusColor: Colors.black12,
              //   OnPressed: () => Get.toNamed(Routes.registerScreen),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
