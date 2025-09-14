import 'package:flutter/material.dart';

import '../_onBoarding-screen/_customWidget.dart' show ImageIconBorder;

class ChatBarStyleGlobalUser extends StatelessWidget {
  final String massage;

  const ChatBarStyleGlobalUser({super.key, required this.massage});

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
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          color: Color(0xFFFF8B8B),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Column for text + timestamp
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    massage,
                    style: const TextStyle(fontSize: 18, color: Colors.white70),
                    softWrap: true,
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "08:02 AM",
                      style: const TextStyle(
                        fontSize: 12,
                        color:Color(0xFFD5E6FD)
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            ImageIconBorder(imageName: 'assets/parrot.png', size: 30),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
