import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dataBase/base_url.dart';
import '../parts/nav_bar.dart';
import '../parts/color.dart';
import '../search/photo_page.dart';

class PhotoList extends StatefulWidget {

  final int id;
  PhotoList({this.id});
  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  int folderId;
  List photoList;

  Future getData() async {
    var url = baseUrl + 'photoList/' + folderId.toString();
    var response = await http.get(Uri.parse(url));
    setState(() {
      photoList = json.decode(response.body);
    });
  }
  @override
  void initState() {
    super.initState();
    folderId = widget.id;
    getData();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      appBar: AppBar(
        title: title,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: BackButton(color: color2),
      ),
      body: Column(
        children: [
          Expanded(
              child: Center(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,),
                      itemCount: photoList == null ? 0 : photoList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Center(
                          child:GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PhotoPage(id: photoList[index]['id'],)),
                                );
                              },
                              child: Container(
                                // width: 150,
                                // height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Image.network(photoList[index]['image_path']),
                                ),
                              )
                          ),
                        );
                      })
              )
          )
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
