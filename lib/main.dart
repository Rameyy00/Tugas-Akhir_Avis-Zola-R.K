import 'package:flutter/material.dart';
import 'package:project_1/Widget/splash_laptop.dart';
import 'package:project_1/views/navbar_laptop.dart';
import 'package:project_1/views/profile_laptop.dart';
import 'package:project_1/views/trend_laptop.dart';
import 'package:project_1/views/laptop_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laptop App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 183, 24, 24)),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/': (context) => const MainWrapper(),
        '/splash': (context) => const SplashLaptop(), 
        '/profile': (context) => const AkunLaptop(),
        '/trend': (context) => const TrendLaptop(),
      },
    );
  }
}