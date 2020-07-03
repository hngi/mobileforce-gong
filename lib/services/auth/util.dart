
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/UI/screens/home_page.dart';
import 'package:team_mobileforce_gong/UI/screens/sign_in.dart';
import 'package:team_mobileforce_gong/services/navigation/app_navigation/navigation.dart';
import 'package:team_mobileforce_gong/state/authProvider.dart';


void gotoHomeScreen(BuildContext context) {
    
  //  print(user['kUID']);
  Future.microtask((){
    // var user = Provider.of<AuthenticationState>(context, listen: false).exposeUser();
    if (Provider.of<AuthenticationState>(context, listen: false).authStatus ==
      kAuthSuccess){
        // var user = Provider.of<AuthenticationState>(context, listen: false).exposeUser();
        Navigator.push(context, 
              MaterialPageRoute(builder: (context) => HomePage()));
      }
  });
}


void gotoLoginScreen(BuildContext context) {
  Future.microtask((){
    if (Provider.of<AuthenticationState>(context, listen: false).authStatus ==
      null){
        Navigation().pushToAndReplace(context, LoginPage());
        // Navigator.push(context, 
        //       MaterialPageRoute(builder: (context) => LoginPage()));
      }
  });
}


// gotoProfileScreen(BuildContext context) async {
//   await Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
// }