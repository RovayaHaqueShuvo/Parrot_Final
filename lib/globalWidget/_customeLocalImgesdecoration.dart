import 'package:flutter/material.dart';
import 'package:parrot_messaging/_gobal-supply/_internetConnection.dart';

class LocalImagesDecoration extends StatelessWidget {
  final String imageName;
  final VoidCallback? onPressed;
  final double size;
  final double fromletfSpacing;

  // size of the circle

  const LocalImagesDecoration({
    super.key,
    required this.imageName,
    this.onPressed,
    this.size = 55, // default size
    this.fromletfSpacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xfff0f0f0),
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: fromletfSpacing),
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border:Border.all(color: Colors.white70, width: 1),
          ),
          padding: const EdgeInsets.all(4),
          child: ClipOval(
            child: ClipOval(
              child: Image.asset(
                imageName,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
