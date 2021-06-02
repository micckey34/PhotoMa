import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../dataBase/base_url.dart';
import '../../parts/color.dart';
import '../../view/folder/folder_top.dart';

class AddFolder extends StatefulWidget {
  @override
  _AddFolderState createState() => _AddFolderState();
}

class _AddFolderState extends State<AddFolder> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController folderController = TextEditingController();
  var _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.create_new_folder,
        color: color2,
      ),
      onPressed: addDialog,
    );
  }

  Future addDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return Form(
            key: _formKey,
            child: StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title: Text('フォルダ作成'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: folderController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'フォルダ名を入力してください';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: folderController.clear,
                            icon: Icon(Icons.clear),
                          ),
                        ),
                      ),
                      SwitchListTile(
                        value: _switchValue,
                        activeColor: color2,
                        title: Text(
                          'フォルダを公開する',
                          style: TextStyle(fontSize: 13),
                        ),
                        onChanged: (bool value) {
                          print(value);
                          setState(() {
                            _switchValue = value;
                          });
                        },
                      )
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      child: Text(
                        'キャンセル',
                        style: TextStyle(color: color3),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  ElevatedButton(
                    onPressed: addFolder,
                    child: Text('作成'),
                    style: ElevatedButton.styleFrom(
                      primary: color3,
                    ),
                  )
                ],
              );
            }),
          );
        });
  }

  Future addFolder() async {
    if (_formKey.currentState.validate()) {
      final int myId = await user();
      String folderName = folderController.text;
      bool look;
      if (_switchValue == true) {
        look = false;
      } else {
        look = true;
      }
      String url = baseUrl + "createFolder";
      Map<String, String> headers = {'content-type': 'application/json'};
      String body = json
          .encode({'folder_name': folderName, 'user_id': myId, 'look': look});
      http.Response resp =
          await http.post(Uri.parse(url), headers: headers, body: body);
      print(body);
      if (resp.statusCode <= 201) {
        print(resp.statusCode);
        folderController.text = ''; //TextFieldの値を消す
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => FolderTop()));
      } else if (resp.statusCode > 201) {
        print(resp.statusCode);
      }
    }
  }
}
