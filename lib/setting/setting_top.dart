import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../dataBase/local_db.dart';
import '../dataBase/base_url.dart';
import '../parts/nav_bar.dart';
import '../parts/color.dart';
import '../setting/sign_in.dart';
import 'profile_image.dart';
import 'change_my_data.dart';

class SettingTop extends StatefulWidget {
  @override
  _SettingTopState createState() => _SettingTopState();
}

class _SettingTopState extends State<SettingTop> {

  TextEditingController nameController = TextEditingController();
  TextEditingController salonController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var data;

  File image;

  Future getData() async {
    final int myId =  await user();
    var url = baseUrl + 'myData/' + myId.toString();
    var response = await http.get(Uri.parse(url));
    setState(() {
      data = json.decode(response.body);
    });
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
                width: double.infinity,
                // color: color2,
                child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: data != null && data['profile_image_path'] != null ?
                                NetworkImage(data['profile_image_path'])
                                    : AssetImage('assets/image.png')
                            ),
                          )
                      ),
                      TextButton(
                          child:Text('プロフィール写真の変更' ,style: TextStyle(color: color2),),
                          onPressed: ()async{
                            gallery();
                            await Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => SettingTop()),
                            );
                          }
                      )
                    ]
                ),
              ),
              Divider(color: color2,thickness: 2,),
              SizedBox(height: 30,),
              Container(
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    inputField(nameController,'name',data == null ? 'name':data['name']),
                    inputField(salonController,'salon',data == null ? 'salon':data['salon']),
                    inputField(emailController,'email',data == null ? 'email':data['email']),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Container(
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: color3,),
                    child: Text('ログアウト'),
                    onPressed: () {
                      logout();
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

  Widget inputField(controller,type,value) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
          IntrinsicWidth(
            stepWidth: 280,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: type +' : '+ value,
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () async{
                var text = controller.text;
                if(text != ''){
                  await changeData(type, text);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context)=>ChangeDone(type: type,)
                      ));
                }
              },
              style: ElevatedButton.styleFrom(
                  primary: color2,),
              child: Text('保存')
          )
        ]);
  }


  void gallery() async {
    final picker = ImagePicker();
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    File file = File(pickedFile.path);
    print(file);
      image = file;
    await uploadFile(image);
  }


  void logout() async {
    final id = await ldb.queryRowCount();
    final rowsDeleted = await ldb.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
}
