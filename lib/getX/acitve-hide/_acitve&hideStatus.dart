import 'package:get/get.dart';

import '../../Utills/_constant.dart';

class ActiveUser extends GetxController {
  Rx<ActiveStatus> selectedOption = ActiveStatus.everyone.obs;
}

class HideMe extends GetxController {
  Rx<HideUser> selectedOption = HideUser.nobody.obs;
}