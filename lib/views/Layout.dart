import 'package:flutter/material.dart';

import 'pages/HomePage.dart';
import 'pages/TablePage.dart';
import 'pages/ProfilePage.dart';

// model
import '../models/User.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  // index of selected page
  int _selectedIndex = 0;

  // user object
  User user = User(
      username: 'john_doe',
      name: 'John Doe',
      email: 'johndoe@example.com',
      imageUrl: 'https://avatars.githubusercontent.com/u/59855164?s=96&v=4');

  final List<String> _titles = const [
    'Home',
    'Table',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    // Define your pages here
    final List<Widget> pages = [
      const HomePage(),
      const TablePage(),
      ProfilePage(profileUser: user)
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: const Color.fromARGB(255, 126, 126, 126),
      body: pages[_selectedIndex],
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
