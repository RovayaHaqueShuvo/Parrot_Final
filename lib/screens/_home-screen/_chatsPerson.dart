import 'package:flutter/material.dart';
import 'package:parrot_messaging/screens/_onBoarding-screen/_customWidget.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 08),
      child: ListTile(
        leading: ImageIconBorder(
          imageName: 'assets/parrot.png',
          onPressed: () {},
        ),
        title: Text(
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
              style: TextStyle(fontSize: 18, color: Colors.red,fontWeight: FontWeight.bold,),
            ),
          ],
        ),
      ),
    );
  }
}
