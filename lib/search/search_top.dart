import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dataBase/base_url.dart';
import '../parts/nav_bar.dart';
import '../parts/color.dart';


class SearchTop extends StatefulWidget {
  @override
  _SearchTopState createState() => _SearchTopState();
}

class _SearchTopState extends State<SearchTop> {

  List users;

  Future getData() async {
    var url = baseUrl + "usersList";
    var response = await http.get(Uri.parse(url));
    setState(() {
      users = json.decode(response.body);
    });
    // print(users);
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
                  onTap: null,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    decoration: design,
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: color2))
                          ),
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
                                        image: AssetImage('assets/image.png')
                                    ),
                                )
                            ),
                          ),
                        ),
                        Container(
                          width: 240,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceAround,
                            children: [
                              SizedBox(height: 1),
                              Text(users[index]['name'],
                                style: TextStyle(fontSize: 30),),
                              Text(users[index]['salon'],
                                style: TextStyle(fontSize: 20),)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container()
                  ],
                )),
                );
              }),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }


  BoxDecoration design = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      boxShadow: [BoxShadow(
        color: Colors.black26,
        spreadRadius: 5.0,
        blurRadius: 7.0,
        offset: Offset(0, 0),
      )
      ]
  );

}
