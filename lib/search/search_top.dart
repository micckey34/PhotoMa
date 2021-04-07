import 'package:app_photoma/parts/nav_bar.dart';
import 'package:app_photoma/parts/color.dart';
import 'package:flutter/material.dart';

class SearchTop extends StatefulWidget {
  @override
  _SearchTopState createState() => _SearchTopState();
}

class _SearchTopState extends State<SearchTop> {
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
          actions: [],
        ),
        body: Container(color: color1),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
