import 'package:flutter/material.dart';
import 'color.dart';
import 'package:google_fonts/google_fonts.dart';
import '../folders/folder_top.dart';
import '../groups/groups_top.dart';
import '../search/search_top.dart';
import '../setting/setting_top.dart';

Text title = Text('PhotoMa',
    style:GoogleFonts.getFont(
        'Fredericka the Great',color: color2,fontSize: 30
    )
);

class BottomNavBar extends StatelessWidget {

  Widget button(icon,context,page){
    return
      ButtonTheme(
          height: 80,
          minWidth: 80,
          child: IconButton(
              icon: Icon(icon,size: 35,color: color2,),
              onPressed: (){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => page));
              }
          )
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1.0,
            blurRadius: 5.0,
            offset: Offset(0, 0),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          button(Icons.folder, context, FolderTop()),
          button(Icons.group, context, GroupsTop()),
          button(Icons.search, context, SearchTop()),
          button(Icons.settings, context, SettingTop()),
        ],
      ),
    );
  }
}
