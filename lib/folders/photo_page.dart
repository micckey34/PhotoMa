import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../parts/nav_bar.dart';
import '../dataBase/base_url.dart';
import '../parts/color.dart';
import '../folders/memo.dart';

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
    // print(response.body);
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
      body:
      Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  (image != null) ? Image.network(image['image_path']) : Container(),
                  Text('MEMO',style: TextStyle(fontSize: 40),),
                  Container(
                    color: Colors.black12,
                    height: 300,
                    child: Center(
                      child:  ListView.builder(
                        itemCount: memo == null ? 0 : memo.length,
                        itemBuilder: (context, index) {
                          return Container(
                                    child:Text(memo[index]['posts'])
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SingleChildScrollView(
              child:Container(
                height: 50,
                color: color1,
                child: MemoCreate(imageId: imageId,)
              )
          )
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
