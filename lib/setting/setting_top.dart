import 'package:app_photoma/parts/nav_bar.dart';
import 'package:app_photoma/parts/color.dart';
import 'package:app_photoma/setting/sign_in.dart';
import 'package:flutter/material.dart';

class SettingTop extends StatefulWidget {
  @override
  _SettingTopState createState() => _SettingTopState();
}

class _SettingTopState extends State<SettingTop> {
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
        body: Container(
          color: color1,
          child: Center(
            child: ElevatedButton(
              child: Text('ログアウト'),
              onPressed: (){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn()));
              },
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
