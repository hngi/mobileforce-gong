import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/UI/screens/home_page.dart';
import 'package:team_mobileforce_gong/UI/screens/sign_in.dart';
import 'package:team_mobileforce_gong/services/auth/auth.dart';
import 'package:team_mobileforce_gong/services/auth/util.dart';
import 'package:team_mobileforce_gong/services/auth/validator.dart';
import 'package:team_mobileforce_gong/services/navigation/app_navigation/navigation.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/services/snackbarService.dart';
import 'package:team_mobileforce_gong/state/authProvider.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  AuthStatus status;

  SizeConfig config = SizeConfig();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isloading = false;
  void _toLogin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Widget _logo(BuildContext context) {
    return new Container(
        // color: Colors.red,felix
        padding: EdgeInsets.all(config.yMargin(context, 6)),
        child: Image(image: AssetImage('assets/images/Gong (3).png')));
  }

  Widget _signInText(BuildContext context) {
    return new Container(
        alignment: Alignment.centerLeft,
        child: Text("Sign Up",
            style: TextStyle(
                fontSize: config.textSize(context, 4.3),
                fontFamily: "Gilroy")));
  }

  Widget _entryField(String title, String hint,
      TextEditingController controller, Function(String) validate,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
              validator: validate,
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                  hintText: hint,
                  labelText: title,
                  labelStyle:
                      TextStyle(color: Colors.blue, fontFamily: "Gilroy")))
        ],
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _entryField("Full Name", "your name", _usernameController,
                UsernameValidator.validate),
            _entryField("Email Address", "example@user.com", _emailController,
                EmailValidator.validate),
            _entryField("Password", "password", _passwordController,
                PasswordValidator.validate,
                isPassword: true),
          ],
        ),
      ),
    );
  }

  Widget _showCircularProgress() {
    if (_isloading) {
      return Center(child: CircularProgressIndicator(strokeWidth: 1.5,
        backgroundColor: Colors.white,
      ));
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget _submitButton() {
    return Builder(builder: (BuildContext _context) {
      SnackBarService.instance.buildContext = _context;
      return Container(
          padding: EdgeInsets.only(top: 20),
          child: new Column(
            children: <Widget>[
              Consumer<AuthenticationState>(
                builder: (_context, state, child) {
                  return Container(
                    width: 180.0,
                    height: 50.0,
                    child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('SiGN  UP',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Gilroy",
                                        fontWeight: FontWeight.bold)),
                                SizedBox(width: 10.0),
                                _showCircularProgress(),

                              ],
                            ),
                            color: Colors.blue,
                            onPressed: () {
                              final form = _formKey.currentState;
                              form.save();
                              if (form.validate()) {
                                setState(() {
                                  _isloading = true;
                                });
                                try {
                                  state
                                      .signup(
                                          _emailController.text,
                                          _passwordController.text,
                                          _usernameController.text)
                                      .then((signInUser){
                                        if(signInUser == null){
                                          setState(() {
                                            _isloading = false;
                                          });
                                        }
                                          gotoHomeScreen(_context);});
                                  // gotoHomeScreen(context);
                                  // print('signed up');
                                  // Navigator.push(context,
                                  //   MaterialPageRoute(builder: (context) => Feedss()));
                                } catch (e) {
                                  print(e);
                                }
                              }
                            },
                          ),
                  );
                },
              ),
            ],
          ));
    });
  }

  Widget _freeUserAccountLabel() {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Column(
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              new Text('Already have an account? ',
                  style: TextStyle(fontFamily: "Gilroy")),
              Container(
                  child: GestureDetector(
                      onTap: () {
                        _toLogin();
                      },
                      child: new Text('Sign In',
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: "Gilroy",
                              decoration: TextDecoration.underline))))
            ]),
            // SizedBox(height: config.yMargin(context, 2)),
            // GestureDetector(
            //   onTap: (){
            //     Navigation().pushToAndReplace(context, HomePage());
            //   },
            //               child: Text(
            //     'Continue as free user.',
            //     style: TextStyle(fontFamily: "Gilroy", color: Colors.blue),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AuthenticationState>(context);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: config.yMargin(context, 5)),
                    _logo(context),
//                    SizedBox(height: height * .2),
                    _signInText(context),
                    SizedBox(height: config.yMargin(context, 3)),
                    _emailPasswordWidget(),
                    SizedBox(height: config.yMargin(context, 3)),
                    _submitButton(),
                    SizedBox(height: config.yMargin(context, 2)),
                    _freeUserAccountLabel(),
                    SignInButton(
                      Buttons.Google,
                      onPressed: () {
                        state
                            .googleSignin()
                            .then((value) => gotoHomeScreen(context));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void signupPressed() {
  print('The user wants to login with email and password');
}

class BezierContainer extends StatelessWidget {
  const BezierContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Transform.rotate(
      angle: -3.14 / 3.5,
      child: ClipPath(
        clipper: ClipPainter(),
        child: Container(
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    ));
  }
}

class ClipPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;
    var path = new Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, height);
    path.lineTo(size.width, 0);

    /// [Top Left corner]
    var secondControlPoint = Offset(0, 0);
    var secondEndPoint = Offset(width * .2, height * .3);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    /// [Left Middle]
    var fifthControlPoint = Offset(width * .3, height * .5);
    var fiftEndPoint = Offset(width * .23, height * .6);
    path.quadraticBezierTo(fifthControlPoint.dx, fifthControlPoint.dy,
        fiftEndPoint.dx, fiftEndPoint.dy);

    /// [Bottom Left corner]
    var thirdControlPoint = Offset(0, height);
    var thirdEndPoint = Offset(width, height);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
