import 'package:flutter/material.dart';
import 'package:team_mobileforce_gong/my_flutter_app_icons.dart';


class ProfilePage extends StatefulWidget {

  ProfilePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ProfilePageState createState() => ProfilePageState();


}

class ProfilePageState extends State<ProfilePage> {

  Color color;

  @override
  void initState() {
    super.initState();

    color = Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Profile Page Demo"),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Profile Page Demo',
            ),
          ],
        ),
      ),
    drawer: Container(
      width: 250,
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          SizedBox(height: 20),
//          ListView(
//            children: ListTile.divideTiles(
//                context: context, tiles: [
                  ListTile(
                    leading: Icon(Icons.contacts, color: Colors.lightBlue, size: 15,),
                    title: Text('Edit Profile', style: TextStyle(decoration: TextDecoration.underline)),
                    onTap: () {},
                    onLongPress: (){},
                  ),
                  Divider(color: Colors.lightBlueAccent),

                  ListTile(
                    leading: Icon(Icons.event, color: Colors.lightBlue, size: 15,),
                    title: Text('View All Notes', style: TextStyle(decoration: TextDecoration.underline)),
                    onTap: () {},
                    onLongPress: (){},
                  ),
                  Divider(color: Colors.lightBlueAccent),
                  ListTile(
                    leading: Icon(Icons.event, color: Colors.lightBlue, size: 15),
                    title: Text('View To-Dos', style: TextStyle(decoration: TextDecoration.underline)),
                    onTap: () {},
                    onLongPress: (){},
                  ),
                  Divider(color: Colors.lightBlueAccent),
                  ListTile(
                    leading: Icon(Icons.format_quote, color: Colors.lightBlue, size: 15),
                    title: Text('See Quotes', style: TextStyle(decoration: TextDecoration.underline)),
                    onTap: () {},
                    onLongPress: (){},
                  ),
                  Divider(color: Colors.lightBlueAccent),
                  ListTile(
                    leading: Icon(Icons.collections_bookmark, color: Colors.lightBlue, size: 15),
                    title: Text('Auto System', style: TextStyle(decoration: TextDecoration.underline)),
                    onTap: () {},
                    onLongPress: (){},
                  ),
                  Divider(color: Colors.lightBlueAccent),
                  ListTile(
                    leading: Icon(Icons.swap_calls, color: Colors.lightBlue, size: 15),
                    title: Text('Dark Mode', style: TextStyle(decoration: TextDecoration.underline)),
                    onTap: () {},
                    onLongPress: (){},
                  ),
                  Divider(color: Colors.lightBlueAccent),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.lightBlue, size: 15),
                    title: Text('Setting', style: TextStyle(decoration: TextDecoration.underline)),
                    onTap: () {},
                    onLongPress: (){},
                  ),
                  Divider(color: Colors.lightBlueAccent),
                  ListTile(
                    leading: Icon(Icons.stars, color: Colors.lightBlue, size: 15),
                    title: Text('About', style: TextStyle(decoration: TextDecoration.underline)),
                    onTap: () {},
                    onLongPress: (){},
//                  )
//            ]).toList(),
          ),
          Divider(color: Colors.lightBlueAccent),
          SizedBox(height: 80),
          Container(
            child: ListTile(
            title: new Row(children: <Widget>[new Text("Last seen January 2166", style: TextStyle(decoration: TextDecoration.underline),)],
              mainAxisAlignment: MainAxisAlignment.center,),
            onTap: () {},
          )
          ),
        ],
      ),
    ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 25.0,
              left: 60.0,
              child: Text("My Profile",
                  style: TextStyle(
                      color: Colors.white,
//                      fontFamily: "Gilroy",
                      decoration: TextDecoration.underline))),
        ]
        )
    );
  }

  Widget _createDrawerItem({IconData icon, String text}) {
    return Container(
        color: color,
        child: ListTile(
          leading: Icon(icon, color: Colors.lightBlue, size: 15),
          title:
          Text(text, style: TextStyle(decoration: TextDecoration.underline)),
            onTap: () {
              setState(() {
                color = Colors.lightBlueAccent;
              });
            }
              ),
    );
  }
}