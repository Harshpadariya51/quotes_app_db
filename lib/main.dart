import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quotes_app_db/views/home/homepage.dart';
import 'package:quotes_app_db/views/splash/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/Splash',
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => Homepage()),
        GetPage(name: '/Splash', page: () => const SplashScreen()),
      ],
    );
  }
}
