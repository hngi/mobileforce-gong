
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:team_mobileforce_gong/services/auth/auth.dart';

const String kAuthError = 'error';
const String kAuthSuccess = 'success';
const String kAuthLoading = 'loading';
const String kAuthSignIn = 'signIn';
const String kUsername = 'Username';
const String kUID = 'uid';


class AuthenticationState with ChangeNotifier {
  String _authStatus;
  String _username;
  String _uid;
  String _email;
  String _password;
  String _error;
  QuerySnapshot _userData;

  String get authStatus => _authStatus;
  String get username => _username;
  String get uid => _uid;
  String get email => _email;
  String get password => _password;
  String get error => _error;

  AuthenticationState() {
    clearState();

    onAuthenticationChange((user) {
      if (user != null) {
        _authStatus = kAuthSuccess;
        _username = user[kUsername];
        _uid = user[kUID];
        //print(user);
        _email = user[email];
      } else {
        clearState();
      }
      notifyListeners();
    });
  }


  void clearState() {
    _authStatus = null;
    _username = null;
    _uid = null;
    _email = null;
  }

  Future signup(email, password, username) async {
    return await signUp(email, password, username,);
  }


  Future googleSignin() async {
    return signInWithGoogle();
  }

 Future login(
    email,
    password,
  ) async {
    try {
     await signIn(
        email,
        password,
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  // void loginTest(email, password){
  //   signInWithEmail(email, password);
  // }

  Future<void> logout() async {
    clearState();
    await signOut();
    notifyListeners();
  }

  currentUser() {
    // notifyListeners();
    return getUser();
  }

  currentUserId() {
    // notifyListeners();
    return getUserId();
  }

  Future<void> forgotPassword(email) async {
   return sendPasswordResetEmail(email);
  }

}
