import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parrot_messaging/_gobal-supply/_logout.dart';
import 'package:parrot_messaging/globalWidget/_containerApp.dart';
import 'package:parrot_messaging/globalWidget/_customeButton.dart';

import '../../../Utills/_customeWidget.dart';
import '../../../_gobal-supply/_internetConnection.dart';
import '../../../getX/_screenManagement.dart';
import '../../../getX/theme-mode/theme_mode_getX.dart';
import '../_bottomNavigationController.dart';

class MenuSetting extends StatelessWidget {
  const MenuSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final NetworkController networkController = Get.put(NetworkController());
    final AuthController logoutController = Get.put(AuthController());
    final ThemeController themeModeController = Get.put(ThemeController());
    final BottomNavigationController bottomNavigationController = Get.put(
      BottomNavigationController(),
    );
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.homeScreen);
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leadingWidth: 120,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Setting",
                  style: GoogleFonts.orbitron(
                    color:themeModeController.isDarkMode.value? Colors.white : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            title: Obx(
              () =>
                  networkController.isConnected.value
                      ? const SizedBox()
                      : const Text(
                        "❌ No Internet Connection",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
            ),

            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// PROFILE SECTION
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 20,
                    ),

                    child: Column(
                      children: [
                        /// PROFILE IMAGE
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 45,
                                backgroundColor: Colors.grey.shade300,
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),

                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        /// NAME
                        Text(
                          "Alex Morgan",
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: themeModeController.isDarkMode.value? Colors.white :Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 5),

                        /// EMAIL
                        Text(
                          "alex.morgan@example.com",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: themeModeController.isDarkMode.value? Colors.white :Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// EDIT BUTTON
                        ElevatedButton(
                          onPressed: () {},

                          style: ElevatedButton.styleFrom(
                            elevation: 1,
                            backgroundColor: themeModeController.isDarkMode.value? Colors.white :Colors.transparent,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),

                          child: Text(
                            "Edit Profile",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// ONLINE STATUS CARD
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),

                    child: Container(
                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(
                        color: themeModeController.isDarkMode.value? Colors.transparent : Color(0xffEEF2F5),
                        borderRadius: BorderRadius.circular(18),

                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Online Status",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                "Show when you're active",
                                style: GoogleFonts.poppins(color: Colors.grey),
                              ),
                            ],
                          ),

                          Switch(
                            value: true,
                            onChanged: (value) {},
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// ACCOUNT TITLE
                  sectionTitle("ACCOUNT"),

                  settingsTile(
                    icon: Icons.person_outline,
                    iconColor: Colors.blue,
                    title: "Profile Information",
                    ontap: () {}, context: context,
                  ),

                  settingsTile(
                    context: context,
                    icon: Icons.shield_outlined,
                    iconColor: Colors.green,
                    title: "Privacy & Security",
                    ontap: () {},
                  ),

                  const SizedBox(height: 20),

                  /// NOTIFICATION TITLE
                  sectionTitle("NOTIFICATIONS"),

                  settingsTile(
                    context: context,
                    icon: Icons.notifications_none,
                    iconColor: Colors.orange,
                    title: "Push Notifications",
                    trailingSwitch: true,
                    ontap: () {},
                  ),

                  settingsTile(
                    context: context,
                    icon: Icons.volume_up_outlined,
                    iconColor: Colors.pink,
                    title: "Sound & Vibration",
                    ontap: () {},
                  ),

                  /// EXTRA EVENTS / OPTIONS
                  const SizedBox(height: 20),

                  sectionTitle("MORE SETTINGS"),

                  settingsTile(
                    context: context,
                    icon: Icons.language,
                    iconColor: Colors.indigo,
                    title: "Language",
                    ontap: () {},
                  ),

                  //Dark Mode
                  Obx(() => ListTile(
                    leading: Icon(
                      themeModeController.isDarkMode.value
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: Colors.teal,
                    ),
                    title: const Text("Dark Mode"),
                    subtitle: Text(
                      themeModeController.isDarkMode.value ? "on" : "off",
                    ),
                    trailing: Switch(
                      value: themeModeController.isDarkMode.value,
                      onChanged: (value) => themeModeController.toggleTheme(),
                      activeColor: Colors.teal,
                    ),
                    onTap: () => themeModeController.toggleTheme(),
                  )),

                  settingsTile(
                    context: context,
                    icon: Icons.lock_outline,
                    iconColor: Colors.red,
                    title: "Change Password",
                    ontap: () {},
                  ),

                  settingsTile(
                    context: context,
                    icon: Icons.storage_outlined,
                    iconColor: Colors.teal,
                    title: "Storage & Cache",
                    ontap: () {},
                  ),

                  settingsTile(
                    context: context,
                    icon: Icons.help_outline,
                    iconColor: Colors.deepPurple,
                    title: "Help Center",
                    ontap: () {},
                  ),

                  settingsTile(
                    context: context,
                    icon: Icons.info_outline,
                    iconColor: Colors.cyan,
                    title: "About App",
                    ontap: () {},
                  ),

                  settingsTile(
                    context: context,
                    icon: Icons.logout,
                    iconColor: Colors.red,
                    title: "Logout",
                    ontap: () {},
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
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
                    color: Colors.grey,
                  ),
                  label: 'Notification',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu, color: Colors.green),
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
