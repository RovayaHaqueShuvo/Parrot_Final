import 'package:flutter/material.dart';

import '../../globalWidget/_customWidget.dart' show NetworkImages;

class ChatBarStyleGlobalUser extends StatelessWidget {
  final String userPhoto;
  final String massage;

  const ChatBarStyleGlobalUser({super.key, required this.massage, required this.userPhoto});

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
          color: Color(0xFFFF8B8B),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            NetworkImages(imageName: userPhoto, size: 30),
            const SizedBox(width: 10),
            // Column for text + timestamp
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      massage,
                      style: const TextStyle(fontSize: 18, color: Colors.white70),
                      softWrap: true,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.bottomRight,
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
          ],
        ),
      ),
    );
  }
}
