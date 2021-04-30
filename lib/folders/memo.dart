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
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 50.0,
            maxWidth:   340,
          ),
          child: TextField(
            controller: memoController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.black38,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
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
                    backgroundColor: MaterialStateProperty.all<Color>(color2)),
                onPressed: postBtn,
                child: Text(
                  'メモ',
                  style: TextStyle(fontSize: 13),
                )
            )
        )
      ],
    );
  }

  Future postBtn() async {
    var text = memoController.text;
    var url = baseUrl + 'memoCreate';
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({'posts': text, 'image_id': widget.imageId});
    http.Response resp =
        await http.post(Uri.parse(url), headers: headers, body: body);
    print(resp.statusCode);
    if (resp.statusCode <= 201) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PhotoPage(
                    id: widget.imageId,
                  )
          )
      );
    }
  }
}
