import 'package:flutter/cupertino.dart';
import '../auth/model.dart';

class UserNotifier with ChangeNotifier{
  List<Users> _userProfileData = [];

  Users _currentUser;

  List<Users> get userProfileData => _userProfileData;

  Users get currentUser => _currentUser;

  set userProfileData(List<Users> userProfileData) {
    _userProfileData = userProfileData;
    notifyListeners();
  }

  set currentUser(Users user){
    _currentUser = user;
    notifyListeners();
  }
}