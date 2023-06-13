import 'package:flutter/material.dart';
import 'views/App.dart';
import 'views/HomePage.dart';
import 'views/Welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Table',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Welcome(),
      routes: {
        '/home': (context) => const HomePage(),
        '/table': (context) => const TablePage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
