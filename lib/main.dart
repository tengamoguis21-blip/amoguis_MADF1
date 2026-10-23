import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const StudentApp());
}

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Registration App',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
