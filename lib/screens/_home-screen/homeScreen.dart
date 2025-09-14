import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/screens/_home-screen/_messageTile.dart';
import 'package:parrot_messaging/screens/_home-screen/_listView.dart';
import 'package:parrot_messaging/screens/_onBoarding-screen/_customWidget.dart';

import '../../_gobal-supply/_internetConnection.dart';
import '../../getX/_screenManagement.dart';
import '_bottomNavigationController.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {


  static const List<Widget> _pages = <Widget>[
    Center(child: Text('Home Page')),
    Center(child: Text('Search Page')),
    Center(child: Text('Profile Page')),
  ];

  final NetworkController networkController = Get.put(NetworkController());
  final BottomNavigationController bottomNavigationController = Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            ImageIconBorder(
              imageName: 'assets/parrot.png',
              fromletfSpacing: 12,
              onPressed: () {},
              size: 42,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              CustomListView(),
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
              ChatBody(
                onTap: () {
                  Get.toNamed(Routes.chatBoardScreen);
                  print('Message Tile Cliked');
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(()=>BottomNavigationBar(
          currentIndex: bottomNavigationController.selectedIndex.value,
          onTap: bottomNavigationController.onItemTapped,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.mark_chat_unread,color: Colors.green,),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active_sharp),
              label: 'Notification',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          ],
        ),),
      ),
    );
  }
}
