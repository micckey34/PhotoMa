import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dataBase/base_url.dart';
import '../parts/nav_bar.dart';
import '../parts/color.dart';
import '../groups/groups_top.dart';

class JoinGroup extends StatefulWidget {
  @override
  _JoinGroupState createState() => _JoinGroupState();
}

class _JoinGroupState extends State<JoinGroup> {
  Widget join = Container();
  Map group;
  String btn = '検索';
  TextEditingController idController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: title,
        centerTitle: true,
        leading: BackButton(
            color: color2
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 50,right: 50),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 80,),
                Text('加入するグループのIDを入力してください'),
                TextField(
                  controller: idController,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
                SizedBox(height: 30,),
                ElevatedButton(
                    onPressed: search,
                    child: Text(btn),
                  style: ElevatedButton.styleFrom(
                    primary: color3,),
                ),
            SizedBox(height: 20,),
                join
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  void search() async{
    var id = idController.text;
    String url = baseUrl + "searchGroup";
    Map<String, String> headers = {'content-type': 'application/json'};
    String body =
    json.encode({'unique_id':id});
    http.Response resp =
    await http.post(Uri.parse(url), headers: headers, body: body);
    print(body);
    print(resp.statusCode);
    if (resp.statusCode <= 201) {
      group = json.decode(resp.body);
      print(resp.body);
      setState(() {
        btn = '再検索';
        join = Container(
          child: Column(
            children: [
              Text('グループ名'),
              Text('「'+group['group_name']+'」',style: TextStyle(fontSize: 30),),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: joinCreate, child: Text('加入'),
                style: ElevatedButton.styleFrom(
                primary: color3,),
        )
            ],
          ),
        );
      });
    } else {
      setState(() {
        join = Container(
          child: Column(
            children: [
              Text('グループが見つかりませんでした'),
              Text('別のIDで検索してください'),
            ],
          ),
        );
      });
    }


  }

  void joinCreate() async{
    var groupId = group['id'];
    final int myId =  await user();
    String url = baseUrl + "joinGroup";
    Map<String, String> headers = {'content-type': 'application/json'};
    String body =
    json.encode({'user_id':myId,'group_id':groupId});
    http.Response resp =
    await http.post(Uri.parse(url), headers: headers, body: body);
    print(resp.statusCode);
    print(body);
    if (resp.statusCode <= 201) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GroupsTop()),
      );

    }
  }
}
