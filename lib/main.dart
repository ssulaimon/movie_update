import 'package:flutter/material.dart';
import 'package:movie_update/screen/home_screen.dart';
import 'package:movie_update/screen/splash_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: "splashScreen",
      routes: {
        'splashScreen': (
          context,
        ) =>
            const SplashScreen(),
        'homeScreen': (
          context,
        ) =>
            const HomeScreen()
      },
    ),
  );
}
