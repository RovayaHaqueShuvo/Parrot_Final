import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../_gobal-supply/_internetConnection.dart';
import '../../getX/_screenManagement.dart';
import '../../globalWidget/_containerApp.dart';
import '_bottomNavigationController.dart' show BottomNavigationController;

class BottomNotification extends StatelessWidget {
  const BottomNotification({super.key});

  @override
  Widget build(BuildContext context) {
    final networkController = Get.put(NetworkController());
    final BottomNavigationController bottomNavigationController = Get.put(
      BottomNavigationController(),
    );
    return PopScope(
        canPop: false, // ✅ default back prevent করবে
        onPopInvoked: (didPop) {
          if (didPop) return; // যদি pop হয়ে থাকে তাহলে কিছু করবে না

          // এখানে তোমার কাস্টম ব্যাক হ্যান্ডলিং হবে
          Get.offAllNamed(Routes.homeScreen);
        },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: Text(""),
            title: Obx(
              () =>
                  networkController.isConnected.value
                      ? Text(
                        "N O T I F I C A T I O N",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      : Text(
                        "❌ No Internet Connection",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
            ),
            centerTitle: true,
          ),
          body: EditableContainer(
            height: MediaQuery.of(context).size.height * 0.87,
            width: MediaQuery.of(context).size.height * 0.44,
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [],
            ),
          ),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              // 👈 important
              currentIndex: bottomNavigationController.selectedIndex.value,
              onTap: bottomNavigationController.onItemTapped,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.mark_chat_unread, color: Colors.grey),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.notifications_active_sharp,
                    color: Colors.green,
                  ),
                  label: 'Notification',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu, color: Colors.grey),
                  label: 'Menu',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
