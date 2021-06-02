import 'package:app_photoma/parts/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../parts/nav_bar.dart';
import '../../dataBase/base_url.dart';

class PhotoPage extends StatefulWidget {
  int id;

  PhotoPage({this.id});

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  int imageId;
  Map image;
  List memo;

  Future getData() async {
    var url = baseUrl + 'photoPage/' + imageId.toString();
    var response = await http.get(Uri.parse(url));
    setState(() {
      image = json.decode(response.body);
    });
  }

  Future getMemo() async {
    var url = baseUrl + 'getMemo/' + imageId.toString();
    var response = await http.get(Uri.parse(url));
    setState(() {
      memo = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    imageId = widget.id;
    getData();
    getMemo();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: BackButton(color: color2),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  (image != null)
                      ? Image.network(image['image_path'])
                      : Container(),
                  Text(
                    'MEMO',
                    style: GoogleFonts.getFont('Concert One', fontSize: 30),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 30, right: 30, top: 20, bottom: 10),
                    height: 300,
                    child: Center(
                      child: ListView.builder(
                        itemCount: memo == null ? 0 : memo.length,
                        itemBuilder: (context, index) {
                          return Container(
                              child: Text(
                            memo[index]['posts'],
                            style: TextStyle(fontSize: 20),
                          ));
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
