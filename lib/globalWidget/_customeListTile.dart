import 'package:flutter/material.dart';

class CustomeListTile extends StatelessWidget {
  final tileIcon;
  final tileTitle;
  final tileColor;
  final tileSubtitle;
  final trailing;

  const CustomeListTile({
    super.key,
    this.tileIcon,
    this.tileTitle,
    this.tileColor,
    this.tileSubtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: trailing,
      leading: tileIcon,
      title: tileTitle,
      textColor: tileColor,
      subtitle: tileSubtitle,
    );
  }
}
