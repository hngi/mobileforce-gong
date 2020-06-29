import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:team_mobileforce_gong/const/constFile.dart';
import 'package:team_mobileforce_gong/responsiveness/responsiveness.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        foregroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        child: Container(
          color: Color(0xffFAFAFA),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: kGrey, width: 2, style: BorderStyle.solid),
                      ),
                      child: _image == null
                          ? Icon(
                              Icons.camera_enhance,
                              color: kGrey,
                            )
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
                  'Your Name Here',
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
                      color: Colors.white,
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
                          'Mobile',
                          style: TextStyle(
                              fontSize: 18,
                              color: kBlack,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          phoneNumber,
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
                        Text(
                          'Address',
                          style: TextStyle(
                              fontSize: 18,
                              color: kBlack,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          address,
                          style: TextStyle(fontSize: 18, color: kGrey),
                        ),
                        Divider(
                          color: kGrey,
                          thickness: 1,
                        ),
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
