import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../parts/nav_bar.dart';
import '../parts/color.dart';
import '../dataBase/base_url.dart';

class UsersPage extends StatefulWidget {
  final int userId;

  UsersPage({this.userId});

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  Map data;

  Future getData() async {
    final int userId = widget.userId;
    var url = baseUrl + 'userData/' + userId.toString();
    var response = await http.get(Uri.parse(url));
    setState(() {
      data = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
            color: color2
        ),
        title: title,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20,right: 20),
            height: 200,
            color: Colors.deepPurpleAccent,
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: Center(
                    child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: data['profile_image_path'] == null
                                  ? AssetImage('assets/image.png')
                                  : NetworkImage(data['profile_image_path'])),
                        )),
                  ),
                ),
                Container(
                  width: 200,
                  child: Column(
                    children: [
                      Text(data['name']),
                      Text(data['salon'])
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container()
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
