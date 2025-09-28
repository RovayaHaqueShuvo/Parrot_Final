import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/screens/_home-screen/_messageTile.dart';
import 'package:parrot_messaging/screens/_home-screen/_listView.dart';
import 'package:parrot_messaging/screens/_onBoarding-screen/_customWidget.dart';

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
    final CurrentLoggedUser currentLoggedUserController = Get.put(
      CurrentLoggedUser(),
    );
    currentLoggedUserController.fetchActiveOthersUsers();
    final NetworkController networkController = Get.put(NetworkController());
    currentLoggedUserController.getCurrentUserDetailsLoggedGoogle();
    currentLoggedUserController.fetchAllUsers();
    // networkController.setUserActive();
    networkController.bindUserStatus();
    super.initState();
  }

  final NetworkController networkController = Get.put(NetworkController());
  final BottomNavigationController bottomNavigationController = Get.put(
    BottomNavigationController(),
  );

  final CurrentLoggedUser currentLoggedUserController = Get.put(
    CurrentLoggedUser(),
  );

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // ✅ default back prevent করবে
      onPopInvoked: (didPop) {
        if (didPop) return; // যদি pop হয়ে থাকে তাহলে কিছু করবে না

        // এখানে তোমার কাস্টম ব্যাক হ্যান্ডলিং হবে
        exit(0);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF012B0D),
          appBar: AppBar(
            backgroundColor: Color(0xFF012B0D),
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search_outlined),
              color: Colors.white,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black54),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1000),
                  ),
                ),
              ),
            ),
            centerTitle: true,
            title: Obx(
              () =>
                  networkController.isConnected.value
                      ? Text(
                        "H O M E",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      : Text(
                        "❌ No Internet Connection",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
            ),
            actions: [
              Obx(() => ImageIconBorder(
          index: 1,
          imageName: currentLoggedUserController.photourl.value.isNotEmpty
              ? currentLoggedUserController.photourl.value
              : "assets/images/parrot.png", // ✅ এখানে কাজ করবে
          fromletfSpacing: 12,
          onPressed: () {
            print(currentLoggedUserController.userEmails());
          },
          size: 42, controller: networkController,
        )),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                CustomListView(currentLoggedUserController: currentLoggedUserController,),
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
                  onTap: () {
                    Get.toNamed(Routes.chatBoardScreen);
                    print('Message Tile Cliked');
                  },
                ),
              ],
            ),
          ),
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
