import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/firebase-Database/FirebaseDataBase.dart';
import 'package:parrot_messaging/screens/_home-screen/_chatsPerson.dart';
import '../../getX/_ScreenManagement/_screenManagement.dart';

class MessageTiles extends StatelessWidget {
  final FirebaseDataBase currentLoggedUser;
  final bool isDark;
  final Future<void> Function() onRefresh;

  const MessageTiles({
    super.key,
    required this.currentLoggedUser,
    required this.isDark,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(20),
        ),
        color: isDark ? const Color(0x804E4D4D) : const Color(0xFFF6E9FB),
      ),
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: Obx(
          () => ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: currentLoggedUser.userEmails.length,
            itemBuilder: (context, index) {
              final user = currentLoggedUser.userEmails[index];
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
                },
                isDark: isDark,
              );
            },
          ),
        ),
      ),
    );
  }
}
