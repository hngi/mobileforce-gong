import 'package:flutter/material.dart';
import 'package:team_mobileforce_gong/UI/home.dart';
import 'package:team_mobileforce_gong/bottombar.dart';

import 'UI/widgets/drawer/drawer.dart';
import 'services/navigation/app_navigation/navigation.dart';



class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: HomeDrawer(),
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigation().pushFrom(context, MyHomePage());
        }),
        title: Text('Test page'),
      ),
      body: Center(
        child: Text('Hello world'),
      ),
    );
  }
}