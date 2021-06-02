import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dataBase/base_url.dart';
import '../parts/nav_bar.dart';
import '../parts/color.dart';
import '../folders/delete_folder.dart';
import '../folders/photo_page.dart';
import '../folders/share_folder.dart';
import '../folders/file_upload.dart';

class PhotoList extends StatefulWidget {
  final int id;
  final String folderName;

  PhotoList({this.id, this.folderName});

  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  var folderId;
  List photoList;

  Future getData() async {
    var url = baseUrl + 'photoList/' + folderId.toString();
    var response = await http.get(Uri.parse(url));
    setState(() {
      photoList = json.decode(response.body);
    });
  }

  File image;

  @override
  void initState() {
    super.initState();
    this.folderId = widget.id;
    getData();
  }

  Widget build(BuildContext context) {
    int id = widget.id;
    String folderName = widget.folderName;
    return Scaffold(
      appBar: AppBar(
        title: title,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: BackButton(color: color2),
        actions: [
          ShareFolder(
            folderId: id,
            folderName: folderName,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Center(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: photoList == null ? 0 : photoList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Center(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PhotoPage(
                                            id: photoList[index]['id'],
                                          )),
                                );
                              },
                              child: Container(
                                // width: 150,
                                // height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(color: Colors.black26),
                                ),
                                child: Center(
                                  child: Image.network(
                                      photoList[index]['image_path']),
                                ),
                              ),
                            onLongPress: (){
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    content: Container(
                                      height: 150,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('この画像をを削除しますか？',style: TextStyle(fontSize: 14),),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text(
                                            'キャンセル',
                                            style: TextStyle(color: color3),
                                          )),
                                      ElevatedButton(
                                          onPressed: () async {
                                            await deleteImage(photoList[index]['id']);
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(builder: (context) => PhotoList(id: id,folderName: folderName,)),
                                            );
                                          },
                                          child: Text('削除'),
                                          style: ElevatedButton.styleFrom(
                                            primary: color2,
                                          )),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        );
                      })))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.image),
        backgroundColor: color2,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(
                  '写真の選択',
                  textAlign: TextAlign.center,
                ),
                content: Container(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 180,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            camera();
                          },
                          child: Text('写真を撮る'),
                          style: ElevatedButton.styleFrom(
                            primary: color3,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            gallery();
                          },
                          child: Text('ギャラリーから選ぶ'),
                          style: ElevatedButton.styleFrom(
                            primary: color3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  SizedBox(
                    width: 270,
                    child: TextButton(
                      child: Text(
                        'キャンセル',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: color3),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  void camera() async {
    final picker = ImagePicker();
    var pickedFile = await picker.getImage(source: ImageSource.camera);
    File file = File(pickedFile.path);
    print(file);
    setState(() {
      image = file;
    });
    await uploadFile(image, widget.id);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => PhotoList(
                id: folderId,
              )
      ),
    );
  }

  void gallery() async {
    final picker = ImagePicker();
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    File file = File(pickedFile.path);
    print(file);
    setState(() {
      image = file;
    });
    await uploadFile(image, widget.id);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => PhotoList(
                id: folderId,
              )
      ),
    );
  }
}
