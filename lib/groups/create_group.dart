import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dataBase/base_url.dart';
import '../parts/color.dart';
import '../groups/groups_top.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController groupController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.group_add,
          color: color2,
        ),
        onPressed: createDialog);
  }

  Future createDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return Form(
              key: _formKey,
              child: AlertDialog(
                title: Text('グループ作成'),
                content: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'グループ名を入力してください';
                    }
                    return null;
                  },
                  controller: groupController,
                  decoration: InputDecoration(labelText: 'グループ名'),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('キャンセル')),
                  ElevatedButton(onPressed: createGroup, child: Text('作成'))
                ],
              ));
        });
  }

  Future createGroup() async {
    if (_formKey.currentState.validate()) {
      final int myId =  await user();
      var userId =  myId.toString();

      String groupName = groupController.text;

      String url = baseUrl + "createGroup";
      Map<String, String> headers = {'content-type': 'application/json'};
      String body =
          json.encode({'group_name': groupName, 'user_id': userId});
      http.Response resp =
          await http.post(Uri.parse(url), headers: headers, body: body);
      print(body);
      if (resp.statusCode <= 201) {
        groupController.text = ''; //TextFieldの値を消す
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => GroupsTop()));
      } else {
        print(resp.statusCode);
      }
    }
  }
}
