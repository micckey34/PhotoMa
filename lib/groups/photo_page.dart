import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../parts/nav_bar.dart';
import '../dataBase/base_url.dart';

class PhotoPage extends StatefulWidget {
  int id;
  PhotoPage({this.id});
  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  int imageId;
  Map image;
  Future getData() async {
    var url = baseUrl + 'photoPage/' + imageId.toString();
    var response = await http.get(Uri.parse(url));
    // print(response.body);
    setState(() {
      image = json.decode(response.body);
    });
  }
  @override
  void initState() {
    super.initState();
    imageId = widget.id;
    getData();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Container(
          child: Center(
            child: (image != null) ? Image.network(image['image_path']):Container(),
          ),
        ),
        Container(),
      ]),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
