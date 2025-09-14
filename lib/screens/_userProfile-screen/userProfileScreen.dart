import 'package:flutter/material.dart';
import 'package:parrot_messaging/screens/_onBoarding-screen/_customWidget.dart';

class Userprofilescreen extends StatelessWidget {
  const Userprofilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              ImageIconBorder(imageName: 'assets/parrot.png', size: 80,),
              Text("Parrot", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blueAccent),)
            ],
          ),
        ),
      ),
    );
  }
}
