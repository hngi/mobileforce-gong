import 'package:flutter/cupertino.dart';
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
  // Text controllers to retrieve the current value
  // of the TextFields.
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final sizeConfig = SizeConfig();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 125.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: EdgeInsets.only(left: sizeConfig.xMargin(context, 10), bottom: sizeConfig.yMargin(context, 2.5),),
                title: Text('Edit Profile',
                style: TextStyle(color: Colors.white, fontSize: 14),),
              ),
          ),
            SliverList(
            delegate: SliverChildListDelegate(
                [
                  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _userImage(),
                    Container(
                      margin: EdgeInsets.only(bottom: sizeConfig.yMargin(context, 2.5)),
                      child: Text('John Doe',
                        style: TextStyle(letterSpacing: 0.07 ,fontWeight: FontWeight.bold, fontSize: sizeConfig.textSize(context, 4.8), fontFamily: 'Gilroy',),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Divider(
                      color: Colors.blue,
                      thickness: 1.5,
                    ),
                    Container(
                      margin: EdgeInsets.all(sizeConfig.yMargin(context, 2.5)),
                      child: Column(
                        children: <Widget>[
                          _editTextField(fieldHintText: 'First Name', fieldController: firstNameController),
                          _editTextField(fieldHintText: 'Last Name', fieldController: lastNameController, yMarginTop: 2.5),
                          _editTextField(fieldHintText: 'Email', fieldController: emailController, yMarginTop: 2.5),
                          _editTextField(fieldHintText: 'Password', fieldController: passwordController, yMarginTop: 2.5,
                              yMarginBottom: 2.5), // Append 'isObscured: true' to hide password text
                        ],
                      ),
                    ),
                   _submitButton(context),
                    _resetPasswordText(),
                  ],
                )
                ]
            ),
          ),

        ],

      ),
    );
  }

  Widget _userImage() {
    return Container(
      width: sizeConfig.xMargin(context, 29), //exactly 104 as the design
      height: sizeConfig.yMargin(context, 13.3), //exactly 104 as the design
      margin: EdgeInsets.only(top: sizeConfig.yMargin(context, 3.3), bottom: sizeConfig.yMargin(context, 1.0)),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          //image: NetworkImage('http://url-to-user-imae'), //Use this for network fetched image
          //For local image assets
          image: AssetImage('assets/images/stock-photo.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _resetPasswordText() {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())); //TODO: please refactor this to PasswordReset
      },
      child: Container(
          margin: EdgeInsets.only(top: sizeConfig.yMargin(context, 3.3), bottom: sizeConfig.yMargin(context, 3.0)),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Reset password',
              style: TextStyle(fontFamily: 'Gilroy', color: Colors.blue, fontSize: sizeConfig.textSize(context, 4.5)))
      ),
    );
  }

  Widget _editTextField({String fieldHintText, TextEditingController fieldController,
      double yMarginTop = 0.0, double yMarginBottom = 0.0, bool isObscured = false}) {
    return Container(
    margin: EdgeInsets.only(top: sizeConfig.yMargin(context, yMarginTop), bottom: sizeConfig.yMargin(context, yMarginBottom)),
      child: TextField(
        obscureText: isObscured,
        controller: fieldController,
        decoration: InputDecoration(
          hintText: fieldHintText,
          hintStyle: TextStyle(fontFamily: 'Gilroy'),
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return Builder(
      builder: (context) => Container(
        child: Center(
          child: RaisedButton(
            onPressed: () {
              extractUserInputData(context, firstNameController.text, lastNameController.text,
                  emailController.text, passwordController.text);
            },
            color: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: sizeConfig.yMargin(context, 2.3), horizontal: sizeConfig.xMargin(context, 17)),
            child: Text('Submit'.toUpperCase(), style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  /// Extracts text fields data. Some field(s) can be left blank, meaning the user
  /// wants to keep the original info.
  ///
  /// Returns GongUser object if requirements are satisfied, NULL otherwise.
  ///
  /// Input fields can be left blank, however,
  /// an incomplete or invalid [emailAddress] is NOT accepted. The user must correct it or
  /// leave it blank.
  GongUser extractUserInputData(BuildContext context, String firstName, String lastName, String emailAddress, String password) {
    GongUser userData = GongUser();
    //if all inputs are empty, return null
    if(firstName.isEmpty && lastName.isEmpty && emailAddress.isEmpty && password.isEmpty) {
      _showToast(context, 'Nothing to do. All fields empty.');
      return null;
    }
    if(firstName.isNotEmpty) {
      userData.setFirstName(firstName.trim());
    }
    if(lastName.isNotEmpty) {
      userData.setLastName(lastName.trim());
    }
    if(emailAddress.isNotEmpty) {
      String invalidEmailMsg = 'Invalid email,  make sure your email is correct.';
      String _result = _validateEmailInput(emailAddress);
      if(_result.contains('INVALID')){
        _showToast(context, invalidEmailMsg);
        return null;
      } else {
        userData.setEmail(_result);
      }
    }
    if(password.isNotEmpty || password != null) {
      userData.setPassword(password);
    }

    return userData;
  }

  ///This is a duplicate funtion and needs to be refactored. Original function
  /// exists in password_reset.dart.
  String _validateEmailInput(String emailText) {
    final regex = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

//    'Email address is required'
//    'Email sent to ' + emailText : 'Invalid email,  make sure your email is correct.';
    if(emailText.isNotEmpty) {
      return regex.hasMatch(emailText)? emailText : 'INVALID';
    } return '';
  }

  ///Also duplicate funtion and needs to be refactored. Original function
  /// exists in password_reset.dart.
  void _showToast(BuildContext context, String errorMsg) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(errorMsg),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

}


///Helper class for debugging purposes.
class GongUser {
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';

  String getFirstName() => _firstName;
  String getLastName() =>  _lastName;
  String getEmail() =>  _email;
  String getPassword() =>  _password;

  //For debugging purposes
  String toString() => 'Fname: ' + _firstName + ' Lname: ' + _lastName +
      ' email: ' + _email + ' password: ' + _password;

  void setFirstName(String newValue) => this._firstName = newValue;
  void setLastName(String newValue) => this._lastName = newValue;
  void setEmail(String newValue) => this._email = newValue;
  void setPassword(String newValue) => this._password = newValue;

}
