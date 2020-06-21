import 'package:flutter/material.dart';
import 'package:team_mobileforce_gong/UI/screens/home_page.dart';
import 'package:team_mobileforce_gong/const/constFile.dart';
import 'package:team_mobileforce_gong/responsiveness/responsiveness.dart';

import 'home.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  SizeConfig size = SizeConfig();
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Stack(children: [
          PageView(
            onPageChanged: (index){
              setState(() {
                currentIndex=index;
              });
            },
            controller: _pageController,
            children: [
              onboard(
                  'assets/images/notes 1.png',
                  'Normal Notes But \nDigital & Better',
                  'Quickly off load ideas, thoughts\nwithout losing any information at all\nall on the app'),
              onboard(
                  'assets/images/shopping-list 1.png',
                  'save all Task\nDaily',
                  'Outline all your daily task and check\nthem on accomplishment'),
              onboard(
                  'assets/images/quotes 1.png',
                  'Read Inspirational \nQuotes daily',
                  'Outline all your daily task and check \nthem on accomplishment'),
            ],
          ),
          Positioned(
              bottom: size.yMargin(context, 24),
              left: size.xMargin(context, 100 / 2.5),
              child: Row(
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
          Positioned(
              bottom: 30,
              child: FlatButton(
                onPressed: () {
                  _pageController.nextPage(duration: duration, curve: curve);
                },
                child: Text(
                  'Next',
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
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Text(
                'Skip',
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

  Widget onboard(String imgPath, String title, String desctext) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imgPath,
          width: 120,
        ),
        SizedBox(
          height: 36,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              decoration: TextDecoration.none,
              fontFamily: 'Gilroy',
              fontSize: size.textSize(context, 6),
              color: kPrimaryColor),
        ),
        SizedBox(
          height: 36,
        ),
        Text(
          desctext,
          textAlign: TextAlign.center,
          style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Gilroy',
              color: kBlack),
        )
      ],
    );
  }

  static const duration = Duration(seconds: 1);
  static const curve = Curves.easeIn;
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
          color: positionIndex == currentIndex+1
              ? kPrimaryColor
              : kGrey.withOpacity(0.5),
          shape: BoxShape.circle),
    );
  }
}
