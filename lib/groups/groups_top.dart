import 'package:app_photoma/groups/create_join.dart';
import 'package:app_photoma/parts/nav_bar.dart';
import 'package:app_photoma/parts/color.dart';
import 'package:flutter/material.dart';

class GroupsTop extends StatefulWidget {
  @override
  _GroupsTopState createState() => _GroupsTopState();
}

class _GroupsTopState extends State<GroupsTop> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: title,
          centerTitle: true,
          actions: [CreateGroup()],
        ),
        body: Container(color: color1),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
