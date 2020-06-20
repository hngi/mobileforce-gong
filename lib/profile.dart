import 'package:flutter/material.dart';


class profile extends StatefulWidget {
  const profile({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar( backgroundColor: Colors.lightBlueAccent,
        title: Text(
          'Profile Page',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: false,
        actions: <Widget>[CircleAvatar(
          backgroundImage: AssetImage('assets/images/tab_4.png'),
        )],
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.arrow_back,
                  size: 15,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Oyo, Nigeria'),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
