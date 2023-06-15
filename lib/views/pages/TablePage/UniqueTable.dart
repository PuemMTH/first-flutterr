import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UniqueTable extends StatefulWidget {
  const UniqueTable({Key? key, required this.anime}) : super(key: key);
  final dynamic anime;

  @override
  State<UniqueTable> createState() => _UniqueTableState();
}

class _UniqueTableState extends State<UniqueTable> {
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
            // Error occurred, report an error to the user
            return Center(child: Text("Error occurred while opening the box"));
          } else {
            // Box opened successfully
            var box = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.anime['title'].toString()),
              ),
              body: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 12,
                ),
                child: ListView(
                  children: [
                    Image(
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(widget.anime['images']['jpg']
                              ['image_url']
                          .toString()),
                    ),
                    buildListTile(
                        'Synopsis', widget.anime['synopsis'].toString()),
                    buildListTile(
                        'Duration', widget.anime['duration'].toString()),
                    buildListTile('Score', widget.anime['score'].toString()),
                    buildListTile('Rank', widget.anime['rank'].toString()),
                    buildListTile(
                        'Popularity', widget.anime['popularity'].toString()),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    if (box.containsKey(widget.anime['mal_id'])) {
                      box.delete(widget.anime['mal_id']);
                    } else {
                      box.put(widget.anime['mal_id'], jsonEncode(widget.anime));
                    }
                  });
                },
                child: box!.containsKey(widget.anime['mal_id'])
                    ? const Icon(Icons.star)
                    : const Icon(Icons.star_border),
              ),
            );
          }
        } else {
          // Still loading, return a loading indicator
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  ListTile buildListTile(String title, String value) {
    return ListTile(
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold)),
      subtitle: Text(value, style: Theme.of(context).textTheme.titleSmall),
    );
  }

  @override
  void dispose() {
    Hive.box('favorites').close();
    super.dispose();
  }
}
