import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
            child: Text(
          'API CALL',
          style: TextStyle(color: Colors.black),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetch,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: ((context, index) {
          final user = users[index];
          final email = user['email'];
          final name = user['name']['first'];
          final imageurl = user['picture']['thumbnail'];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(imageurl), //Text('${index + 1}')
            ),
            title: Text(name),
          );
        }),
      ),
    );
  }

  void fetch() async {
    print("Fetch_it");
    const url = "https://randomuser.me/api/?results=100";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    //api will take the data in string format so now we HAVE TO CONVERT IT into json format
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
    print("Close_fetc_it");
  }
}
