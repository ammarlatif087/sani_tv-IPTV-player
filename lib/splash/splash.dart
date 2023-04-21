import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

import '../custom_orientation_player/custom_orientation_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isConnected = true;
      });
    } else {
      setState(() {
        isConnected = false;
      });
    }

    Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        setState(() {
          isConnected = true;
        });
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const CustomOrientationPlayer()),
            (route) => false,
          );
        });
      }
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
            isConnected
                ? const CircularProgressIndicator() // Add any desired loading indicator
                : const Text('No internet connection'),
          ],
        ),
      ),
    );
  }
}
