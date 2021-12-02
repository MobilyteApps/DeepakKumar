import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Album>?> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('https://reqres.in/api/users?page=1'));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final alblumList = jsonResponse['data'] as List;
    return alblumList.map((data) => Album.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load the data');
  }
}

class Album {
  final int id;

  final String email;
  final String first_name;
  final String last_name;
  final String avtar;

  Album({
    required this.id,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.avtar,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      avtar: json['avatar'],
    );
  }
}

class Apidata extends StatefulWidget {
  @override
  _ApidataState createState() => _ApidataState();
}

class _ApidataState extends State<Apidata> {
  late Future<List<Album>?> futureAblum;

  @override
  void initState() {
    super.initState();
    futureAblum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Api data fetch',
      home: Scaffold(
          appBar: AppBar(
            title: Text("Api lxjflddata"),
          ),
          body: FutureBuilder<List<Album>?>(
              future: futureAblum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Album>? data = snapshot.data;
                  return ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Container(
                                  child: Image.network(
                                      data[index].avtar.toString()),
                                ),
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 1),
                                        child: Text("id =" +
                                            "  " +
                                            data[index].id.toString()),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                          "Email =" + "  " + data[index].email),
                                    ),
                                    Container(
                                      child: Text("First name =" +
                                          "  " +
                                          data[index].first_name),
                                    ),
                                    Container(
                                      child: Text("Last name =" +
                                          "  " +
                                          data[index].last_name),
                                    ),
                                  ]),
                            ]);
                      });
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Center(child: CircularProgressIndicator());
              })),
    );
  }
}
