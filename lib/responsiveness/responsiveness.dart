import 'package:flutter/material.dart';

///Custom class for scaling text sizes, margins and everything that needs to be responsive across different screens
class SizeConfig{

  double yMargin(BuildContext context, double height){
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if(isPortrait) {
      double screenHeight =  MediaQuery.of(context).size.height/ 100;
      return height * screenHeight;
    } else {
      double screenHeight =  MediaQuery.of(context).size.width/ 100;
      return height * screenHeight;
    }
  }
  double xMargin(BuildContext context, double width){
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if(isPortrait) {
      double screenHeight =  MediaQuery.of(context).size.width/ 100;
      return width * screenHeight;
    } else {
      double screenHeight =  MediaQuery.of(context).size.height/ 100;
      return width * screenHeight;
    }
  }

  double textSize(BuildContext context, double textSize){
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if(isPortrait) {
      double screenHeight =  MediaQuery.of(context).size.height/ 100;
      return textSize * screenHeight;
    } else {
      double screenHeight =  MediaQuery.of(context).size.width/ 100;
      return textSize * screenHeight;
    }
  }

}