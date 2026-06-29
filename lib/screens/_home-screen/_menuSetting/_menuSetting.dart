import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parrot_messaging/Utills/_constant.dart';
import 'package:parrot_messaging/_gobal-supply/_logout.dart';
import 'package:parrot_messaging/firebase-Database/currentUserProfilePictureUpdate.dart';

import '../../../Utills/_customeWidget.dart';
import '../../../_gobal-supply/_internetConnection.dart';
import '../../../firebase-Database/currrentUserDataModify.dart';
import '../../../getX/_ScreenManagement/_screenManagement.dart';
import '../../../getX/acitve-hide/_acitve&hideStatus.dart';
import '../../../getX/theme-mode/theme_mode_getX.dart';
import '../_bottomNavigationController.dart';

class MenuSetting extends StatelessWidget {
  const MenuSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final Size distance = MediaQuery.of(context).size;
    final ActiveUser activeStatusController = Get.put(ActiveUser());
    final HideMe hideMeStatusController = Get.put(HideMe());
    final NetworkController networkController = Get.put(NetworkController());
    final AuthController logoutController = Get.put(AuthController());
    final ThemeController themeModeController = Get.put(ThemeController());
    final Currentuserprofilepictureupdate profilePictureController = Get.put(
      Currentuserprofilepictureupdate(),
    );
    final BottomNavigationController bottomNavigationController = Get.put(
      BottomNavigationController(),
    );
    //User data get From Firebase Firestore
    final userData = Get.put(Currrentuserdatamodify());
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        Get.offAllNamed(Routes.homeScreen);
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
                    color:
                        themeModeController.isDarkMode.value
                            ? Colors.white
                            : Colors.black,
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
                            Obx(
                              () => CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 45,
                                  backgroundColor: Colors.grey.shade300,
                                  backgroundImage:
                                      userData.photoUrl.value.isNotEmpty
                                          ? NetworkImage(
                                            userData.photoUrl.value,
                                          )
                                          : const AssetImage(
                                                "assets/parrot.png",
                                              )
                                              as ImageProvider,
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
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return SizedBox(
                                          height: distance.height * .2,
                                          width: double.infinity,
                                          child: Padding(
                                            padding: EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                //Data base User Name
                                                ListTile(
                                                  leading: Icon(Icons.person),
                                                  title: Text(
                                                    "Upload Photo",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    profilePictureController
                                                        .pickImage();
                                                  },
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                    Icons.copy_rounded,
                                                  ),
                                                  title: Text(
                                                    "Paste Link",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    Get.toNamed(
                                                      Routes.editUserName,
                                                      arguments: {
                                                        "isPhotoLink": true,
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        /// NAME
                        Obx(
                          () => Text(
                            userData.name.value.isEmpty
                                ? "Set your name"
                                : userData.name.value,
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color:
                                  themeModeController.isDarkMode.value
                                      ? Colors.white
                                      : Colors.black87,
                            ),
                          ),
                        ),

                        const SizedBox(height: 5),

                        /// EMAIL
                        Obx(
                          () => Text(
                            userData.bio.value.isEmpty
                                ? "No BIO"
                                : userData.bio.value,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color:
                                  themeModeController.isDarkMode.value
                                      ? Colors.white
                                      : Colors.black87,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// EDIT BUTTON
                        ElevatedButton(
                          onPressed: () {},

                          style: ElevatedButton.styleFrom(
                            elevation: 1,
                            backgroundColor:
                                themeModeController.isDarkMode.value
                                    ? Colors.white
                                    : Colors.transparent,
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
                        color:
                            themeModeController.isDarkMode.value
                                ? Colors.transparent
                                : Color(0xffEEF2F5),
                        borderRadius: BorderRadius.circular(18),
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    height: 300,
                                    width: double.infinity,
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        children: [
                                          Text(
                                            "Online Status",
                                            style: GoogleFonts.orbitron(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: distance.height * .01,
                                          ),
                                          Text(
                                            "Who can able to see your active status",
                                          ),
                                          Obx(() {
                                            return Column(
                                              children: [
                                                RadioListTile<ActiveStatus>(
                                                  title: const Text("Everyone"),
                                                  value: ActiveStatus.everyone,
                                                  groupValue:
                                                      activeStatusController
                                                          .selectedOption
                                                          .value,
                                                  onChanged: (value) {
                                                    if (value != null) {
                                                      activeStatusController
                                                          .selectedOption
                                                          .value = value;
                                                    }
                                                  },
                                                  activeColor: Colors.teal,
                                                ),

                                                RadioListTile<ActiveStatus>(
                                                  title: const Text(
                                                    "Only Friends",
                                                  ),
                                                  value:
                                                      ActiveStatus.onlyFriend,
                                                  groupValue:
                                                      activeStatusController
                                                          .selectedOption
                                                          .value,
                                                  onChanged: (value) {
                                                    if (value != null) {
                                                      activeStatusController
                                                          .selectedOption
                                                          .value = value;
                                                    }
                                                  },
                                                  activeColor: Colors.teal,
                                                ),

                                                RadioListTile<ActiveStatus>(
                                                  title: const Text("Nobody"),
                                                  value: ActiveStatus.nobody,
                                                  groupValue:
                                                      activeStatusController
                                                          .selectedOption
                                                          .value,
                                                  onChanged: (value) {
                                                    if (value != null) {
                                                      activeStatusController
                                                          .selectedOption
                                                          .value = value;
                                                    }
                                                  },
                                                  activeColor: Colors.teal,
                                                ),
                                              ],
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Column(
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
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),

                    child: Container(
                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(
                        color:
                            themeModeController.isDarkMode.value
                                ? Colors.transparent
                                : Color(0xffEEF2F5),
                        borderRadius: BorderRadius.circular(18),
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    height: 300,
                                    width: double.infinity,
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        children: [
                                          Text(
                                            "Online Status",
                                            style: GoogleFonts.orbitron(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: distance.height * .01,
                                          ),
                                          Text(
                                            "Who can able to see  your profile",
                                          ),
                                          Obx(() {
                                            return Column(
                                              children: [
                                                RadioListTile<HideUser>(
                                                  title: const Text("Everyone"),
                                                  value: HideUser.everyone,
                                                  groupValue:
                                                      hideMeStatusController
                                                          .selectedOption
                                                          .value,
                                                  onChanged: (value) {
                                                    if (value != null) {
                                                      hideMeStatusController
                                                          .selectedOption
                                                          .value = value;
                                                    }
                                                  },
                                                  activeColor: Colors.teal,
                                                ),

                                                RadioListTile<HideUser>(
                                                  title: const Text(
                                                    "Only Friends",
                                                  ),
                                                  value: HideUser.anonymousUser,
                                                  groupValue:
                                                      hideMeStatusController
                                                          .selectedOption
                                                          .value,
                                                  onChanged: (value) {
                                                    if (value != null) {
                                                      hideMeStatusController
                                                          .selectedOption
                                                          .value = value;
                                                    }
                                                  },
                                                  activeColor: Colors.teal,
                                                ),

                                                RadioListTile<HideUser>(
                                                  title: const Text("Nobody"),
                                                  value: HideUser.nobody,
                                                  groupValue:
                                                      hideMeStatusController
                                                          .selectedOption
                                                          .value,
                                                  onChanged: (value) {
                                                    if (value != null) {
                                                      hideMeStatusController
                                                          .selectedOption
                                                          .value = value;
                                                    }
                                                  },
                                                  activeColor: Colors.teal,
                                                ),
                                              ],
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hide Me",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  "Show when hide from parrot",
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// ACCOUNT TITLE
                  sectionTitle("ACCOUNT"),

                  //Profile Information
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: distance.height,
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Data base User Name
                                  Obx(() {
                                    if (networkController.isConnected.value) {
                                      return Column(
                                        children: [
                                          Text(
                                            "Profile Information",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color:
                                                  themeModeController
                                                          .isDarkMode
                                                          .value
                                                      ? Colors.white
                                                      : Colors.black87,
                                            ),
                                          ),
                                          Obx(
                                            () => CircleAvatar(
                                              radius: 50,
                                              backgroundColor: Colors.white,
                                              child: CircleAvatar(
                                                radius: 45,
                                                backgroundColor:
                                                    Colors.grey.shade300,
                                                backgroundImage:
                                                    userData
                                                            .photoUrl
                                                            .value
                                                            .isNotEmpty
                                                        ? NetworkImage(
                                                          userData
                                                              .photoUrl
                                                              .value,
                                                        )
                                                        : const AssetImage(
                                                              "assets/parrot.png",
                                                            )
                                                            as ImageProvider,
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.person),
                                            title: Text(
                                              userData.name.value.isEmpty
                                                  ? "Name not set yet"
                                                  : userData.name.value,
                                            ),
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.alternate_email,
                                            ),
                                            title: Text(
                                              userData.username.value.isEmpty
                                                  ? "No username"
                                                  : userData.username.value,
                                            ),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.photo),
                                            title: Text(
                                              userData.photoUrl.value.isEmpty
                                                  ? "No photo Found"
                                                  : userData.photoUrl.value,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            trailing:
                                                userData
                                                        .photoUrl
                                                        .value
                                                        .isNotEmpty
                                                    ? IconButton(
                                                      icon: Icon(
                                                        Icons.copy,
                                                        size: 20,
                                                      ),
                                                      onPressed: () {
                                                        Clipboard.setData(
                                                          ClipboardData(
                                                            text:
                                                                userData
                                                                    .photoUrl
                                                                    .value,
                                                          ),
                                                        ).then((_) {
                                                          Get.rawSnackbar(
                                                            title: "Copied",
                                                            message:
                                                                "Photo URL copied to clipboard",
                                                            snackPosition:
                                                                SnackPosition
                                                                    .TOP,
                                                            backgroundColor:
                                                                Colors.teal
                                                                    .withOpacity(
                                                                      0.9,
                                                                    ),
                                                            margin:
                                                                const EdgeInsets.all(
                                                                  10,
                                                                ),
                                                            borderRadius: 10,
                                                          );
                                                        });
                                                      },
                                                    )
                                                    : null,
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.edit),
                                            title: Text(
                                              userData.bio.value.isEmpty
                                                  ? "Bio"
                                                  : userData.bio.value,
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Text(
                                        "❌ No Internet Connection",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Colors.red,
                                        ),
                                      );
                                    }
                                  }),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: settingsTile(
                      icon: Icons.person_outline,
                      iconColor: Colors.blue,
                      title: "Profile Information",
                      ontap: () {},
                      context: context,
                    ),
                  ),

                  ///UserName
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: distance.height * .2,
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Data base User Name
                                  Obx(
                                    () => Text(
                                      userData.username.value.isEmpty
                                          ? "No username"
                                          : userData.username.value,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color:
                                            themeModeController.isDarkMode.value
                                                ? Colors.white
                                                : Colors.black87,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.edit),
                                    title: const Text(
                                      "Edit username",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    onTap:
                                        () => Get.toNamed(
                                          Routes.editUserName,
                                          arguments: {"isPhotoLink": false},
                                        ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.copy_rounded),
                                    title: Text(
                                      "Copy Link",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: settingsTile(
                      icon: Icons.alternate_email,
                      iconColor: Colors.pinkAccent,
                      title: "Username",
                      ontap: () {},
                      context: context,
                    ),
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
                  Obx(
                    () => ListTile(
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
                    ),
                  ),

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
                    ontap: () => logoutController.logout(),
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
