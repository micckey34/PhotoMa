import 'package:app_photoma/parts/color.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  @override
  Widget build(BuildContext context) {
    return IconButton(icon: Icon(Icons.group_add,color: color2,), onPressed: createGroup);
  }

  Future createGroup() async {

  }
}
