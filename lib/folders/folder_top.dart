import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dataBase/base_url.dart';
import '../parts/nav_bar.dart';
import '../parts/color.dart';
import '../folders/photo_list.dart';
import 'add_folder.dart';

class FolderTop extends StatefulWidget {
  @override
  _FolderTopState createState() => _FolderTopState();
}

class _FolderTopState extends State<FolderTop> {
  List folders;

  Future getData() async {
    final int myId = await user();
    var url = baseUrl + 'folderList/' + myId.toString();
    var response = await http.get(Uri.parse(url));
    setState(() {
      folders = json.decode(response.body);
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: title,
          centerTitle: true,
          actions: [AddFolder()],
        ),
        body: Container(
          child: Center(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: folders == null ? 0 : folders.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => PhotoList(
                                    id: folders[index]['id'],
                                    folderName: folders[index]['folder_name'],
                                  )),
                        );
                      },
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 2.0,
                              blurRadius: 7.0,
                              offset: Offset(5, 5),
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            folders[index]['folder_name'],
                            style: TextStyle(fontSize: 20, color: color2),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          // color: color1,
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
