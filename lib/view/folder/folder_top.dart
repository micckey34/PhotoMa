import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../dataBase/base_url.dart';
import '../../parts/nav_bar.dart';
import '../../parts/color.dart';
import 'folder_page.dart';
import '../../components/folder/delete_folder.dart';
import '../../components/folder/add_folder.dart';

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
        body: (folders != null && folders.length == 0)
            ? Container(
          child: Center(child: Text('右上のアイコンから新しいフォルダを作ってみましょう！'),),
        )
            : Container(
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FolderPage(
                                          id: folders[index]['id'],
                                          folderName: folders[index]
                                              ['folder_name'],
                                        )),
                              );
                            },
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    content: Container(
                                      height: 150,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "「${folders[index]['folder_name']}」",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'このフォルダをを削除しますか？',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          Text(
                                            '中の画像も削除されます。',
                                            style: TextStyle(fontSize: 14),
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            'キャンセル',
                                            style: TextStyle(color: color3),
                                          )),
                                      ElevatedButton(
                                          onPressed: () async {
                                            await deleteFolder(
                                                folders[index]['id']);
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FolderTop()),
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
                                  style: GoogleFonts.getFont('Kosugi Maru',fontSize: 18,color: color2),
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
