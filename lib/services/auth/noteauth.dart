//This class allows users to add their biometrics data inorder to be authenticated
//Use it to privatize a note
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';


class LocalAuthState  {
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  bool mounted ;
  List<BiometricType> _availableBiometrics;
  bool _isAuthenticating = false;

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {    
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true);
 
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }

}

//trial