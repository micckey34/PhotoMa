import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dataBase/local_db.dart';
import '../dataBase/base_url.dart';
import '../parts/color.dart';
import 'folder_top.dart';


class AddFolder extends StatefulWidget {
  @override
  _AddFolderState createState() => _AddFolderState();
}

class _AddFolderState extends State<AddFolder> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController folderController = TextEditingController();
  bool looked = true;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.create_new_folder,color: color2,),
      onPressed: addDialog,
    );
  }

  Future addDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return Form(
            key: _formKey,
            child:StatefulBuilder(
              builder: (context, setState) {
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
                        RadioListTile(
                            title: Text('非公開'),
                            value: true,
                            groupValue: looked,
                            onChanged: (value) => selected(value)
                        ),
                        RadioListTile(
                            title: Text('公開'),
                            value: false,
                            groupValue: looked,
                            onChanged: (value) => selected(value)
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        child: Text('キャンセル'),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    ElevatedButton(onPressed: addFolder, child: Text('作成'))
                  ],
                );
              }),
          );
        });
  }

  selected(value) {
    setState(() {
      looked = value;
      print(value);
    });
  }

  Future addFolder() async {
    if (_formKey.currentState.validate()) {
      final int myId =  await user();
      String folderName = folderController.text;
      bool look = looked;

      String url = baseUrl+"createFolder";
      Map<String, String> headers = {'content-type': 'application/json'};
      String body = json.encode(
          {'folder_name': folderName, 'user_id': myId, 'look': look});
      http.Response resp =
      await http.post(Uri.parse(url), headers: headers, body: body);
      print(body);
      if (resp.statusCode <= 201) {
        print(resp.statusCode);
        folderController.text = ''; //TextFieldの値を消す
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => FolderTop()));
      } else if (resp.statusCode > 201) {
        print(resp.statusCode);
      }
    }
  }
}