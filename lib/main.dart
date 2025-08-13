import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/getX/_screenManagement.dart';
import 'package:parrot_messaging/screens/_splash-screen/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Parrot',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: Routes.splashScreen,
      getPages: RoutesPages.routes,
    );
  }
}

