//this is the file for the custom splash screen.

import 'dart:async';
import 'package:flutter/material.dart';
import 'home.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
    }
  
  class _SplashScreenState extends State<SplashScreen> {
  @override
    void initState(){
    super.initState();
    Timer(
      Duration(seconds:7),
      () => Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => HomeScreen()
      )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/gongT.PNG',
          scale: 1,
          colorBlendMode: BlendMode.lighten
          )
          //Text('"Seize the day!"')
        ),         
      );
    
  }
}
  

