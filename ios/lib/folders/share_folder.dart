import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dataBase/base_url.dart';
import '../parts/color.dart';

class ShareFolder extends StatefulWidget {
  final int folderId;
  final String folderName;

  const ShareFolder({Key key, this.folderId, this.folderName})
      : super(key: key);

  @override
  _ShareFolderState createState() => _ShareFolderState();
}

class _ShareFolderState extends State<ShareFolder> {
  int groupId;

  String groupName = '';

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.share,
          color: color2,
        ),
        onPressed: shareDialog);
  }

  Future shareDialog() async {
    final int myId = await user();
    var url = baseUrl + 'groupList/' + myId.toString();
    var response = await http.get(Uri.parse(url));
    List groups = json.decode(response.body);
    print(groups);

    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text('Share'),
              content: Container(
                width: 400,
                height: 320,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('シェアするグループを選択してください', style: TextStyle(fontSize: 14)),
                    Container(
                      width: double.infinity,
                      height: 250,
                      child: Center(
                        child: ListView.builder(
                            itemCount: groups == null ? 0 : groups.length,
                            itemBuilder: (context, index) {
                              return Container(
                                // padding: EdgeInsets.only(left: 10,right: 10),
                                decoration: BoxDecoration(
                                  border:
                                      Border(bottom: BorderSide(color: color2)),
                                ),
                                child: ListTile(
                                    leading: Icon(
                                      Icons.group,
                                      color: color2,
                                    ),
                                    title: Text(
                                        '${groups[index]['group_name']}',
                                        style: TextStyle(color: color2)),
                                    contentPadding: EdgeInsets.all(2.0),
                                    onTap: () {
                                      groupId = groups[index]['id'];
                                    }),
                              );
                            }),
                      ),
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
                  onPressed: share,
                  child: Text('シェア'),
                  style: ElevatedButton.styleFrom(
                    primary: color2,
                  ),
                )
              ],
            );
          });
        });
  }

  select(group) {
    groupId = group;
  }

  Future<void> share() async {
    final int myId = await user();

    var url = baseUrl + 'groupPostFolder';
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({
      'posts': widget.folderName,
      'group_id': groupId,
      'user_id': myId,
      'folder_id': widget.folderId
    });
    http.Response resp =
        await http.post(Uri.parse(url), headers: headers, body: body);
    print(resp.statusCode);
    if (resp.statusCode <= 201) {
      Navigator.pop(context);
    }
  }
}
