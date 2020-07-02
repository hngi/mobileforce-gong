import 'package:flutter/material.dart';

import 'package:team_mobileforce_gong/UI/screens/home_page.dart';
import 'package:team_mobileforce_gong/UI/screens/sign_in.dart';
import 'package:team_mobileforce_gong/services/navigation/app_navigation/navigation.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/util/const/constFile.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  SizeConfig size = SizeConfig();
  PageController _pageController = PageController();

  void _bottomTapped(int page) {
    if (page > 2) {
      Navigation().pushToAndReplace(context, LoginPage());
    }
    _pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
        color: Colors.white,
        child: Stack(children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            controller: _pageController,
            children: [
              onboard(
                  'assets/images/notes 1.png',
                  'Normal Notes But \nDigital & Better',
                  'Quickly off load ideas, thoughts\nwithout losing any information at all\nall on the app', orientation),
              onboard(
                  'assets/images/shopping-list 1.png',
                  'save all Task\nDaily',
                  'Outline all your daily task and check\nthem on accomplishment', orientation),
              onboard(
                  'assets/images/quotes 1.png',
                  'Read Inspirational \nQuotes daily',
                  'Outline all your daily task and check \nthem on accomplishment', orientation),
            ],
          ),
          orientation == Orientation.portrait ? Padding(
            padding:
                EdgeInsets.only(bottom: size.yMargin(context, 12)),
                
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Indicator(
                      positionIndex: 1,
                      currentIndex: currentIndex,
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Indicator(
                      positionIndex: 2,
                      currentIndex: currentIndex,
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Indicator(
                      positionIndex: 3,
                      currentIndex: currentIndex,
                    ),
                  ],
                )),
          ) : Container(),
          Positioned(
              bottom: 30,
              child: FlatButton(
                onPressed: () {

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()));

                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: kBlack,
                    fontSize: 16,
                    fontFamily: 'Gilroy',
                  ),
                ),
              )),
          Positioned(
            bottom: 30,
            right: 0,
            child: FlatButton(
              onPressed: () => _bottomTapped(currentIndex + 1),
              child: Text(
                'Next',
                style: TextStyle(
                  color: kBlack,
                  fontSize: 16,
                  fontFamily: 'Gilroy',
                ),
              ),
            ),
          ),
        ]));
  }

  Widget onboard(String imgPath, String title, String desctext, Orientation orientation) {
    return orientation == Orientation.portrait ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imgPath,
          width: 120,
        ),
        SizedBox(
          height: size.yMargin(context, 4),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              decoration: TextDecoration.none,
              fontFamily: 'Gilroy',
              fontSize: size.textSize(context, 4),
              color: kPrimaryColor),
        ),
        SizedBox(
          height: size.yMargin(context, 7),
        ),
        Text(
          desctext,
          textAlign: TextAlign.center,
          style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: size.textSize(context, 2),
              fontWeight: FontWeight.w500,
              fontFamily: 'Gilroy',
              color: kBlack),
        )
      ],
    ): SingleChildScrollView(
      child: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imgPath,
            width: 120,
          ),
          SizedBox(
            height: size.yMargin(context, 4),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: 'Gilroy',
                fontSize: size.textSize(context, 4.5),
                color: kPrimaryColor),
          ),
          SizedBox(
            height: size.yMargin(context, 7),
          ),
          Text(
            desctext,
            textAlign: TextAlign.center,
            style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: size.textSize(context, 2),
                fontWeight: FontWeight.w500,
                fontFamily: 'Gilroy',
                color: kBlack),
          )
        ],
    ),
      ),
    );
  }

//  static const duration = Duration(seconds: 1);
//  static const curve = Curves.easeIn;
}

class Indicator extends StatelessWidget {
  final int positionIndex;
  final int currentIndex;

  const Indicator({Key key, this.positionIndex, this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
          color: positionIndex == currentIndex + 1
              ? kPrimaryColor
              : kGrey.withOpacity(0.5),
          shape: BoxShape.circle),
    );
  }
}
