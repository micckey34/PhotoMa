import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../dataBase/base_url.dart';
import '../../parts/nav_bar.dart';
import '../../parts/color.dart';
import 'group_page.dart';
import '../../components/group/create_group.dart';
import '../../components/group/join_group.dart';

class GroupsTop extends StatefulWidget {
  @override
  _GroupsTopState createState() => _GroupsTopState();
}

class _GroupsTopState extends State<GroupsTop> {
  List groups;

  Future getData() async {
    final int myId = await user();
    var url = baseUrl + 'groupList/' + myId.toString();
    var response = await http.get(Uri.parse(url));
    setState(() {
      groups = json.decode(response.body);
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
        // backgroundColor: color1,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: title,
          centerTitle: true,
          actions: [CreateGroup()],
        ),
        body: (groups != null && groups.length == 0)
            ? Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('右上のアイコンからグループを作ってみましょう。'),
                      Text('また、右下のアイコンから'),
                      Text('グループに参加することもできます。')
                    ],
                  ),
                ),
              )
            : Center(
                child: ListView.builder(
                    itemCount: groups == null ? 0 : groups.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: color3)),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.group,
                            color: color2,
                            size: 30,
                          ),
                          title: Text('${groups[index]['group_name']}',
                              style: TextStyle(fontSize: 25, color: color2)),
                          trailing: Icon(Icons.arrow_forward_ios_outlined,
                              color: color3),
                          contentPadding: EdgeInsets.all(5.0),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      GroupPage(id: groups[index]['id'])),
                            );
                          },
                        ),
                      );
                    }),
              ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: color2,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JoinGroup()),
            );
          },
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
