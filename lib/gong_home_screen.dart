import 'package:flutter/material.dart';
import 'package:mobileforcegong/homepage.dart';
import 'package:mobileforcegong/todopage.dart';
import 'package:mobileforcegong/notepage.dart';
import 'package:mobileforcegong/profile.dart';



class GongHomeScreen extends StatefulWidget {
  @override
  _GongHomeScreenState createState() => _GongHomeScreenState();
}

class _GongHomeScreenState extends State<GongHomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void navigationTapped(int page) {
    setState(() {
      _currentIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // this is all pages here in list we can choose index when click bottom navigation bar
    List<Widget> _allPages = [
      homepage(),
      todopage(),
      notepage(),
      profile(),
    ];

    return Scaffold(

      body: _allPages[_currentIndex],
      bottomNavigationBar: buildBottomNavigationBar(),

    );
  }

  // Bottom navigation bar area you can choose icons what you want.
  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: const Color(0xff0984E3),
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.white,
      currentIndex: _currentIndex,
      onTap: navigationTapped,
      // iconSize: 28,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home,color: Colors.white70),
          title: Text(
            "Home",
            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 10),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.timer,color: Colors.white70
          ),
          title: Text(
            "Todo",
            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 10),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.note_add,color: Colors.white70),
          title: Text(
            "Notes",
            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 10),
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle,color: Colors.white70),
          title: Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.normal,fontSize: 10),
          ),
        ),
      ],
    );
  }
}


