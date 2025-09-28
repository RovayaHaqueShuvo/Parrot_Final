import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/globalWidget/_containerApp.dart';
import 'package:parrot_messaging/screens/_onBoarding-screen/_customWidget.dart';

import '../../../../_gobal-supply/_internetConnection.dart';
import '../../../../_gobal-supply/_loggedUser.dart';
import '../../../../globalWidget/_customeListTile.dart';

class UserProfileSetting extends StatelessWidget {
  const UserProfileSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final NetworkController networkController = Get.put(NetworkController());
    final CurrentLoggedUser currentLoggedUser = Get.put(CurrentLoggedUser());
    currentLoggedUser.getCurrentUserDetailsLoggedGoogle();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Obx(
            () =>
                networkController.isConnected.value
                    ? Text(
                      "P R O F I L E   S E T T I N G",
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
        body: Obx(
          () => EditableContainer(
            height: MediaQuery.of(context).size.height * 0.87,
            width: MediaQuery.of(context).size.height * 0.44,
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ImageIconBorder(
                  index: 1,
                  imageName: currentLoggedUser.photourl.value,
                  size: 120,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                Text(
                  currentLoggedUser.name.value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  currentLoggedUser.currentEmail.value,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "P r o f i l e",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.001),
                CustomeListTile(
                  tileIcon: Obx(
                    () =>
                        networkController.isActive.value
                            ? Icon(Icons.circle, color: Colors.green)
                            : Icon(Icons.circle, color: Colors.grey),
                  ),
                  tileTitle: Text(
                    "A C T I V E  S T A T U S",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  tileColor: Colors.white,
                  tileSubtitle: Obx(
                    () =>
                        networkController.isActive.value
                            ? Text(
                              "Online",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                            : Text(
                              "Offline",
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                  ),
                  trailing: Obx(
                    () => Switch(
                      value: networkController.isActive.value,
                      onChanged: (value) async {
                        // আগে একটা confirmation dialog দেখাই
                        Get.defaultDialog(
                          title: "Confirmation",
                          middleText:
                              value
                                  ? "Do you really want to turn this ON?"
                                  : "Do you really want to turn this OFF?",
                          textCancel: "No",
                          textConfirm: "Yes",
                          confirmTextColor: Colors.white,
                          onConfirm: () {
                            networkController.isActive.value = value;

                            /// 🔥 Firebase এও update করতে চাইলে এখানে call করো
                            networkController.updateUserStatus(value);

                            Get.back(); // dialog বন্ধ করবে
                          },
                          onCancel: () {
                            Get.back(); // cancel করলে dialog বন্ধ
                          },
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.001),
                CustomeListTile(
                  tileIcon: Icon(Icons.alternate_email, color: Colors.white),
                  tileTitle: Text(
                    "U S E R  N A M E",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  tileColor: Colors.white,
                  tileSubtitle: Text(
                    currentLoggedUser.uid.value,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
