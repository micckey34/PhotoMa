import 'package:flutter/material.dart';
import '../parts/nav_bar.dart';
import '../parts/color.dart';

class PhotoList extends StatefulWidget {

  final int id;
  final String folderName;
  PhotoList({this.id,this.folderName});
  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  @override
  Widget build(BuildContext context) {
  int id = widget.id;
    return Scaffold(
      appBar: AppBar(
        title: title,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: BackButton(
            color: color2
        ),
      ),
      body: Center(child: Text(id.toString())),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
