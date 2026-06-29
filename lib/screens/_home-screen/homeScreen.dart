import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parrot_messaging/getX/_ScreenManagement/_screenManagement.dart';
import 'package:parrot_messaging/getX/theme-mode/theme_mode_getX.dart';
import 'package:parrot_messaging/screens/_home-screen/_messageTile.dart';
import '../../_Firebase_UserFriends/_UsersFriendsCollection.dart';
import '../../_gobal-supply/_internetConnection.dart';
import '../../firebase-Database/FirebaseDataBase.dart';
import '../../firebase-Database/currrentUserDataModify.dart';
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
    // currentLoggedUserController.getCurrentUserDetailsLoggedGoogle();
    currentLoggedUserController.fetchAllUsers();
    // networkController.setUserActive();
    networkController.bindUserStatus();
    //Make user adding In Friend List
    UsersFriendsCollection().userFriends();
    super.initState();
  }

  final NetworkController networkController = Get.put(NetworkController());
  final ThemeController thememodeController = Get.find<ThemeController>();
  final BottomNavigationController bottomNavigationController = Get.put(
    BottomNavigationController(),
  );

  final FirebaseDataBase currentLoggedUserController = Get.put(FirebaseDataBase());

  //User data get From Firebase Firestore
  final userData = Get.put(Currrentuserdatamodify());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
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
                () => Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: InkWell(
                    onTap: () {
                      print(currentLoggedUserController.userEmails());
                    },
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage:
                            userData.photoUrl.value.isNotEmpty
                                ? NetworkImage(userData.photoUrl.value)
                                : const AssetImage("assets/parrot.png")
                                    as ImageProvider,
                      ),
                    ),
                  ),
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
                    color: Theme.of(context).hoverColor, // ভালো প্র্যাকটিস
                    borderRadius: BorderRadius.circular(30),

                    // Border অনুযায়ী ডার্ক/লাইট মোড
                    border: Border.all(
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors
                                  .white24 // Dark mode-এ হালকা সাদা আউটলাইন
                              : Colors
                                  .grey
                                  .shade400, // Light mode-এ ধূসর বর্ডার
                      width: 1.2,
                    ),

                    boxShadow:
                        Theme.of(context).brightness == Brightness.dark
                            ? null
                            : [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () => Get.toNamed(Routes.searchscreen),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white70
                                    : Colors.grey.shade700,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Search...",
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white54
                                      : Colors.grey.shade600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "All",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Unread",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Groups",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Obx(
                  () => MessageTiles(
                    currentLoggedUser: currentLoggedUserController,
                    isDark: thememodeController.isDarkMode.value,
                    onRefresh: () async {
                      await currentLoggedUserController.fetchActiveOthersUsers();
                      await UsersFriendsCollection().userFriends();
                      await currentLoggedUserController.fetchAllUsers();
                    },
                  ),
                ),
              ),
            ],
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
