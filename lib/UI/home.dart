import 'package:flutter/material.dart';
import 'package:team_mobileforce_gong/services/navigation/app_navigation/navigation.dart';
import 'package:team_mobileforce_gong/test.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // endDrawer: HomeDrawer(),
      appBar: AppBar(
        title: Text('Test Homepage'),
      ),
      body: Center(
        child: RaisedButton(onPressed: (){
          Navigation().pushTo(context, Test());
        }),
      ),
    );
  }
}
