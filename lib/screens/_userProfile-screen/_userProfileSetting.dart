import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/globalWidget/_containerApp.dart';
import 'package:parrot_messaging/globalWidget/_customWidget.dart';

import '../../_gobal-supply/_internetConnection.dart';
import '../../_gobal-supply/_loggedUser.dart';
import '../../globalWidget/_customeListTile.dart';

class UserProfileSetting extends StatelessWidget {
  final bool isCurrentUser;
  final String golbeUserName;
  final String golbeUserUID;
  final String golbeUserEmail;
  final String golbeUserPhotoURL;
  final bool golbeUserActiveStues;

  const UserProfileSetting({
    super.key,
    this.isCurrentUser = true,
    this.golbeUserName = '',
    this.golbeUserUID = '',
    this.golbeUserEmail = '',
    this.golbeUserPhotoURL = '',
    this.golbeUserActiveStues = false,
  });

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
        body:
            isCurrentUser == true
                ? Obx(
                  () => EditableContainer(
                    height: MediaQuery.of(context).size.height * 0.87,
                    width: MediaQuery.of(context).size.height * 0.44,
                    widget: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        !isCurrentUser
                            ? NetworkImages(
                              imageName: golbeUserPhotoURL,
                              size: 120,
                            )
                            : NetworkImages(
                              imageName: currentLoggedUser.photourl.value,
                              size: 120,
                            ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.018,
                        ),
                        !isCurrentUser
                            ? Text(
                              golbeUserName,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                            : Text(
                              currentLoggedUser.name.value,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                        !isCurrentUser
                            ? Text(
                              golbeUserEmail,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                            : Text(
                              currentLoggedUser.currentEmail.value,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.018,
                        ),
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.001,
                        ),
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
                          tileSubtitle:
                              !isCurrentUser
                                  ? Obx(
                                    () =>
                                        golbeUserActiveStues == true
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
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                              ),
                                            ),
                                  )
                                  : Obx(
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
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                              ),
                                            ),
                                  ),
                          trailing:
                              !isCurrentUser
                                  ? ""
                                  : Obx(
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
                                            networkController.isActive.value =
                                                value;

                                            /// 🔥 Firebase এও update করতে চাইলে এখানে call করো
                                            networkController.updateUserStatus(
                                              value,
                                            );

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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.001,
                        ),
                        CustomeListTile(
                          tileIcon: Icon(
                            Icons.alternate_email,
                            color: Colors.white,
                          ),
                          tileTitle: Text(
                            "U S E R  N A M E",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          tileColor: Colors.white,
                          tileSubtitle:
                              !isCurrentUser
                                  ? Text(
                                    golbeUserUID,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70,
                                    ),
                                  )
                                  : Text(
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
                )
                : EditableContainer(
                  height: MediaQuery.of(context).size.height * 0.87,
                  width: MediaQuery.of(context).size.height * 0.44,
                  widget: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      !isCurrentUser
                          ? NetworkImages(
                            imageName: golbeUserPhotoURL,
                            size: 120,
                          )
                          : NetworkImages(
                            imageName: currentLoggedUser.photourl.value,
                            size: 120,
                          ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.018,
                      ),
                      !isCurrentUser
                          ? Text(
                            golbeUserName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                          : Text(
                            currentLoggedUser.name.value,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                      !isCurrentUser
                          ? Text(
                            golbeUserEmail,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                          : Text(
                            currentLoggedUser.currentEmail.value,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.018,
                      ),
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.001,
                      ),
                      CustomeListTile(
                        tileIcon:
                            networkController.isActive.value
                                ? Icon(Icons.circle, color: Colors.green)
                                : Icon(Icons.circle, color: Colors.grey),
                        tileTitle: Text(
                          "A C T I V E  S T A T U S",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        tileColor: Colors.white,
                        tileSubtitle:
                            golbeUserActiveStues == true
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
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.001,
                      ),
                      CustomeListTile(
                        tileIcon: Icon(
                          Icons.alternate_email,
                          color: Colors.white,
                        ),
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
                          golbeUserUID,
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
    );
  }
}
