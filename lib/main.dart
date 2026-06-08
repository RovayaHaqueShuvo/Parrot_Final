import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/getX/_screenManagement.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase-Database/FirebaseDataBase.dart';
import 'firebase_options.dart';
import 'getX/theme-mode/theme_mode_getX.dart';

void main() async {
  // Flutter binding initialize
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialize
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // GetStorage initialize
  await GetStorage.init();
  Get.put(FirebaseDataBase(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    return GetMaterialApp(
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 250),
      debugShowCheckedModeBanner: false,
      title: 'Parrot',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeController.themeMode,
      initialRoute: Routes.splashScreen,
      getPages: RoutesPages.routes,
    );
  }
}
