import 'package:flutter/material.dart';
import 'package:parrot_messaging/models/_userModel.dart';
import 'package:parrot_messaging/globalWidget/_customWidget.dart';

import '../../firebase-Database/FirebaseDataBase.dart';
import '../../globalWidget/_customeLocalImgesdecoration.dart';

class MessageTile extends StatelessWidget {
  final VoidCallback onTap;
  final UserModel user;
  final bool isDark;

  const MessageTile({
    super.key,
    required this.onTap,
    required this.user,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 02),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey : Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: ListTile(
          onTap: onTap,
          leading: NetworkImages(imageName: user.photoUrl, onPressed: () {}),
          title:
              user.name.isNotEmpty
                  ? Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 1, // 👉 এক লাইনে সীমাবদ্ধ করবে
                    overflow:
                        TextOverflow.ellipsis, // 👉 অতিরিক্ত হলে "..." দেখাবে
                  )
                  : Text(
                    "Parrot",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
          subtitle: Text(
            "I got message for you. Will you please check it out?",
            maxLines: 1,
            // Limit to 1 line
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "0 mint ago",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
              Text(
                "3",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
