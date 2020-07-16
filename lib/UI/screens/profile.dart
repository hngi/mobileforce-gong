import 'dart:io';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/services/auth/model.dart';
import 'package:team_mobileforce_gong/services/auth/firestore.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/state/theme_notifier.dart';
import 'package:team_mobileforce_gong/util/const/constFile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_mobileforce_gong/services/auth/userState.dart';
import 'package:team_mobileforce_gong/UI/screens/home_page.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      addProfilePicture(uid, _image);
    }
  }

  String phoneNumber = "+2348066701121";
  String email = 'user@user.com';
  String desc = "";
  String name = 'User';
  String address = 'Ago Palace Way surulere Lagos';
  String img;
  String uid;

  List<Users> usersLists = [];

  SizeConfig size = SizeConfig();

  @override
  void initState() {
    getUser();
    UserNotifier userNotifier =
        Provider.of<UserNotifier>(context, listen: false);
    getUsersData(userNotifier);
    super.initState();
  }

  Future<void> getUser() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        email = user.email;
        name = user.displayName;
        uid = user.uid;
        print(uid);
        // img = user.photoUrl;
      });
    });
  }

  TextEditingController _name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var darktheme;

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    darktheme = Provider.of<ThemeNotifier>(context).isDarkModeOn ?? false;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.bottomSheet(
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              height: SizeConfig().yMargin(context, 30),
              child: Wrap(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig().yMargin(context, 4)),
                      child: Text(
                        'Change Display Name',
                        style: GoogleFonts.aBeeZee(
                            color: darktheme ? Colors.white : Colors.black,
                            fontSize: SizeConfig().textSize(context, 3),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: SizeConfig().yMargin(context, 8),
                  // ),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 18),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: TextFormField(
                            controller: _name,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: name),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                          onPressed: () async {
                            bool connected =
                                await DataConnectionChecker().hasConnection;
                            print(connected);
                            if (connected) {
                              final form = formKey.currentState;
                              print(_name.text);
                              if (_name.text.length > 0) {
                                form.save();
                                updateProfile(uid, _name.text).then((value) {
                                  Get.snackbar('Success',
                                      'Display name changed successfully',
                                      backgroundColor: Colors.green);
                                  Future.delayed(Duration(seconds: 2))
                                      .then((value) => Get.to(Profile()));
                                });
                              }
                              Get.snackbar(
                                  'Error', 'You can\'t submit an empty form',
                                  backgroundColor: Colors.red);
                            } else {
                              Get.snackbar('Network Error',
                                  'Could not be processed due to poor network',
                                  backgroundColor: Colors.red);
                            }
                          },
                          child: Text(
                            'Update',
                            style: GoogleFonts.aBeeZee(
                                color: darktheme ? Colors.white : Colors.black,
                                fontSize: SizeConfig().textSize(context, 2),
                                fontWeight: FontWeight.bold),
                          )))
                ],
              ),
            ),
            elevation: 10,
            backgroundColor: darktheme ? Color(0xff0D141A) : Colors.white),
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        foregroundColor: kPrimaryColor,
      ),
      body: userNotifier.userProfileData.isNotEmpty
          ? ListView.builder(
              itemCount: userNotifier.userProfileData.length,
              itemBuilder: (context, index) {
                var _data = userNotifier.userProfileData[index];
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: darktheme ? Color(0xff0D141A) : Color(0xffFAFAFA),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Get.off(HomePage(
                                  justLoggedIn: false,
                                ));
                              }),
                          Center(
                            child: Text(
                              'Profile',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: darktheme
                                      ? Colors.white70
                                      : Colors.black),
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
                                        'assets/images/images.jpg',
                                      )),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: kGrey,
                                      width: 2,
                                      style: BorderStyle.solid),
                                ),
                                child: _data.photoUrl == null
                                    ? SizedBox()
                                    : Image.network(_data.photoUrl)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Text(
                          _data.name,
                          style: TextStyle(fontSize: 24, color: kBlack),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: Text(
                          "",
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
                                  _data.name,
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
                                  _data.email,
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
                );
              })
          : Center(child: CircularProgressIndicator()),
    );
  }
}
