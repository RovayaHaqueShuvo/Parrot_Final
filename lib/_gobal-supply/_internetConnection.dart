import 'dart:async';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkController extends GetxController {
  var isConnected = true.obs;
  late StreamSubscription<InternetConnectionStatus> listener;

  @override
  void onInit() {
    super.onInit();

    // InternetConnectionChecker singleton instance ব্যবহার
    final checker = InternetConnectionChecker.createInstance();

    listener = checker.onStatusChange.listen((status) {
      isConnected.value = (status == InternetConnectionStatus.connected);
    });
  }

  @override
  void onClose() {
    listener.cancel();
    super.onClose();
  }
}
