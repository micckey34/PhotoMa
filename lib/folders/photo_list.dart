import 'package:flutter/material.dart';

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
      body: Center(child: Text(id.toString()))
    );
  }
}
