import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:team_mobileforce_gong/UI/screens/home_page.dart';
import 'package:team_mobileforce_gong/UI/screens/onboarding.dart';
import 'package:team_mobileforce_gong/services/navigation/app_navigation/navigation.dart';
import 'package:team_mobileforce_gong/services/navigation/page_transitions/animations.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/state/authProvider.dart';

import 'home_wrapper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Navigation navigation = Navigation();
  SizeConfig config = SizeConfig();

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Provider.of<AuthenticationState>(context, listen: false)
          .currentUser()
          .then((currentUser) => {
                if (currentUser == null)
                  {navigation.pushToAndReplace(context, Onboarding())}
                else
                  {navigation.pushToAndReplace(context, HomeWrapper())}
              })
          .catchError((e) => print(e));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 300, bottom: 30),
            child: Container(
              // color: Colors.red,
              height: config.yMargin(context, 55),
              width: config.xMargin(context, 300),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                      alignment: Alignment.center,
                      child: LogoAnimation(
                          milliseconds: 270,
                          child: Image.asset('assets/images/Gong (3).png'))),
                  // SizedBox(height: config.yMargin(context, 60),),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      '"Seize The Day!"',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        color: Color(0xff0984E3),
                        fontSize: config.textSize(context, 3),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
