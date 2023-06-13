import 'package:flutter/material.dart';
import '../../models/User.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required this.profileUser});
  final User profileUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(profileUser.imageUrl),
            radius: 50.0,
          ),
          const SizedBox(
              height: 20.0), // Add a space between the image and the text
          Text(
            'Username: ${profileUser.username}',
            style: const TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          const SizedBox(height: 10.0), // Add some space
          Text(
            'Name: ${profileUser.name}',
            style: const TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          const SizedBox(height: 10.0), // Add some space
          Text(
            'Email: ${profileUser.email}',
            style: const TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}
