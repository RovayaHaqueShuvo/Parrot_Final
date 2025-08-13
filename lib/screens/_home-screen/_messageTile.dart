import 'package:flutter/material.dart';
import 'package:parrot_messaging/screens/_home-screen/_chatsPerson.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.664,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(20),
        ),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return MessageTile();
          },
        ),
      ),
    );
  }
}
