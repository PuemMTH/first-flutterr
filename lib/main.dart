import 'package:flutter/material.dart';
import 'views/Welcome.dart';

// Layout
import 'views/Layout.dart';
import 'views/pages/TablePage/UniqueTable.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('favorites');
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
        '/layout': (context) => const Layout(),
        // '/uniqueTable': (context) => const UniqueTable(),
      },
    );
  }
}
