import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dataBase/base_url.dart';
import '../parts/nav_bar.dart';
import '../parts/color.dart';
import '../setting/setting_top.dart';

Future<void> changeData(type, value) async {
  final int myId =  await user();
  String url = baseUrl + 'update';
  Map<String, String> headers = {'content-type': 'application/json'};
  String body = json.encode({'type': type, 'id': myId, 'value': value});
  http.Response resp =
  await http.post(Uri.parse(url), headers: headers, body: body);
  print(body);
  if (resp.statusCode <= 201) {
    print(resp.statusCode);
  } else if (resp.statusCode > 201) {
    print(resp.statusCode);
  }
}

class ChangeDone extends StatelessWidget {
  final String type;

  ChangeDone({this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: title,
        centerTitle: true,
        actions: [],
      ),
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(type + 'が変更されました。',style: TextStyle(fontSize: 20),),
            SizedBox(height: 30,),
            ElevatedButton(
                child: Text('戻る'),
                style: ElevatedButton.styleFrom(
                  primary: color3,),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SettingTop()));
                })
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
    ;
  }
}
