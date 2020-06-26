import 'dart:async';

import 'package:flutter/material.dart';
import 'package:team_mobileforce_gong/UI/onboarding.dart';
import 'package:team_mobileforce_gong/navigation/app_navigation/navigation.dart';
import 'package:team_mobileforce_gong/responsiveness/responsiveness.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Navigation navigation = Navigation();
  SizeConfig config = SizeConfig();

  @override
  void initState() {
    Timer(Duration(seconds: 4), () {
      navigation.pushTo(context, Onboarding());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: Container(
          // color: Colors.red,
          height: config.yMargin(context, 60),
          width: config.xMargin(context, 300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/Gong (3).png')),
              // SizedBox(height: config.yMargin(context, 60),),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  '"Seize The Day!"',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    color: Color(0xff0984E3),
                    fontSize: config.textSize(context, 6),
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
