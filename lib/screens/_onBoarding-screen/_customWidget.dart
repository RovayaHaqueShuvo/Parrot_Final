import 'package:flutter/material.dart';

class ImageIconBorder extends StatelessWidget {
  final String imageName;
  final VoidCallback? onPressed;
  final double size;
  final double fromletfSpacing;

  // size of the circle

  const ImageIconBorder({
    super.key,
    required this.imageName,
    this.onPressed,
    this.size = 55, // default size
    this.fromletfSpacing = 0, // default size
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
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
            border: Border.all(color: Colors.grey, width: 1),
          ),
          padding: const EdgeInsets.all(5),
          child: ClipOval(child: Image.asset(imageName, fit: BoxFit.contain)),
        ),
      ),
    );
  }
}
