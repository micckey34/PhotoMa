import '../folders/photo_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dataBase/base_url.dart';
import '../parts/color.dart';

class MemoCreate extends StatefulWidget {
  final int imageId;
  const MemoCreate({Key key, this.imageId}) : super(key: key);

  @override
  _MemoCreateState createState() => _MemoCreateState();
}

class _MemoCreateState extends State<MemoCreate> {
  TextEditingController memoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IntrinsicWidth(
          stepWidth: 340,
          stepHeight: 50,
          child: TextField(
            controller: memoController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.black38,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.black38,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
            height: 50,
            width: 60,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(color2)),
                onPressed: postBtn ,
                child: Text('メモ',style: TextStyle(fontSize: 13),)
            )
        )
      ],
    );
  }

  Future postBtn() async{
    final int myId =  await user();
    var text = memoController.text;
  //   print(text);
  //
    var url = baseUrl + 'memoCreate';
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({'posts':text,'image_id':widget.imageId});
    http.Response resp =
    await http.post(Uri.parse(url), headers: headers, body: body);
    print(resp.statusCode);
    print(body);
    if(resp.statusCode <= 201){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PhotoPage(id: widget.imageId,)));
    }
  }
}



