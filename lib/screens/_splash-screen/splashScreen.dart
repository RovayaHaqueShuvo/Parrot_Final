import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../getX/_screenManagement.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void didChangeDependencies() {
    Future.delayed(const Duration(seconds: 3), () {
     Get.offAllNamed(Routes.onBoardingScreen);
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset("assets/parrot_1.png",
            height: MediaQuery.of(context).size.height*.2,
            fit: BoxFit.cover,),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*.05,),
          Text("Parrot", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),),
          Text("Make Better Decisions", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: "italic"),)
          ]
      ),
    ));
  }
}
