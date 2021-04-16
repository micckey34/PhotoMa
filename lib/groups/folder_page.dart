import 'package:flutter/material.dart';
import '../parts/nav_bar.dart';
import '../parts/color.dart';

class FolderPage extends StatefulWidget {

  final int id;
  FolderPage({this.id});
  @override
  _FolderPageState createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
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
