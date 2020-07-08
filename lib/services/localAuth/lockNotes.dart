import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth extends ChangeNotifier {
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  List<BiometricType> _availableBiometrics;
  String _successful = 'Not Successful';
  bool _isChecking = false;

  bool get canCheckBiometrics => _canCheckBiometrics;
  List<BiometricType> get availableBiometrics => _availableBiometrics;
  String get successful => _successful;
  bool get isChecking => _isChecking;

  Future<void> checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    _canCheckBiometrics = canCheckBiometrics;
    notifyListeners();
  }

  Future<void> getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    _availableBiometrics = availableBiometrics;
    notifyListeners();
  }

  Future<void> authenticate() async {
    bool authenticated = false;
    try {
      _isChecking = true;
      _successful = 'Authenticating';
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true);

      _isChecking = false;
      _successful = 'Authenticating';
    } on PlatformException catch (e) {
      print(e);
    }

    final String message = authenticated ? 'Successful' : 'Not Successful';

    _successful = message;
    notifyListeners();
  }

  void cancelAuth() {
    _successful = 'Not Successful';
    _isChecking = false;
    notifyListeners();
  }
}
