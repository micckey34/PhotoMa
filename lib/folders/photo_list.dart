import 'package:app_photoma/folders/share_folder.dart';
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
  String folderName = widget.folderName;
    return Scaffold(
      appBar: AppBar(
        title: title,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: BackButton(
            color: color2
        ),
        actions: [
          ShareFolder(folderId: id,folderName: folderName,)
        ],
      ),
      body: Center(child: Text(widget.folderName)),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
