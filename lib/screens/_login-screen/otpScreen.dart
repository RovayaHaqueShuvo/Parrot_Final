import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../authService/auth_verification_with_phone_and_signin.dart';
import '../../getX/theme-mode/theme_mode_getX.dart';

class OTPscreen extends StatelessWidget {
  const OTPscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size distance = MediaQuery.of(context).size;
    final ThemeController thememodeController = Get.put(ThemeController());
    final phoneVerifiedController = Get.put(
      Authverificationwithphoneandsignin(),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Varification Code",
              style: GoogleFonts.orbitron(
                color:
                    thememodeController.isDarkMode.value
                        ? Colors.white
                        : Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("We've sent a verification code via your number.\nPlease Enter below :"),
            SizedBox(height: distance.height*.05,),
            OtpTextField(
              numberOfFields: 6,
              borderColor: Colors.grey.shade400,
              focusedBorderColor: Colors.teal,
              enabledBorderColor: Colors.grey.shade300,
              cursorColor: Colors.teal,

              showFieldAsBox: true,
              fieldWidth: 48,
              borderRadius: BorderRadius.circular(14),
              borderWidth: 1.5,

              textStyle: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),

              decoration: InputDecoration(
                fillColor: Theme.of(context).cardColor,
                filled: true,
              ),

              onCodeChanged: (String code) {},

              onSubmit: (String verificationCode) {
                phoneVerifiedController.otpController.text = verificationCode;
                phoneVerifiedController.verifyOTP();
              },
            ),
            SizedBox(height: distance.height*.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have any code?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).shadowColor,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to the sign up screen
                    phoneVerifiedController.sendOTP();
                  },
                  child: Text(
                    "Get Code",
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
