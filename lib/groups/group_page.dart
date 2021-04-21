import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dataBase/base_url.dart';
import '../parts/nav_bar.dart';
import '../parts/color.dart';
import '../groups/post_create.dart';
import 'package:flutter/services.dart';
import '../groups/folder_page.dart';

class GroupPage extends StatefulWidget {
  final int id;

  GroupPage({this.id});

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  var groupId;

  List posts;

  Future getData() async {
    var url = baseUrl + 'groupPage/' + groupId.toString();
    var response = await http.get(Uri.parse(url));
    setState(() {
      posts = json.decode(response.body);
    });
  }

  void initState() {
    super.initState();
    this.groupId = widget.id;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: BackButton(color: color2),
        actions: [idBtn()],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ListView.builder(
                itemCount: posts == null ? 0 : posts.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    child: Row(
                      children: [
                        Container(
                          child: Column(children: [
                            Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: posts[index]
                                                  ['profile_image_path'] ==
                                              null
                                          ? AssetImage('assets/image.png')
                                          : NetworkImage(posts[index]
                                              ['profile_image_path'])),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: 2.0,
                                      blurRadius: 10.0,
                                      offset: Offset(0, 0),
                                    )
                                  ],
                                )),
                            Text(posts[index]['name'])
                          ]),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        postBox(
                            posts[index]['posts'], posts[index]['folder_id'])
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
                // color: Colors.black12,
                height: 50,
                width: double.infinity,
                child: PostCreate(groupId: groupId)),
          )
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget postBox(text, folder) {
    if (folder != null) {
      return GestureDetector(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          width: 300,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 2.0,
                blurRadius: 10.0,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: color3,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(child: Text(text)),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FolderPage(id: folder)),
          );
        },
      );
    } else {
      return Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 2.0,
              blurRadius: 10.0,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: Center(child: Text(text)),
      );
    }
  }

  idBtn() {
    return IconButton(icon: Icon(Icons.message,color: color2,), onPressed: idDialog);
  }

  idDialog() async {
    var url = baseUrl + 'uniqueId/' + groupId.toString();
    var response = await http.get(Uri.parse(url));
    Map id = json.decode(response.body);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              width: 200,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('グループID'),
                  Text(id['unique_id'],style: TextStyle(fontSize: 20,)),
                  // SizedBox(height: 10,),
                  ElevatedButton(
                      child: Text('コピー'),
                    onPressed: () async {
                    final data = ClipboardData(text: id['unique_id']);
                    await Clipboard.setData(data);
                  },
                  )
                ],
              ),
            ),
          );
        });
  }
}
