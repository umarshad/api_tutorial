import 'dart:convert';
import 'package:api_tutorial/Model/complex_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api_tutorial/home_screen.dart';
import 'package:api_tutorial/photos_screen.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<UsersList> usersList = [];

  Future<List<UsersList>> getUsersApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      usersList.clear();
      for (Map i in data) {
        usersList.add(UsersList.fromJson(i as Map<String, dynamic>));
      }
      return usersList;
    } else {
      return usersList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          'Users API',
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
            icon: const Icon(Icons.photo),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PhotosScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUsersApi(),
              builder: (context, AsyncSnapshot<List<UsersList>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: usersList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                ReusableRow(
                                  title: 'Id: ',
                                  value: usersList[index].id.toString(),
                                ),
                                ReusableRow(
                                  title: 'Name: ',
                                  value: usersList[index].name.toString(),
                                ),
                                ReusableRow(
                                  title: 'Username: ',
                                  value: usersList[index].username.toString(),
                                ),
                                ReusableRow(
                                  title: 'Email: ',
                                  value: usersList[index].email.toString(),
                                ),
                                ReusableRow(
                                  title: 'Phone: ',
                                  value: usersList[index].phone.toString(),
                                ),
                                ReusableRow(
                                  title: 'Website: ',
                                  value: usersList[index].website.toString(),
                                ),
                                ReusableRow(
                                  title: 'City: ',
                                  value:
                                      usersList[index].address!.city.toString(),
                                ),
                                ReusableRow(
                                  title: 'Street: ',
                                  value: usersList[index]
                                      .address!
                                      .street
                                      .toString(),
                                ),
                                ReusableRow(
                                  title: 'Suite: ',
                                  value: usersList[index]
                                      .address!
                                      .suite
                                      .toString(),
                                ),
                                ReusableRow(
                                  title: 'Company: ',
                                  value:
                                      usersList[index].company!.name.toString(),
                                ),
                                ReusableRow(
                                  title: 'Catch Phrase: ',
                                  value: usersList[index]
                                      .company!
                                      .catchPhrase
                                      .toString(),
                                ),
                                ReusableRow(
                                  title: 'BS: ',
                                  value:
                                      usersList[index].company!.bs.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
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

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Flexible(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis, // Prevents overflow
            ),
          ),
        ],
      ),
    );
  }
}
