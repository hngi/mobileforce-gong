import 'package:flutter/material.dart';
import 'package:team_mobileforce_gong/UI/password_reset.dart';
import 'package:team_mobileforce_gong/responsiveness/responsiveness.dart';

class EditProfile extends StatefulWidget {
  //EditProfile({Key key, this.title}) : super(key: key);


  final String title = "Edit Profile";

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final textController = TextEditingController();
  final sizeConfig = SizeConfig();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 104,
              height: 104,
              margin: EdgeInsets.only(top: sizeConfig.yMargin(context, 3.3), bottom: sizeConfig.yMargin(context, 1.0)),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  //image: NetworkImage('http://url-to-user-imae'), //Use this in final build
                  //For image assets
                  image: AssetImage('assets/images/stock-photo.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: sizeConfig.yMargin(context, 3.0)),
              child: Text('John Doe',
                style: TextStyle(letterSpacing: 0.07 ,fontWeight: FontWeight.bold, fontSize: sizeConfig.textSize(context, 4.8), fontFamily: 'Gilroy',),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.all(sizeConfig.yMargin(context, 3.3)),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: textController,
                    decoration: InputDecoration(
//                        border: InputBorder.none,
                      hintText: 'First Name',
                      hintStyle: TextStyle(fontFamily: 'Gilroy'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: sizeConfig.yMargin(context, 3.3)),
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
//                        border: InputBorder.none,
                        hintText: 'Last Name',
                        hintStyle: TextStyle(fontFamily: 'Gilroy'),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: sizeConfig.yMargin(context, 3.3)),
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
//                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle: TextStyle(fontFamily: 'Gilroy'),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: sizeConfig.yMargin(context, 3.3)),
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
//                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: TextStyle(fontFamily: 'Gilroy'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              color: Colors.blue,
              padding: EdgeInsets.all(14),
              child: const Text('Submit', style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Container(
                  margin: EdgeInsets.only(top: sizeConfig.yMargin(context, 3.3)),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('Reset password',
                      style: TextStyle(fontFamily: 'Gilroy', color: Colors.blue, decoration: TextDecoration.underline))
              ),
            ),
          ],
        ),
      ),
    );
  }
}
