import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parrot_messaging/getX/theme-mode/theme_mode_getX.dart';
import 'package:parrot_messaging/screens/_home-screen/_messageTile.dart';
import 'package:parrot_messaging/screens/_home-screen/_listView.dart';
import 'package:parrot_messaging/globalWidget/_customWidget.dart';

import '../../_gobal-supply/_internetConnection.dart';
import '../../_gobal-supply/_loggedUser.dart';
import '../../getX/_screenManagement.dart';
import '_bottomNavigationController.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    currentLoggedUserController.fetchActiveOthersUsers();
    final NetworkController networkController = Get.put(NetworkController());
    currentLoggedUserController.getCurrentUserDetailsLoggedGoogle();
    currentLoggedUserController.fetchAllUsers();
    // networkController.setUserActive();
    networkController.bindUserStatus();
    super.initState();
  }

  final NetworkController networkController = Get.put(NetworkController());
  final ThemeController thememodeController = Get.put(ThemeController());
  final BottomNavigationController bottomNavigationController = Get.put(
    BottomNavigationController(),
  );

  final CurrentLoggedUser currentLoggedUserController = Get.put(
    CurrentLoggedUser(),
  );

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // ✅ default back prevent করবে
      onPopInvoked: (didPop) {
        if (didPop) return; // যদি pop হয়ে থাকে তাহলে কিছু করবে না

        // এখানে তোমার কাস্টম ব্যাক হ্যান্ডলিং হবে
        exit(0);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leadingWidth: 80,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Parrot",
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
              Obx(
                () => NetworkImages(
                  imageName:
                      currentLoggedUserController.photourl.value.isNotEmpty
                          ? currentLoggedUserController.photourl.value
                          : "assets/images/parrot.png",
                  // ✅ এখানে কাজ করবে
                  fromletfSpacing: 12,
                  onPressed: () {
                    print(currentLoggedUserController.userEmails());
                  },
                  size: 42,
                  controller: networkController,
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(70),

              child: Padding(
                padding: const EdgeInsets.all(12.0),

                child: Container(
                  height: 45,

                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(30),
                  ),

                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search...",
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Obx(() {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "All",
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Unread",
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Groups",
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  MessageTiles(
                    currentLoggedUser: currentLoggedUserController,
                    isDark: thememodeController.isDarkMode.value,
                  ),
                ],
              ),
            );
          }),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              currentIndex: bottomNavigationController.selectedIndex.value,
              onTap: bottomNavigationController.onItemTapped,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.mark_chat_unread, color: Colors.green),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_active_sharp),
                  label: 'Notification',
                ),
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
