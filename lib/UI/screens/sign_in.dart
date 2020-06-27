import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/UI/screens/sign_up.dart';
import 'package:team_mobileforce_gong/services/auth/util.dart';
import 'package:team_mobileforce_gong/services/auth/validator.dart';
import 'package:team_mobileforce_gong/services/snackbarService.dart';
import 'package:team_mobileforce_gong/state/authProvider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void _toSignup() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  Widget _logo(BuildContext context) {
    return new Container(
        padding: EdgeInsets.all(50),
        child: Image(image: AssetImage('assets/images/Gong (3).png')));
  }

  Widget _signInText(BuildContext context) {
    return new Container(
        alignment: Alignment.centerLeft,
        child: Text("Sign In",
            style: TextStyle(fontSize: 30.0, fontFamily: "Gilroy")));
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
                  hintStyle: TextStyle(fontFamily: "Gilroy"),
                  labelText: title,
                  labelStyle:
                      TextStyle(color: Colors.blue, fontFamily: "Gilroy")))
        ],
      ),
    );
  }

  Widget _resetAccountLabel() {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Forgot your password? Reset it ',
                style: TextStyle(fontFamily: "Gilroy")),
            new GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "ResetPag");
                },
                child: new Text("here",
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: "Gilroy",
                        decoration: TextDecoration.underline))),
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return Builder(builder: (BuildContext _context) {
      SnackBarService.instance.buildContext = _context;
      return Container(
          padding: EdgeInsets.only(top: 20),
          child: new Column(
            children: <Widget>[
              new Container(
                width: 180.0,
                height: 50.0,
                child: new RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: new Text('LOG IN',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.bold)),
                  color: Colors.blue,
                  onPressed: () {
                    final form = _formKey.currentState;
                    form.save();
                    if (form.validate()) {
                      try {
                        Provider.of<AuthenticationState>(context, listen: false)
                            .login(
                                _emailController.text, _passwordController.text)
                            .then((signInUser) => gotoHomeScreen(context));
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                ),
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
              new Text('Don\'t have an account? ',
                  style: TextStyle(fontFamily: "Gilroy")),
              Container(
                  child: GestureDetector(
                      onTap: () {
                        _toSignup();
                      },
                      child: new Text('Sign Up',
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: "Gilroy",
                              decoration: TextDecoration.underline))))
            ]),
            SizedBox(height: 20),
            Text(
              'Continue as free user.',
              style: TextStyle(color: Colors.blue, fontFamily: "Gilroy"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email Address", "example@user.com", _emailController,
            EmailValidator.validate),
        _entryField("Password", "password", _passwordController,
            PasswordValidator.validate,
            isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                    SizedBox(height: 30),
                    _logo(context),
//                    SizedBox(height: height * .2),
                    _signInText(context),
                    SizedBox(height: 20),
                    _emailPasswordWidget(),
                    SizedBox(height: 20),
                    _resetAccountLabel(),
                    _submitButton(),
                    SizedBox(height: 50),
                    _freeUserAccountLabel()
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
