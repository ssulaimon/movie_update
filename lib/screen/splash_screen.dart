import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> pushToHomeScreen() async {
    return Future.delayed(
      const Duration(seconds: 2),
      () => Navigator.popAndPushNamed(
        context,
        'homeScreen',
      ),
    );
  }

  @override
  void initState() {
    pushToHomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'MY WAY IS MOVIE',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
