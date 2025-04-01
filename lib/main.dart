import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart'; // Ensure this import points to your welcome screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(), // Set the initial screen to WelcomeScreen
    );
  }
}
