import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../_gobal-supply/_internetConnection.dart';
import '../../getX/_screenManagement.dart';
import '../../getX/theme-mode/theme_mode_getX.dart';
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
    final ThemeController thememodeController = Get.put(ThemeController());
    final Size distance = MediaQuery.of(context).size;
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
            backgroundColor: Colors.transparent,
            leadingWidth: 150,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Notification",
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
            title: Obx(
              () =>
                  networkController.isConnected.value
                      ? Text("")
                      : Text(
                        "❌ No Internet Connection",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
            ),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
            ],
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  "History",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
              SizedBox(width: distance.width*.01),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Massage request",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
              SizedBox(width: distance.width*.01),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Spam",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
            ],
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
