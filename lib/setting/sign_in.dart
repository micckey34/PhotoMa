import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import '../dataBase/base_url.dart';
import '../dataBase/local_db.dart';
import '../folders/folder_top.dart';
import '../parts/color.dart';
import '../setting/sign_up.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              child: Column(children: [
                SizedBox(
                  height: 150,
                ),
                Center(
                  child: Text(
                    'PhotoMa',
                    style: GoogleFonts.getFont('Fredericka the Great',
                        color: color2, fontSize: 50),
                  ),
                ),
              ]),
            ),
            Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'メールアドレスを入力してください';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'E-Mail'),
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'パスワードを入力してください';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Password'),
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: _request,
                      child: Text('ログイン'),
                      style: ElevatedButton.styleFrom(
                          primary: color3,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          textStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    TextButton(
                      onPressed: signUp,
                      child: Text(
                        '新規登録はこちら',
                        style: TextStyle(color: color2),
                      ),
                      style: TextButton.styleFrom(
                          textStyle: TextStyle(fontSize: 18)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _request() async {
    if (_formKey.currentState.validate()) {
      var email = emailController.text;
      var password = passwordController.text;

      String url = baseUrl + "signIn";
      Map<String, String> headers = {'content-type': 'application/json'};
      String body = json.encode({'email': email, 'password': password});
      http.Response resp =
          await http.post(Uri.parse(url), headers: headers, body: body);
      Map status = json.decode(resp.body);

      if (status['result'] == 'true') {
        //ローカルデータベースに保存
        Map<String, dynamic> row = {LocalDatabase.myId: status['id']};
        final id = await ldb.insert(row);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FolderTop()),
        );
      } else {
        print('ログイン失敗');
        setState(() {
          errorMessage = 'メールアドレスかパスワードが間違っています！';
        });
      }
    }
  }

  void signUp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignUp()),
    );
  }
}
