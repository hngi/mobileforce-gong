import 'dart:io';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/state/theme_notifier.dart';
import 'package:team_mobileforce_gong/util/const/constFile.dart';
import 'package:team_mobileforce_gong/models/CustomPopUpMenu.dart';



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
    uploadFile();
  }

  String phoneNumber = "+2348066701121";
  String email = 'user@user.com';
  String name = 'User';
  String img;
  bool isEnabled = false;
  FocusNode myFocusNode;

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();


  SizeConfig size = SizeConfig();

  @override
  void initState() {
    getUser();
    super.initState();
    myFocusNode = new FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();

    super.dispose();
  }

  Future<void> getUser() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        email = user.email;
        name = user.displayName;
        img = user.photoUrl;

        print(name);
        // img = user.photoUrl;
      });
    });
    print(name);
    print("img is $img");
  }

  var darktheme;
  Icon _fabIcon = new Icon(Icons.edit,color: Colors.white,);


Widget _editText(){
  return  TextField(
    onSubmitted:(value){
      updateDetails();
    },
    autofocus: true,
    enabled: isEnabled,
    controller: nameController,
    decoration: InputDecoration(hintText: name),
    style: TextStyle(fontSize: 18, color: Colors.black38),
  );
}



  @override
  Widget build(BuildContext context) {
    darktheme = Provider.of<ThemeNotifier>(context).isDarkModeOn ?? false;
    return WillPopScope(child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(this._fabIcon.icon == Icons.edit){
            setState(() {
              this._fabIcon = Icon(Icons.check);
              isEnabled = true;
              myFocusNode.requestFocus();
            });
          } else{
            updateDetails();
            setState(() {
              this._fabIcon = Icon(Icons.edit);
              isEnabled = false;
            });

          }
        },
        child:_fabIcon,
      ),
      body: SafeArea(
        child: Container(
          color: darktheme ? Color(0xff0D141A) : Color(0xffFAFAFA),
          child: ListView(
            children: [
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context,true);
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
                            image:img == null ? AssetImage(
                              'assets/images/images.jpg',
                            ): NetworkImage(img)),
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
                  "",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: kGrey),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                width: size.xMargin(context, 100),
                /*    height: size.yMargin(context, 100),*/
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
                  SizedBox(height: 8,),
                      _editText(),
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
                      Text(email,
                        style: TextStyle(fontSize: 18, color: Colors.black38),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
        onWillPop: _onWillPop);

  }

  Future<bool> _onWillPop() async {
    Navigator.pop(context,true);
  }

  Future uploadFile() async {
    String _uploadedImageUrl = "";
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('users/');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    UserUpdateInfo userUpdateInfo =  UserUpdateInfo();
    storageReference.getDownloadURL().then((fileURL) {
      _uploadedImageUrl = fileURL;
        userUpdateInfo.photoUrl = _uploadedImageUrl;
        user.updateProfile(userUpdateInfo);
        print("Image URl $_uploadedImageUrl");
    });

    user.reload();
    FirebaseUser newUser = await FirebaseAuth.instance.currentUser();
    print(newUser.photoUrl + 'this');

  }

  void updateDetails() async {
    if(nameController.text.isNotEmpty){
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = nameController.text;
      name = nameController.text;
      print("username is ${nameController.text}");
      user.updateProfile(userUpdateInfo);
      user.reload();
      print("username is ${user.displayName}");
    }

  }




}