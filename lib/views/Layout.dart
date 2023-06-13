import 'package:flutter/material.dart';

import 'pages/HomePage.dart';
import 'pages/TablePage.dart';
import 'pages/ProfilePage.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  // index of selected page
  int _selectedIndex = 0;

  // array of pages
  final List<Widget> _pages = const [
    HomePage(),
    TablePage(),
    ProfilePage(),
  ];

  final List<String> _titles = const [
    'Home',
    'Table',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.black,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurple,
        // selectedItemColor: Colors.2B3F70
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.white.withOpacity(.60),
        currentIndex: _selectedIndex,
        onTap: (int index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_chart),
            label: 'Table',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
