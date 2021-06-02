import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dataBase/base_url.dart';
import '../parts/color.dart';
import 'group_page.dart';

class PostCreate extends StatefulWidget {
  final int groupId;

  const PostCreate({Key key, this.groupId}) : super(key: key);

  @override
  _PostCreateState createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {
  TextEditingController postController = TextEditingController();

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
            controller: postController,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
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
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                )))
      ],
    );
  }

  Future postBtn() async {
    final int myId = await user();
    var text = postController.text;
    print(text);

    var url = baseUrl + 'groupPost';
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json
        .encode({'posts': text, 'group_id': widget.groupId, 'user_id': myId});
    http.Response resp =
        await http.post(Uri.parse(url), headers: headers, body: body);
    print(resp.statusCode);
    print(body);
    if (resp.statusCode <= 201) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => GroupPage(
                    id: widget.groupId,
                  )));
    }
  }
}
