import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Table Management System',
              style: TextStyle(fontSize: 32.0, color: Colors.white),
            ),
            const SizedBox(height: 16.0),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              iconSize: 16.0,
              color: Colors.white,
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  const CircleBorder(),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/layout');
              },
            ),
          ],
        ),
      ),
    );
  }
}
