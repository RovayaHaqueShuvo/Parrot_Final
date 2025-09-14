import 'package:flutter/material.dart';
import 'package:parrot_messaging/screens/_home-screen/_chatsPerson.dart';

class ChatBody extends StatelessWidget {
  final VoidCallback  onTap;
  const ChatBody({super.key,required this.onTap});

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
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 08),
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return MessageTile(
              onTap: onTap,
            );
          },
        ),
      ),
    );
  }
}
