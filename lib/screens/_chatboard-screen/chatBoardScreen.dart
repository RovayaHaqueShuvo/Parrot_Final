import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/getX/_screenManagement.dart';
import 'package:parrot_messaging/screens/_chatboard-screen/_chatBarStyleGlobalUser.dart';
import 'package:parrot_messaging/screens/_chatboard-screen/_chatBarStyleLoggedUser.dart';

import '../_onBoarding-screen/_customWidget.dart' show ImageIconBorder;

class Chatboardscreen extends StatelessWidget {
  const Chatboardscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatsTextController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFF1D4321),
          leading: IconButton(
            onPressed: Get.back,
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImageIconBorder(
                size: 42,
                imageName: 'assets/parrot.png',
                onPressed: () {},
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Parrot",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Active",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              color: Colors.white,
              icon: Icon(Icons.call),
            ),
            IconButton(
              onPressed: () {},
              color: Colors.white,
              icon: Icon(Icons.videocam),
            ),
            IconButton(
              onPressed: (){
                print("button Cliked");
                Get.toNamed(Routes.userProfileScreen);
              },
              color: Colors.white,
              icon: Icon(Icons.info),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              // Expanded should be DIRECT child of Column
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        ChatBarStyleLogedUser(massage: "Hi, How are you?"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        ChatBarStyleGlobalUser(
                          massage: "I'm Fine, What about you?",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        ChatBarStyleLogedUser(massage: "Hi, How are you?"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        ChatBarStyleGlobalUser(
                          massage: "I'm Fine, What about you?",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        ChatBarStyleLogedUser(massage: "Hi, How are you?"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        ChatBarStyleGlobalUser(
                          massage: "I'm Fine, What about you?",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        ChatBarStyleLogedUser(massage: "Hi, How are you?"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        ChatBarStyleGlobalUser(
                          massage: "I'm Fine, What about you?",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        ChatBarStyleLogedUser(massage: "Hi, How are you?"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        ChatBarStyleGlobalUser(
                          massage: "I'm Fine, What about you?",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        ChatBarStyleLogedUser(massage: "Hi, How are you?"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        ChatBarStyleGlobalUser(
                          massage: "I'm Fine, What about you?",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        ChatBarStyleLogedUser(massage: "Hi, How are you?"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        ChatBarStyleGlobalUser(
                          massage: "I'm Fine, What about you?",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        ChatBarStyleLogedUser(massage: "Hi, How are you?"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        ChatBarStyleGlobalUser(
                          massage: "I'm Fine, What about you?",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        ChatBarStyleLogedUser(massage: "Hi, How are you?"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        ChatBarStyleGlobalUser(
                          massage: "I'm Fine, What about you?",
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),

        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(context).viewInsets.bottom, // Push above keyboard
          ),
          child: BottomAppBar(
            color: const Color(0xFF012B0D),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.attach_file_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      maxLines: 2,
                      cursorColor: Colors.white,
                      autofocus: false,
                      controller: chatsTextController,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white12,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.mic_none_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.send_outlined, color: Colors.blue),
                    onPressed: () {
                      print('Send Button Clicked');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
