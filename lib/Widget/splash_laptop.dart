import 'dart:async';
import 'package:flutter/material.dart';

class SplashLaptop extends StatefulWidget {
  const SplashLaptop({super.key});

  @override
  State<SplashLaptop> createState() => _SplashLaptopState();
}

class _SplashLaptopState extends State<SplashLaptop> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/splash.jpg', width: 200, height: 200),
            const SizedBox(height: 20),
            const Text(
              'Welcome to My Laptop',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 19, 58, 89),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
