import 'dart:async';
import 'package:flutter/material.dart';

import '../custom_orientation_player/custom_orientation_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to the next screen after a delay
    Timer(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => const CustomOrientationPlayer()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your splash screen logo or image here
            Image.asset(
              'assets/images/logo.png', // Replace with your image path
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 16),
            const CircularProgressIndicator(), // Add any desired loading indicator
          ],
        ),
      ),
    );
  }
}
