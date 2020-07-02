import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/state/theme_notifier.dart';
import 'package:team_mobileforce_gong/util/const/constFile.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  String phoneNumber = "+2348066701121";
  String email = 'olakunle Temitayo';
  String desc = 'This is a bit description about myself';
  String name = 'Tayo Olakunle';
  String address = 'Ago Palace Way surulere Lagos';
  String img;

  SizeConfig size = SizeConfig();

  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future<void> getUser() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        email = user.email;
        name = user.displayName;
        print(name);
        // img = user.photoUrl;
      });
    });
  }

  var darktheme;

  @override
  Widget build(BuildContext context) {
    darktheme = Provider.of<ThemeNotifier>(context).isDarkModeOn ?? false;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(
      //     Icons.edit,
      //     color: Colors.white,
      //   ),
      //   foregroundColor: kPrimaryColor,
      // ),
      body: SafeArea(
        child: Container(
          color: darktheme ? Color(0xff0D141A) : Color(0xffFAFAFA),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Center(
                    child: Text(
                      'Profile',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: darktheme ? Colors.white70 : Colors.black),
                    ),
                  ),
                ],
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    getImage();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      width: 106,
                      height: 106,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/Ellipse 14 (1).png',
                            )),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: kGrey, width: 2, style: BorderStyle.solid),
                      ),
                      child: _image == null
                          ? SizedBox()
                          : Image.file(
                              _image,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: Text(
                  name,
                  style: TextStyle(fontSize: 24, color: kBlack),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Center(
                child: Text(
                  desc,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: kGrey),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Expanded(
                child: Container(
                  width: size.xMargin(context, 100),
                  height: size.yMargin(context, 100),
                  decoration: BoxDecoration(
                      color: darktheme ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Display Name',
                          style: TextStyle(
                              fontSize: 18,
                              color: kBlack,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          name,
                          style: TextStyle(fontSize: 18, color: kGrey),
                        ),
                        Divider(
                          color: kGrey,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          'Email Address',
                          style: TextStyle(
                              fontSize: 18,
                              color: kBlack,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          email,
                          style: TextStyle(fontSize: 18, color: kGrey),
                        ),
                        Divider(
                          color: kGrey,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        // Text(
                        //   'Address',
                        //   style: TextStyle(
                        //       fontSize: 18,
                        //       color: kBlack,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        // SizedBox(
                        //   height: 8,
                        // ),
                        // Text(
                        //   address,
                        //   style: TextStyle(fontSize: 18, color: kGrey),
                        // ),
                        // Divider(
                        //   color: kGrey,
                        //   thickness: 1,
                        // ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
