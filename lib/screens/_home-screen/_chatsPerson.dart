import 'package:flutter/material.dart';
import 'package:parrot_messaging/screens/_onBoarding-screen/_customWidget.dart';

class MessageTile extends StatelessWidget {
  final VoidCallback  onTap;
  const MessageTile({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 02),
      decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
    ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: ListTile(
          onTap: onTap,
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
      ),
    );
  }
}
