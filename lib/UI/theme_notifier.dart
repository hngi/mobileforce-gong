import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_mobileforce_gong/styles/color.dart';

enum MyThemes {light, dark}
class ThemeNotifier with ChangeNotifier {
  bool isDarkModeOn = false;
  static final List<ThemeData> themeData = [
      ThemeData(
        //brightness: Brightness.dark,
        primaryColor: Colors.blue,
        //primarySwatch: paleWhite,
        appBarTheme: AppBarTheme(
          color: paleWhite,
          brightness: Brightness.light
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        //primarySwatch: Colors.transparent,
        scaffoldBackgroundColor: paleWhite,
        textTheme: TextTheme(
          headline4: TextStyle(color: lighttext),
          headline6: TextStyle(color: Colors.black)
        ),
        //accentColor: Colors.transparent,
        //highlightColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        fontFamily: 'Gilroy'
      ),
      ThemeData(
        //brightness: Brightness.light,
        primaryColor: Colors.blue,
        appBarTheme: AppBarTheme(
          color: Color(0xff0D141A),
          brightness: Brightness.dark
        ),
        scaffoldBackgroundColor: Color(0xff0D141A),
        //accentColor: Colors.transparent,
        textTheme: TextTheme(
          headline4: TextStyle(color: paleWhite),
          subtitle1: TextStyle(color: paleWhite),
          headline6: TextStyle(color: Colors.white)
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        fontFamily: 'Gilroy'
      ),
  ];

  MyThemes _currentTheme = MyThemes.light;
  ThemeData _currentThemeData = themeData[MyThemes.light.index];

  void switchTheme(bool isOn) async {
    currentTheme == MyThemes.light ? currentTheme = MyThemes.dark : currentTheme = MyThemes.light;
    this.isDarkModeOn = isOn;

    activateTheme(currentTheme, isOn);
  }

  Future<void> activateTheme(MyThemes theme, bool val) async {
    var sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setInt('theme_id', theme.index);
    await sharedPrefs.setBool('isOn', val);
  }

  void loadThemeData(BuildContext context) async {
    var sharedPrefs = await SharedPreferences.getInstance();
    int themeId = sharedPrefs.getInt('theme_id') ?? MyThemes.light.index;
    bool isOn = sharedPrefs.getBool('isOn') ?? false;
    currentTheme = MyThemes.values[themeId];
    isDarkModeOn = isOn;
  }

  set currentTheme(MyThemes theme) {
    if (theme != null) {
      _currentTheme = theme;
      _currentThemeData = themeData[_currentTheme.index];
      //isDarkModeOn = this.isDarkModeOn;
      notifyListeners();
    }
  }

  get currentTheme => _currentTheme;
  get currentThemeData => _currentThemeData;
}