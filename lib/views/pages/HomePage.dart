import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Box> _futureBox;

  @override
  void initState() {
    super.initState();
    _futureBox = Hive.openBox('favorites');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Box>(
        future: _futureBox,
        builder: (BuildContext context, AsyncSnapshot<Box> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(
                  child: Text("Error occurred while opening the box"));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.getAt(index);
                  return ListTile(
                    title: Text(
                      jsonDecode(data)['title'].toString(),
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    // icon
                    subtitle: Text(
                      jsonDecode(data)['duration'].toString(),
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(jsonDecode(data)['images']
                              ['jpg']['image_url']
                          .toString()),
                    ),
                    onLongPress: () {
                      // show snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Long Pressed'),
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () {
                        // show snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Favorited'),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
