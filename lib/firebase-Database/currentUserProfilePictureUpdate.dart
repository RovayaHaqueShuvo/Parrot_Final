import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Currentuserprofilepictureupdate extends GetxController {
  File? seleteImage;

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        seleteImage = File(image.path);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
