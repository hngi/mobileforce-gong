import 'package:flutter/material.dart';
import 'package:team_mobileforce_gong/my_flutter_app_icons.dart';

class ProfilePage extends StatelessWidget {

  ProfilePage({Key key, this.title}) : super(key: key);


  final String title;

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
          _createDrawerItem(
              icon: Icons.contacts,
              text: 'Edit Profile'),
          Divider(
            thickness: 0.4,
            color: Colors.lightBlue,
          ),
          _createDrawerItem(
              icon: Icons.event,
              text: 'View All Notes',),
          Divider(
            thickness: 0.4,
            color: Colors.lightBlue,
          ),
          _createDrawerItem(
              icon: Icons.format_quote,
              text: 'See Quotes',),
          Divider(
            thickness: 0.4,
            color: Colors.lightBlue,
          ),
          _createDrawerItem(icon: Icons.collections_bookmark, text: 'Auto System'),
          Divider(
            thickness: 0.4,
            color: Colors.lightBlue,
          ),
          _createDrawerItem(
              icon: Icons.swap_calls,
              text: 'Dark Mode'),
          Divider(
            thickness: 0.4,
            color: Colors.lightBlue,
          ),
          _createDrawerItem(
              icon: Icons.settings, text: 'Setting'),
          Divider(
            thickness: 0.4,
            color: Colors.lightBlue,
          ),
          _createDrawerItem(icon: Icons.stars, text: 'About'),
          Divider(
            thickness: 0.4,
            color: Colors.lightBlue,
          ),
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

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return Ink(
      color: Colors.lightBlueAccent,
      child: ListTile(
        title: Row(
          children: <Widget>[
            Icon(icon, color: Colors.lightBlue, size: 15),
            Container(
              padding: EdgeInsets.only(left: 50.0),
              child: Text(text, style: TextStyle(decoration: TextDecoration.underline)),

            ),

          ],
        ),
        onTap: onTap,
      ),
    );
  }
}