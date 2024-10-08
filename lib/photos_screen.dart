import 'dart:convert';
import 'package:api_tutorial/Model/photos_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api_tutorial/home_screen.dart';
import 'package:api_tutorial/complex_screen.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({super.key});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotosApi() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        photosList.add(Photos.fromJson(i as Map<String, dynamic>));
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          'Photos API',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.people),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyWidget()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotosApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: Text('Loading'));
                } else {
                  return ListView.builder(
                    itemCount: photosList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              photosList[index].thumbnailUrl ?? ''),
                        ),
                        title: Text(photosList[index].title.toString()),
                        subtitle: Image(
                            image:
                                NetworkImage(photosList[index].url.toString())),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
