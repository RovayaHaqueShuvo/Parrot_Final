import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../firebase-Database/currrentUserDataModify.dart';
import '../../../../getX/theme-mode/theme_mode_getX.dart';

class EditUserName extends StatelessWidget {
  EditUserName({super.key});

  @override
  Widget build(BuildContext context) {
    // arguments["isPhotoLink"] হতে পারে null, তাই ?? false ব্যবহার করা নিরাপদ
    final bool isPhotoLink = (Get.arguments is Map) ? (Get.arguments["isPhotoLink"] ?? false) : false;
    
    final Currrentuserdatamodify userDataController = Get.find<Currrentuserdatamodify>();
    final ThemeController thememodeController = Get.find<ThemeController>();

    // স্ক্রিনে ঢোকার সময় বর্তমান ভ্যালু সেট করে দেওয়া হচ্ছে
    if (isPhotoLink) {
      userDataController.usernameController.text = userDataController.photoUrl.value;
    } else {
      userDataController.usernameController.text = userDataController.username.value;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: thememodeController.isDarkMode.value ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          isPhotoLink ? "Paste Photo URL" : "Edit Username",
          style: GoogleFonts.orbitron(
            color: thememodeController.isDarkMode.value ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Obx(
            () => userDataController.isLoading.value
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      if (isPhotoLink) {
                        userDataController.updateProfileField('photoUrl', userDataController.usernameController.text.trim());
                      } else {
                        userDataController.updateProfileField('username', userDataController.usernameController.text.trim());
                      }
                    },
                    icon: Icon(
                      Icons.check,
                      color: thememodeController.isDarkMode.value ? Colors.white : Colors.black,
                    ),
                  ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              isPhotoLink
                  ? "Paste a valid link below of your photo url which will be visible in Parrot."
                  : "Your username must be unique and will be visible in search on Parrot.",
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: userDataController.usernameController,
              maxLength: isPhotoLink ? 500 : 28, // লিঙ্কের জন্য লেন্থ বেশি দেওয়া হয়েছে
              decoration: InputDecoration(
                hintText: isPhotoLink ? "Enter photo URL link" : "Enter your unique username",
                prefixIcon: Icon(isPhotoLink ? Icons.link : Icons.alternate_email),
                errorMaxLines: 50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.teal, width: 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
