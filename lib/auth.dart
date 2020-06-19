
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider{
  static final FirebaseAuth auth = FirebaseAuth.instance;
  //Firebase SignUp with email and password
  registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
    } catch (error) {
      print(error.toString());
    }
  }
  //Firebase Sign In with email and Password
  signInWithEmail(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      print(error.toString());
      
    }
  }


}