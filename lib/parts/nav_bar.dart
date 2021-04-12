import 'package:flutter/material.dart';
import 'color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_photoma/folders/folder_top.dart';
import 'package:app_photoma/groups/groups_top.dart';
import 'package:app_photoma/search/search_top.dart';
import 'package:app_photoma/setting/setting_top.dart';

Text title = Text('PhotoMa',style:GoogleFonts.getFont('Fredericka the Great',color: color2,fontSize: 30));

class BottomNavBar extends StatelessWidget {

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
          ButtonTheme(
              height: 80,
              minWidth: 80,
              child: IconButton(
                icon: Icon(Icons.folder,size: 35,color: color2,),
                  onPressed: (){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => FolderTop()));
                  }
              )
          ),ButtonTheme(
              height: 80,
              minWidth: 80,
              child: IconButton(
                icon: Icon(Icons.group,size: 35,color: color2,),
                  onPressed: (){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => GroupsTop()));
                  }
              )
          ),ButtonTheme(
              height: 80,
              minWidth: 80,
              child: IconButton(
                icon: Icon(Icons.search,size: 35,color: color2,),
                  onPressed: (){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SearchTop()));
                  }
              )
          ),ButtonTheme(
              height: 80,
              minWidth: 80,
              child: IconButton(
                icon: Icon(Icons.settings,size: 35,color: color2,),
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SettingTop()));
                }
              )
          ),
        ],
      ),
    );
  }
}
