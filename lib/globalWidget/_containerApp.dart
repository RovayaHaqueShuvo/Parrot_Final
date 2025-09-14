import 'dart:ffi';

import 'package:flutter/material.dart';

class EditableContainer extends StatelessWidget {
  final Widget widget;
  final String hintText;
  final IconData? prefixIcon;
  final bool isPassword;
  final double borderRadius;
  final Color backgroundColor;
  final double height;
  final double width;

  const EditableContainer({
    super.key,
    required this.widget,
    this.hintText = "",
    this.prefixIcon,
    this.isPassword = false,
    this.borderRadius = 12,
    this.backgroundColor = const Color(0xFF4A4A4A),
   this.height=200,
    this.width=200,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.all(18),
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Padding(
          padding:EdgeInsets.all(10),
          child: widget),
    );
  }
}
