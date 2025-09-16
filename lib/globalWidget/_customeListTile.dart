import 'package:flutter/material.dart';

class CustomeListTile extends StatelessWidget {
  final tileIcon;
  final tileTitle;
  final tileColor;
  final tileSubtitle;
  const CustomeListTile({super.key, this.tileIcon, this.tileTitle, this.tileColor, this.tileSubtitle});

  @override
  Widget build(BuildContext context) {

    return ListTile(
      leading:tileIcon,
      title: tileTitle,
      textColor: tileColor,
      subtitle: tileSubtitle,
    );
  }
}
