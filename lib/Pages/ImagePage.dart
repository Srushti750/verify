// ignore_for_file: prefer_const_declarations, no_leading_underscores_for_local_identifiers, unused_element, avoid_print, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;

class ImagePage extends StatefulWidget {
  const ImagePage({Key? key}) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  final TextEditingController _imagecontroller = TextEditingController();

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
                  controller: _imagecontroller,
                  decoration: InputDecoration(
                    hintText: "Enter the url",
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                FloatingActionButton.extended(
                  onPressed: () {
                    final authority =
                        "generativeai-image-detection.p.rapidapi.com";
                    final path = "/";
                    final Map<String, String> _headers = {
                      "x-rapidapi-key":
                          "bcd99fee70msh7b1dcbe0fb28073p1e61aajsn45eb840e065f",
                      "x-rapidapi-host":
                          "generativeai-image-detection.p.rapidapi.com",
                    };
                    Future<Mydata> getImage() async {
                      Uri uri = Uri.https(authority, path);
                      final response = await http.get(uri, headers: _headers);
                      print("object");
                      if (response.statusCode == HttpStatus.ok) {
                        final jsonMap = json.decode(response.body);
                        print(jsonMap);
                        print("Success");

                        return Mydata.fromJson(jsonMap);
                      } else {
                        print("Fail");
                        throw Exception(
                            'Api call retured : ${response.statusCode} ${response.reasonPhrase}');
                      }
                    }
                  },
                  label: const Text("Verify"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ApiservicePage {}

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
