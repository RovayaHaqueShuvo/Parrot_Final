import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:parrot_messaging/_gobal-supply/_loggedUser.dart';
import 'package:parrot_messaging/screens/_home-screen/_chatsPerson.dart';

class MessageTiles extends StatelessWidget {
  final CurrentLoggedUser currentLoggedUser;
  final VoidCallback onTap;

  const MessageTiles({
    super.key,
    required this.onTap,
    required this.currentLoggedUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.664,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(20),
        ),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 08),
        child: LiquidPullToRefresh(
          color: Colors.tealAccent,                // progress color
          backgroundColor: Colors.lightBlueAccent,     // drop-এর background
          height: 80,                       // drop height
          borderWidth: 3.0,                  // drop border
          animSpeedFactor: 1.5,              // animation smoothness
          showChildOpacityTransition: true,  // fade-in effect
          springAnimationDurationInMilliseconds: 600,
          onRefresh: ()=> currentLoggedUser.fetchAllUsers(),
          child: Obx(
            () => ListView.builder(
              itemCount: currentLoggedUser.userEmails.length,
              itemBuilder: (context, index) {
                final userDetails = currentLoggedUser.userEmails[index];
                return MessageTile(user: userDetails, onTap: onTap);
              },
            ),
          ),
        ),
      ),
    );
  }
}
