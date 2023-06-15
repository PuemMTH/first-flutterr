import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

// pages
import 'TablePage/UniqueTable.dart';

class TablePage extends StatefulWidget {
  const TablePage({Key? key}) : super(key: key);

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  List<dynamic> animeList = [];
  int currentPage = 1;
  bool isLoading = false;

  Future<void> getAnime(int page) async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse('https://api.jikan.moe/v4/anime?page=$page');
    var response = await RetryClient(http.Client()).get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        animeList.addAll(jsonResponse['data']);
        currentPage++;
        isLoading = false;
      });
    } else {
      print('Failed to load anime: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    getAnime(currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!isLoading &&
            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          getAnime(currentPage);
          return true;
        }
        return false;
      },
      child: ListView.builder(
        itemCount: animeList.length +
            (isLoading ? 1 : 0), // add extra item when loading data
        itemBuilder: (context, index) {
          if (isLoading && index == animeList.length) {
            // show loading indicator at the end
            return const Center(child: CircularProgressIndicator());
          } else {
            var anime = animeList[index];
            return ListTile(
                title: Text(
                  anime['title'].toString(),
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                // icon
                subtitle: Text(
                  anime['duration'].toString(),
                  style: const TextStyle(fontSize: 16.0),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      anime['images']['jpg']['image_url'].toString()),
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
                onTap: () {
                  // navigate to the detail page
                  animeList[index];
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UniqueTable(anime: anime),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
