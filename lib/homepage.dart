import 'package:flutter/material.dart';


class homepage extends StatefulWidget {
  const homepage({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: FloatingActionButton(
          child: Icon(Icons.add,size: 45,color: Colors.white,),
          backgroundColor: Color(0xff0984E3),
          onPressed: () => null,

        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Color(0xff0984E3),
        title: Text(
          'Welcome Oluwaseun',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: false,
        actions: <Widget>[CircleAvatar(
          backgroundImage: AssetImage('assets/images/userImage.png'),

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
                  child: Text('Lagos, Nigeria'),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
