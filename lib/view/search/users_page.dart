import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../parts/nav_bar.dart';
import '../../parts/color.dart';
import '../../dataBase/base_url.dart';
import 'folder_page.dart';

class UsersPage extends StatefulWidget {
  final int userId;

  UsersPage({this.userId});

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  Map data;
  List folderData;

  Future getData() async {
    final int userId = widget.userId;
    var url = baseUrl + 'userData/' + userId.toString();
    var response = await http.get(Uri.parse(url));
    setState(() {
      data = json.decode(response.body);
    });
  }

  Future folder() async {
    final int userId = widget.userId;
    var url = baseUrl + 'folderData/' + userId.toString();
    var response = await http.get(Uri.parse(url));
    setState(() {
      folderData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    folder();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(color: color2),
        title: title,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              image: data != null &&
                                      data['profile_image_path'] != null
                                  ? NetworkImage(data['profile_image_path'])
                                  : AssetImage('assets/image.png')),
                        )),
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(20),
                  width: 220,
                  height: 100,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          data == null ? '' : data['name'],
                          style: TextStyle(fontSize: 25),
                        ),
                        Divider(
                          color: color2,
                          thickness: 2,
                        ),
                        Text(data == null ? '' : data['salon'],
                            style: TextStyle(fontSize: 23))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: color1,
              child: Center(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: folderData == null ? 0 : folderData.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FolderPage(
                                      id: folderData[index]['id'],
                                    )),
                          );
                        },
                        child: Center(
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 1.0,
                                blurRadius: 7.0,
                                offset: Offset(0, 0),
                              )]
                            ),
                            child: Center(
                              child: Text(folderData[index]['folder_name'],
                                style: GoogleFonts.getFont('Kosugi Maru',fontSize: 10),textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
