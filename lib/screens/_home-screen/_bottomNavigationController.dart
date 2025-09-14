import 'package:get/get.dart';
import 'package:parrot_messaging/getX/_screenManagement.dart';

class BottomNavigationController extends GetxController {
  RxInt selectedIndex = RxInt(0);

  // BottomNavigation tap function
  void onItemTapped(int index) {
    switch(index){
      case 0:
        Get.toNamed(Routes.homeScreen);
        break;
      case 1:
        Get.toNamed(Routes.bottomNotification);
        break;
      case 2:
        Get.toNamed(Routes.homeScreenSetting);
    }
  }
}
