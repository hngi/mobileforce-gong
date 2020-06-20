import 'package:flutter/material.dart';


class notepage extends StatefulWidget {
  const notepage({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _notepageState createState() => _notepageState();
}

class _notepageState extends State<notepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Welcome Oluwaseun',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: false,
        actions: <Widget>[CircleAvatar(
          backgroundImage: AssetImage('assets/images/tab_3.png'),
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
                  child: Text('Delta, Nigeria'),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
