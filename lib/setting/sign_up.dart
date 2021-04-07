import 'dart:convert';
import 'package:app_photoma/parts/color.dart';
import 'package:app_photoma/parts/db.dart';
import 'package:app_photoma/setting/sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController salonController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              // color: Colors.blue,
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
              // color: Colors.red,
              height: 600,
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '名前を入力してください';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Name'),
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      controller: salonController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '美容室を入力してください';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Salon'),
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'メールアドレスを入力してください';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'E-mail'),
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
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
                    Container(
                      child: Column(children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: color3,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 10),
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: _request,
                            child: Text('新規登録')),

                        TextButton(
                          onPressed: signIn,
                          child: Text('ログインはこちら'),
                          style: TextButton.styleFrom(
                              textStyle: TextStyle(fontSize: 18)),
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _request() async {
    if (_formKey.currentState.validate()) {
      var name = nameController.text;
      var salon = salonController.text;
      var email = emailController.text;
      var password = passwordController.text;

      var _content;
      String url = baseUrl + "create";
      Map<String, String> headers = {'content-type': 'application/json'};
      String body = json.encode(
          {'name': name, 'salon': salon, 'email': email, 'password': password});
      http.Response resp =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (resp.statusCode <= 201) {
        setState(() {
          int statusCode = resp.statusCode;
          _content = "Failed to post $statusCode";
          print(_content);
        });
        signIn();
      } else if (resp.statusCode > 201) {
        setState(() {
          int statusCode = resp.statusCode;
          _content = "Failed to post $statusCode";
          print(_content);
          errorMessage = '正常に登録ができませんでした';
        });
      }
    }
  }

  void signIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
    );
  }
}

class SignUpCheck extends StatefulWidget {
  @override
  _SignUpCheckState createState() => _SignUpCheckState();
}

class _SignUpCheckState extends State<SignUpCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
