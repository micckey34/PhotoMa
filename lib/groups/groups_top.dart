import 'dart:convert';

import 'package:app_photoma/groups/create_join.dart';
import 'package:app_photoma/parts/db.dart';
import 'package:app_photoma/parts/nav_bar.dart';
import 'package:app_photoma/parts/color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GroupsTop extends StatefulWidget {
  @override
  _GroupsTopState createState() => _GroupsTopState();
}

class _GroupsTopState extends State<GroupsTop> {
  List groups;

  Future getData() async {
    var id = user['id'].toString();
    var url = baseUrl + 'groupList/' + id;
    var response = await http.get(Uri.parse(url));
    setState(() {
      groups = json.decode(response.body);
      // print(groups);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: color1,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: title,
          centerTitle: true,
          actions: [CreateGroup()],
        ),
        body: Center(
          child: ListView.builder(
              itemCount: groups == null ? 0 : groups.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white)),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.group, color: color2,size: 30,),
                    title: Text('${groups[index]['group_name']}',
                        style: TextStyle(fontSize: 25, color: color2)),
                    trailing:
                        Icon(Icons.arrow_forward_ios_outlined, color: color2),
                    contentPadding: EdgeInsets.all(5.0),
                    onTap: () {},
                  ),
                );
              }),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
