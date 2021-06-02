import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dataBase/base_url.dart';

Future uploadFile(File _image, int _id) async {
  Firebase.initializeApp();

  final fileName = basename(_image.path);
  final destination = 'images/$fileName';

  final ref = FirebaseStorage.instance.ref(destination);
  await ref.putFile(_image);
  String imageUrl = await firebase_storage.FirebaseStorage.instance
      .ref('images/$fileName')
      .getDownloadURL();
  print(imageUrl);

  int myId = await user();
  int folderId = _id;

  String url = baseUrl + 'imgUpload';
  Map<String, String> headers = {'content-type': 'application/json'};
  String body = json
      .encode({'image_path': imageUrl, 'user_id': myId, 'folder_id': folderId});
  http.Response resp =
      await http.post(Uri.parse(url), headers: headers, body: body);
  print(resp.statusCode);
}
