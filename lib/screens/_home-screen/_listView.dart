import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:parrot_messaging/_gobal-supply/_loggedUser.dart';

import '../_onBoarding-screen/_customWidget.dart';

class CustomListView extends StatelessWidget {
  final int itemCount;
  final CurrentLoggedUser currentLoggedUserController;

  const CustomListView({
    super.key,
    this.itemCount = 100,
    required this.currentLoggedUserController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          MediaQuery.of(context).size.height *
          0.1, // Height of the horizontal list
      child: Obx(() => SizedBox(
        height: 100, // adjust height
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: currentLoggedUserController.activeUsersData.length,
          itemBuilder: (context, index) {
            final user = currentLoggedUserController.userEmails[index];
            return GestureDetector(
              key: ValueKey(user.email),
              onTap: () {
                debugPrint('Tapped ${user.email}');
              },
              child: Column(
                children: [
                   ImageIconBorder(
                    index: 1,
                    imageName: user.photoUrl.isNotEmpty
                        ? user.photoUrl
                        : "assets/images/parrot.png", // যদি empty হয় default image
                    fromletfSpacing: 12,
                    size: MediaQuery.of(context).size.height*.07,
                    onPressed: () {
                      // এখানে userEmails দেখানো হবে
                      print(currentLoggedUserController.userEmails.map((user) => user.email).toList());
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ))

    );
  }
}
