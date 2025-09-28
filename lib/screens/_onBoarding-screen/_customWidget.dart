import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:parrot_messaging/_gobal-supply/_internetConnection.dart';

class ImageIconBorder extends StatelessWidget {
  final String imageName;
  final int index;
  final int activeCode;
  final VoidCallback? onPressed;
  final double size;
  final double fromletfSpacing;
  final NetworkController? controller;

  // size of the circle

  const ImageIconBorder({
    super.key,
    required this.imageName,
    this.onPressed,
    this.size = 55, // default size
    this.fromletfSpacing = 0,
    this.index = 0,
    this.activeCode = 0,
    this.controller, // default size
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: activeCode == 1 ? Colors.green : Colors.grey,
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
            border:
            (controller?.isActive.value ?? false)
                    ? Border.all(color: Colors.green, width: 2)
                    : Border.all(color: Colors.grey, width: 1),
          ),
          padding: const EdgeInsets.all(1),
          child: ClipOval(
            child:
                index == 1
                    ? OctoImage(
                      image: CachedNetworkImageProvider(imageName),
                      placeholderBuilder:
                          (context) =>
                              Center(child: CircularProgressIndicator()),
                      errorBuilder:
                          (context, error, stackTrace) =>
                              Stack(children: [Icon(Icons.error)]),
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    )
                    : Image.asset(imageName, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
