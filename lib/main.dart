import 'package:flutter/material.dart';
import 'dataBase/local_db.dart';
import 'setting/sign_in.dart';
import 'folders/folder_top.dart';
import 'parts/color.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhotoMa',
      home: StartPage(),
      theme: ThemeData(
        primaryColor: color2
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  Future check() async{
    final localData = await LocalDatabase.instance.queryAllRows();
    localData.forEach((row) => print(row));
    if(localData.length != 0 ){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FolderTop()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );

    }
  }

  @override
  void initState() {
    super.initState();
    check();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      color: color1,
      ),
    );
  }
}

