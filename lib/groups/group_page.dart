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
                        EdgeInsets.only(left: 10, right: 20, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                height: 60,
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
          width: 300,
          height: 60,
          padding: EdgeInsets.only(left: 20,right: 20),
          decoration: BoxDecoration(
            color: color3,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 1.0,
                blurRadius: 10.0,
                offset: Offset(0,0)
              )
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.folder,color: Colors.white,size: 40,),
              Text(text,style: TextStyle(color: Colors.white,fontSize: 18),),
              Icon(Icons.arrow_forward_ios_outlined,color: color2,)
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
      return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 300,
          maxWidth: 300,
          minHeight: 50
        ),
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 1.0,
                blurRadius: 10.0,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: Center(child:Text(text)),
        ),
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
                  Text('グループID',style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(id['unique_id'],style: TextStyle(fontSize: 22,)),
                  // SizedBox(height: 10,),
                  ElevatedButton(
                      child: Text('コピー'),
                    style: ElevatedButton.styleFrom(
                      primary: color3,),
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
