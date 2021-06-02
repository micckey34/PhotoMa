import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../dataBase/base_url.dart';

Future deletePost(int id) async {
  String url = baseUrl + "deletePost";
  Map<String, String> headers = {'content-type': 'application/json'};
  String body = json
      .encode({'id':id});
  http.Response resp =
  await http.post(Uri.parse(url), headers: headers, body: body);
  print(resp.statusCode);
}