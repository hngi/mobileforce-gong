import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:team_mobileforce_gong/UI/home.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const snackBarDuration = Duration(seconds: 3);

  final snackBar = SnackBar(
    backgroundColor: Colors.green,
    content: Text('Press back again to exit'),
    duration: snackBarDuration,
  );

  final scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime backButtonPressTime;
  PageController _pageController;
  int _page = 0;

  String uid;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  void _onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void _bottomTapped(int page) {
    _pageController.jumpToPage(page);
  }

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            currentTime.difference(backButtonPressTime) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = currentTime;
      scaffoldKey.currentState.showSnackBar(snackBar);
      return false;
    }
    SystemNavigator.pop();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // endDrawer: HomeDrawer(),
        key: scaffoldKey,
        // backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: onWillPop,
          child: PageView(
            // physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: <Widget>[
              Container(child: Home()),
              Container(child: Center(child: Text('something here'))),
              Container(child: Center(child: Text('something here'))),
              Container(child: Center(child: Text('something here'))),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Color(0xff0984E3),
          // color: Colors.red,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: CupertinoTabBar(
              inactiveColor: Color(0xff0984E3),
              activeColor: Color(0xff0984E3),
              onTap: _bottomTapped,
              currentIndex: _page,
              backgroundColor: Color(0xff0984E3),
              items: <BottomNavigationBarItem>[
                _bottomNavigationBarItem("Home", 0),
                _bottomNavigationBarItem("Todo", 1),
                _bottomNavigationBarItem("Notes", 2),
                _bottomNavigationBarItem("Profile", 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(String label, int number) {
    return BottomNavigationBarItem(
      icon: Icon(
          number == 0
              ? Icons.home
              : number == 1
                  ? Icons.alarm_add
                  : number == 2 ? Icons.note_add : Icons.account_circle,
          color: _page == number ? Colors.white : Colors.white60),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: _page == number ? Colors.white : Colors.white60,
        ),
      ),
    );
  }
}
