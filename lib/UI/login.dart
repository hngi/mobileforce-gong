import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Simple Login Demo',
      theme: new ThemeData(
          primarySwatch: Colors.blue
      ),
      home: new LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

// Used for controlling whether the user is loggin or creating an account
//enum FormType {
//  login,
//  signUp,
//  resetPass
//}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  String _email = "";
  String _password = "";
//  FormType _form = FormType.login; // our default setting is to login, and we should switch to creating an account when the user chooses to

  _LoginPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  void _toLogin() async {
    setState(() {
//      _form = FormType.login;
    });
  }

  void _toSignup(){
    setState(() {
//      _form = FormType.signUp;
    });
  }

  void _toReset(){
    setState(() {
//      _form = FormType.resetPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      appBar: _buildBar(context),
      body: new Container(

        padding: EdgeInsets.only(top: 40),
        child: new Column(
          children: <Widget>[
            _logo(context),
            _signInText(context),
            _buildTextFields(),
            _forgotPass(),
            _loginButton(),
            _signUp(),
            _freeUser()
          ],
        ),
      ),
    );
  }


  Widget _logo(BuildContext context) {

    return Image(image: AssetImage('assets/logo.png'));

  }

  Widget _signInText(BuildContext context) {
    return new Container(
        padding: EdgeInsets.only(top: 20, bottom:20),
        child: new Column(children: <Widget>[
          Text("Sign In", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w200), textAlign: TextAlign.left)]));
  }

  Widget _buildTextFields() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: new TextField(
              controller: _emailFilter,
              decoration: new InputDecoration(
                  hintText: 'email@user.com',
                  labelText: 'Email Address',
                  labelStyle: TextStyle(color: Colors.blue)
              ),
            ),
          ),
          new Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: new TextField(
              controller: _passwordFilter,
              decoration: new InputDecoration(
                  hintText: 'password',
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.blue)
              ),
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _forgotPass() {
      return new Container(
        padding: EdgeInsets.only(left: 40, top: 20),
        child: new Row(
          children: <Widget>[
            new Text('Forgot Password? Reset it'),
            new FlatButton(
                padding: EdgeInsets.only(right: 40),
              child: new Text('here', style: TextStyle(color: Colors.blue)), onPressed: _toReset
            ),
          ],
        ),
      );
  }

  Widget _loginButton() {
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('LOG IN', style: TextStyle(color: Colors.white)), color: Colors.blue, onPressed: _toLogin
            )
          ],
        ),
      );
  }

  Widget _signUp() {
      return new Container(
        padding: EdgeInsets.only(left: 40, top: 70),
        child: new Row(
          children: <Widget>[
            new Text('Don\'t have an account?'),
            new FlatButton(
                padding: EdgeInsets.only(right: 30),
                child: new Text('Sign Up', style: TextStyle(color: Colors.blue)), onPressed: _toSignup)
          ],
        ),
      );
  }

  Widget _freeUser() {
      return new Container(
        child: new Column(
          children: <Widget>[
            new FlatButton(
                child: new Text('Continue as free user.', style: TextStyle(color: Colors.blue)))
          ],
        ),
      );
  }

  // These functions can self contain any user auth logic required, they all have access to _email and _password

  void _loginPressed () {
    print('The user wants to login with $_email and $_password');
  }

  void _createAccountPressed () {
    print('The user wants to create an accoutn with $_email and $_password');

  }

  void _passwordReset () {
    print("The user wants a password reset request sent to $_email");
  }


}