import 'dart:convert';
import 'package:app_photoma/parts/nav_bar.dart';
import 'package:app_photoma/setting/setting_top.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_photoma/parts/db.dart';

Future<void> changeData(type, value) async {
  String url = baseUrl + 'update';
  Map<String, String> headers = {'content-type': 'application/json'};
  String body = json.encode({'type': type, 'id': user['id'], 'value': value});
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
      appBar: AppBar(),
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(type + 'が変更されました。',style: TextStyle(fontSize: 20),),
            SizedBox(height: 30,),
            ElevatedButton(
                child: Text('戻る'),
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
