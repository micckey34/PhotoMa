import 'dart:convert';
import 'dart:math';

import 'package:app_photoma/parts/db.dart';
import 'package:app_photoma/parts/nav_bar.dart';
import 'package:app_photoma/parts/color.dart';
import 'package:app_photoma/setting/sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'change_my_data.dart';

class SettingTop extends StatefulWidget {
  @override
  _SettingTopState createState() => _SettingTopState();
}

class _SettingTopState extends State<SettingTop> {
  final _nameKey = GlobalKey<FormState>();
  final _salonKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController salonController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var data;

  Future getData() async {
    var id = user['id'].toString();
    var url = baseUrl + 'myData/' + id;
    var response = await http.get(Uri.parse(url));
    setState(() {
      data = json.decode(response.body);
    });
    // print(data);
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
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                color: color2,
              ),
              Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Form(
                        key: _nameKey,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IntrinsicWidth(
                                stepWidth: 280,
                                child: TextFormField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    labelText: data == null ? !null
                                        : 'Name : ' + data['name'],
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '新しい名前を入力してください';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: ()   async{
                                    var text = nameController.text;
                                    if(text != ''){
                                      await changeData('name', text);
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context)=>ChangeDone(type: '名前',)
                                          ));
                                    }
                                  },
                                  child: Text('保存'))
                            ]),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Form(
                        key: _salonKey,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IntrinsicWidth(
                                stepWidth: 280,
                                child: TextFormField(
                                  controller: salonController,
                                  decoration: InputDecoration(
                                    labelText: data == null ? !null
                                        : 'Salon : ' + data['salon'],
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '新しいサロン名を入力してください';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    var text = salonController.text;
                                    if(text != ''){
                                      await changeData('salon', text);
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context)=>ChangeDone(type: 'サロン名',)
                                          ));
                                    }
                                  },
                                  child: Text('保存'))
                            ]),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Form(
                        key: _emailKey,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IntrinsicWidth(
                                stepWidth: 280,
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: data == null ? !null
                                        : 'E-mail : ' + data['email'],
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '新しいメールアドレスを入力してください';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () async{
                                    var text = emailController.text;
                                    if(text != ''){
                                    await changeData('email', text);
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context)=>ChangeDone(type: 'メールアドレス',)
                                        ));
                                    }
                                  },
                                  child: Text('保存'))
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Center(
                  child: ElevatedButton(
                    child: Text('ログアウト'),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => SignIn()));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
