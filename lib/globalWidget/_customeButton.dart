import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class CustomeBotton extends StatelessWidget {
  final Callback OnPressed;
  final Color barColor;
  final Color barRadiusColor;
  final String text;
  final double fontSize;
  final Color fontColor;

  const CustomeBotton({
    super.key,
    required this.barColor,
    required this.text,
    required this.fontSize,
    required this.fontColor,
    required this.barRadiusColor, required this.OnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: OnPressed,
      child: Container(
        height: MediaQuery.of(context).size.height * .05,
        width: MediaQuery.of(context).size.width * .85,
        decoration: BoxDecoration(
          color: barColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: barRadiusColor, width: 1),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize, color: fontColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
