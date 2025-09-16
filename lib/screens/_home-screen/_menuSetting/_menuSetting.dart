import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/_gobal-supply/_logout.dart';
import 'package:parrot_messaging/globalWidget/_containerApp.dart';
import 'package:parrot_messaging/globalWidget/_customeButton.dart';

import '../../../_gobal-supply/_internetConnection.dart';
import '../../../getX/_screenManagement.dart';
import '../_bottomNavigationController.dart';

class MenuSetting extends StatelessWidget {
  const MenuSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final NetworkController networkController = Get.put(NetworkController());
    final AuthController logoutController = Get.put(AuthController());
    final BottomNavigationController bottomNavigationController = Get.put(
      BottomNavigationController(),
    );
    return WillPopScope(
      onWillPop: ()async{
        Get.offAllNamed(Routes.homeScreen);
        return Future.value(false);
      },
      child:  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Text(""),
          title: Obx(
                () =>
            networkController.isConnected.value
                ? Text(
              "S E T T I N G",
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomeBotton(
                    barColor: Colors.grey,
                    text: "PROFILE SETTING",
                    fontSize: 18,
                    fontColor: Colors.black,
                    barRadiusColor: Colors.white,
                    OnPressed: () => Get.toNamed(Routes.userProfileSetting),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                  CustomeBotton(
                    barColor: Colors.white,
                    text: "THEME MODE",
                    fontSize: 18,
                    fontColor: Colors.black,
                    barRadiusColor: Colors.black,
                    OnPressed: () => Get.toNamed(Routes.userProfileSetting),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                  CustomeBotton(
                    barColor: Colors.grey,
                    text: "SHARED MEDIA",
                    fontSize: 18,
                    fontColor: Colors.black,
                    barRadiusColor: Colors.white,
                    OnPressed: () => Get.toNamed(Routes.userProfileSetting),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                  CustomeBotton(
                    barColor: Colors.grey,
                    text: "FRIEND LIST",
                    fontSize: 18,
                    fontColor: Colors.black,
                    barRadiusColor: Colors.white,
                    OnPressed: () => Get.toNamed(Routes.userProfileSetting),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                  CustomeBotton(
                    barColor: Colors.grey,
                    text: "NOTIFICATION SETTING",
                    fontSize: 18,
                    fontColor: Colors.black,
                    barRadiusColor: Colors.white,
                    OnPressed: () => Get.toNamed(Routes.userProfileSetting),
                  ),
                ],
              ),
              CustomeBotton(
                barColor: Colors.grey,
                text: "LOG OUT",
                fontSize: 18,
                fontColor: Colors.black,
                barRadiusColor: Colors.white,
                OnPressed: () => logoutController.logout(),
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
    ), );
  }
}
