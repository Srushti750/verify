// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:verifyapp/Pages/ImagePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textcontroller = TextEditingController();
  final badwords = ProfanityFilter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo"),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.80,
          height: MediaQuery.of(context).size.height * 0.35,
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  controller: _textcontroller,
                  decoration: InputDecoration(
                    hintText: "Enter the String",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                FloatingActionButton.extended(
                  onPressed: () {
                    if (_textcontroller.text.isNotEmpty) {
                      bool verify = badwords.hasProfanity(_textcontroller.text);
                      print(verify);

                      if (verify == true) {
                        final snackbar = SnackBar(
                          content: Text("You can't use the profanity !"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      } else {
                        final snackbar = SnackBar(
                          content: Text("Text Accepted"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    } else {
                      print("Enter the string");
                      final snackbar = SnackBar(
                        content: Text("Please enter the string"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                  },
                  label: Text("Enter"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImagePage(),
                      ),
                    );
                  },
                  child: Icon(Icons.forward),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Aiservice {
  static const authority = "generativeai-image-detection.p.rapidapi.com";
  static const path = "/";
  static const Map<String, String> _headers = {
    "x-rapidapi-key": "bcd99fee70msh7b1dcbe0fb28073p1e61aajsn45eb840e065f",
    "x-rapidapi-host": "generativeai-image-detection.p.rapidapi.com",
  };
  Future<Mydata> get() async {
    Uri uri = Uri.https(authority, path);
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode == HttpStatus.ok) {
      final jsonMap = json.decode(response.body);
      return Mydata.fromJson(jsonMap);
    } else {
      throw Exception(
          'Api call retured : ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}

class Mydata {
  final String img;
  const Mydata({
    this.img = '',
  });
  factory Mydata.fromJson(Map<String, dynamic> json) => _$MydataFromJson(json);
}

Mydata _$MydataFromJson(Map<String, dynamic> json) => Mydata(
      img: json['img'] as String? ?? '',
    );
