import 'package:app_photoma/folders/photo_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dataBase/base_url.dart';
import '../parts/nav_bar.dart';
import '../parts/color.dart';
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
    // print(folderId);
    // print(photoList);
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
          ShareFolder(folderId: id, folderName: folderName,)
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Center(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,),
                      itemCount: photoList == null ? 0 : photoList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Center(
                          child:GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PhotoPage(id: photoList[index]['id'],)),
                                );

                              },
                              child: Container(
                                // width: 150,
                                // height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black26),
                                ),
                                child: Center(
                                  child: Image.network(photoList[index]['image_path']),
                                ),
                              )
                          ),
                        );
                      })
              )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color2,
        onPressed: gallery,
        child: Icon(Icons.image),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  // void camera() async {
  //   final picker = ImagePicker();
  //
  //   var pickedFile = await picker.getImage(source: ImageSource.camera);
  //   File file = File(pickedFile.path);
  // }

  void gallery() async {
    final picker = ImagePicker();
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    File file = File(pickedFile.path);
    print(file);
    setState(() {
      image = file;
    });
    await uploadFile(image,widget.id);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PhotoList(id: folderId,)),
    );
  }
}
