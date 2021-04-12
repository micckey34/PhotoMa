import 'package:flutter/material.dart';
import '../parts/nav_bar.dart';
import '../parts/color.dart';

class GroupPage extends StatefulWidget {
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: BackButton(color: color2),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                    child: Row(
                      children: [
                        Container(
                          child: Column(
                            children: [Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('assets/image.png')),
                                  boxShadow: [BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 2.0,
                                    blurRadius: 10.0,
                                    offset: Offset(0, 0),
                                  )],
                                )),
                              Text('name')
                          ]),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 2.0,
                                blurRadius: 10.0,
                                offset: Offset(0, 0),
                              )],
                            ))
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              // color: Colors.black12,
              height: 50,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IntrinsicWidth(
                    stepWidth: 340,
                    stepHeight: 50,
                    child: TextField(
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
                          onPressed: () {},
                          child: Text('送信',style: TextStyle(fontSize: 14),)))
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
