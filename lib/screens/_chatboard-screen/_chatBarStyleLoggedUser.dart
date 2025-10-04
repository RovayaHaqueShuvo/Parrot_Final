import 'package:flutter/material.dart';

import '../../globalWidget/_customWidget.dart' show NetworkImages;

class ChatBarStyleLogedUser extends StatelessWidget {
  final String massage;
  final String userPhoto;
  const ChatBarStyleLogedUser({super.key, required this.massage, required this.userPhoto});

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
          color: Colors.blue[200],
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
                      style: const TextStyle(fontSize: 12, color: Color(
                          0xFFFDD7D7)),
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(width: 10),
            NetworkImages(imageName: userPhoto, size: 30),
          ],
        ),
      ),
    );

  }
}
