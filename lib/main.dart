import 'package:flutter/material.dart';
import 'package:pink_app/welcome.dart';
import 'homepage.dart';
import 'circletracker.dart';
import 'bmipage.dart';
import 'reminderpage.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const WelcomeScreen(),
      routes: {
        '/home': (context) => Homepage(),
        '/circle': (context) => CycleTracker(),
        '/bmi': (context) => Bmipage(),
        '/rem': (context) => ReminderPage(),
      },
      title: 'Pink Pal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
    );
  }
}
