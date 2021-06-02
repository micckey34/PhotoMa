import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart';
import '../../dataBase/base_url.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

Future uploadFile(File _image ) async {
  Firebase.initializeApp();

  final fileName = basename(_image.path);
  final destination = 'profile/$fileName';

  final ref = FirebaseStorage.instance.ref(destination);
  await ref.putFile(_image);
  String imageUrl = await firebase_storage.FirebaseStorage.instance
      .ref('profile/$fileName')
      .getDownloadURL();
  print(imageUrl);
  int myId = await user();

  String url = baseUrl + 'profileImg';
  Map<String, String> headers = {'content-type': 'application/json'};
  String body = json.encode({'profile_image_path': imageUrl, 'user_id': myId});
  http.Response resp =
  await http.post(Uri.parse(url), headers: headers, body: body);
  print(resp.statusCode);
}
