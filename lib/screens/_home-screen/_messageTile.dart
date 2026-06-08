import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:parrot_messaging/firebase-Database/FirebaseDataBase.dart';
import 'package:parrot_messaging/screens/_home-screen/_chatsPerson.dart';
import '../../getX/_screenManagement.dart';

class MessageTiles extends StatelessWidget {
  final FirebaseDataBase currentLoggedUser;
  final bool isDark;

  const MessageTiles({super.key, required this.currentLoggedUser, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.664,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(20),
        ),
        color: isDark? Color(0x804E4D4D)  : Color(0xFFF6E9FB),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: ListView.builder(
          itemCount: currentLoggedUser.userEmails.length,
          itemBuilder: (context, index) {
            final user = currentLoggedUser.userEmails[index];
            print('User: $user, UID Type: ${user.uid.runtimeType}');
            return MessageTile(
              user: user,
              onTap: () {
                Get.toNamed(
                  Routes.chatBoardScreen,
                  arguments: {
                    'UID':
                        user.uid is String ? user.uid : (user.uid?['id'] ?? ''),
                    'NAME': user.name is String ? user.name : 'Unknown',
                    'EMAIL': user.email is String ? user.email : '',
                    'PHOTO_URL': user.photoUrl is String ? user.photoUrl : '',
                  },
                );
                print('Message Tile Clicked: ${user}');
              }, isDark: isDark,
            );
          },
        ),
      ),
    );
  }
}
