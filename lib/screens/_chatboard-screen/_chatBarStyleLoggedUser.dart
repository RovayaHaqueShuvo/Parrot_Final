import 'package:flutter/material.dart';

import '../_onBoarding-screen/_customWidget.dart' show ImageIconBorder;

class ChatBarStyleLogedUser extends StatelessWidget {
  final String massage;
  const ChatBarStyleLogedUser({super.key, required this.massage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 05, vertical: 02),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(

            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          color: Colors.blue[200],
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageIconBorder(imageName: 'assets/parrot.png', size: 30),
            const SizedBox(width: 10),
            // Column for text + timestamp
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    massage,
                    style: const TextStyle(fontSize: 18, color: Colors.white70),
                    softWrap: true,
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "08:02 AM",
                      style: const TextStyle(fontSize: 12, color: Color(
                          0xFFFDD7D7)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}
