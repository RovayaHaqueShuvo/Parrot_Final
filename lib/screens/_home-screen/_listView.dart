import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:parrot_messaging/_gobal-supply/_loggedUser.dart';

import '../../Utills/_constant.dart';
import '../../globalWidget/_customWidget.dart';

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
            final user = currentLoggedUserController.activeUsersData[index];
            final email = user[EMAIL];
            final photoUrl = user[PHOTO_URL] ?? 'assets/parrot.png';
            return GestureDetector(
              key: ValueKey(email),
              onTap: () {
                print('Tapped ${email}');
                print('Tapped ${photoUrl}');
              },
              child: Column(
                children: [
                   NetworkImages(
                    imageName: photoUrl,
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
