import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dataBase/base_url.dart';
import '../parts/nav_bar.dart';
import '../parts/color.dart';
import '../search/users_page.dart';

class SearchTop extends StatefulWidget {
  @override
  _SearchTopState createState() => _SearchTopState();
}

class _SearchTopState extends State<SearchTop> {
  List data;
  List users;

  Future getData() async {
    final int myId =  await user();
    var url = baseUrl + "usersList";
    var response = await http.get(Uri.parse(url));
    setState(() {
      data = json.decode(response.body);
      users = data.where((user)=>user['id'] != myId).toList();
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
          actions: [],
        ),
        body: Center(
          child: ListView.builder(
              itemCount: users == null ? 0 : users.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UsersPage(
                                userId: users[index]['id'],
                              )),
                    );
                  },
                  child: Container(
                      height: 200,
                      width: double.infinity,
                      margin: EdgeInsets.only(top:10,bottom:10,left: 20,right: 20),
                      decoration: design,
                      child: Column(
                        children: [
                          Container(
                            height: 90,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border:
                                    Border(bottom: BorderSide(color: color2))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 120,
                                  child: Center(
                                    child: Container(
                                        height: 65,
                                        width: 65,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: users != null && users[index]['profile_image_path'] != null ?
                                              NetworkImage(users[index]['profile_image_path'])
                                                  : AssetImage('assets/image.png')
                                          ),
                                        )
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 220,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(height: 1),
                                      Text(
                                        users[index]['name'],
                                        style: GoogleFonts.getFont('Kosugi Maru',fontSize: 28),
                                      ),
                                      Text(
                                        users[index]['salon'],
                                        style: GoogleFonts.getFont('Kosugi Maru',fontSize: 17),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            child: (users[index]['folders'].length != 0) ?
                            Container(
                                height: 90,
                                width: double.infinity,
                                padding: EdgeInsets.only(top: 10,right: 20,left: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: (users[index]['folders'].length > 0)
                                        ? folder(users[index]['folders'][0]
                                    ['folder_name']):null
                                ),
                                SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: (users[index]['folders'].length > 1)
                                        ? folder(users[index]['folders'][1]
                                    ['folder_name']):null
                                ),
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: (users[index]['folders'].length > 2)
                                      ? folder(users[index]['folders'][2]
                                  ['folder_name']):null
                                )
                              ],
                            )
                            ):Container()
                          )
                        ],
                      )),
                );
              }),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
  Widget folder(name) {
    return
      Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:color1,
        ),
        child: Center(
          child: Text(name,style: TextStyle(fontSize: 12),),
        ),
      );
  }

  BoxDecoration design = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          spreadRadius: 5.0,
          blurRadius: 7.0,
          offset: Offset(0, 0),
        )
      ]);
}
