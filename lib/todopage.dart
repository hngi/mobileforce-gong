import 'package:flutter/material.dart';


class todopage extends StatefulWidget {
  const todopage({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _todopageState createState() => _todopageState();
}

class _todopageState extends State<todopage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.lightGreenAccent,
        title: Text(
          'ToDoList Page',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: false,
        actions: <Widget>[CircleAvatar(
          backgroundImage: AssetImage('assets/images/tab_2.png'),
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
                  child: Text('Ibadan, Nigeria'),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
