import 'dart:convert';
import 'package:app_photoma/folders/photo_list.dart';
import 'package:app_photoma/parts/db.dart';
import 'package:app_photoma/parts/nav_bar.dart';
import 'package:app_photoma/parts/color.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'add_folder.dart';

class FolderTop extends StatefulWidget {
  @override
  _FolderTopState createState() => _FolderTopState();
}

class _FolderTopState extends State<FolderTop> {

  List folders;

  Future getData() async{
    var id = user['id'].toString();
    var url = baseUrl+'folderList/'+id;
    var response = await http.get(Uri.parse(url));
    setState(() {
    folders = json.decode(response.body);
    });
    // print(folders);
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: title,
          centerTitle: true,
          actions: [AddFolder()],
        ),
        body: Container(
          child: Center(
            child:GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,),
                itemCount:folders == null ? 0: folders.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Center(
                    child:GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              PhotoList(id: folders[index]['id'],
                                folderName: folders[index]['folder_name'],)
                          ),
                        );
                      },
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 2.0,
                            blurRadius: 7.0,
                            offset: Offset(5, 5),
                          )],
                        ),
                        child: Center(
                          child: Text(folders[index]['folder_name'],
                            style: TextStyle(fontSize: 25,color: color2),
                          ),
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),
          // color: color1,
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}


