import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/UI/screens/add_note.dart';
import 'package:team_mobileforce_gong/UI/screens/add_todo.dart';
import 'package:team_mobileforce_gong/UI/screens/onboarding.dart';
import 'package:team_mobileforce_gong/UI/screens/password_reset_success.dart';
import 'package:team_mobileforce_gong/UI/widgets/drawer/drawer.dart';
import 'package:team_mobileforce_gong/services/navigation/app_navigation/navigation.dart';

import 'package:team_mobileforce_gong/state/theme_notifier.dart';
import 'package:team_mobileforce_gong/UI/widgets/action_card.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/util/styles/color.dart';

import 'show_notes.dart';
import 'sign_in.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool open = true;

  String username;

  Future<void> getUser() async {
    await FirebaseAuth.instance.currentUser().then((user) => {
          setState(() {
            username = user.displayName;
          })
        });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: HomeDrawer(
        username: username,
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Hey ${username ?? 'There'}',
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: SizeConfig().textSize(context, 3),
              ),
        ),
        leading: GestureDetector(
          onTap: () => scaffoldKey.currentState.openDrawer(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: SvgPicture.asset(
              'assets/svgs/ham.svg',
              color: Provider.of<ThemeNotifier>(context, listen: false)
                      .isDarkModeOn
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Provider.of<ThemeNotifier>(context, listen: false).switchTheme(
                  !Provider.of<ThemeNotifier>(context, listen: false)
                      .isDarkModeOn);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              margin: EdgeInsets.only(right: 10),
              child: SvgPicture.asset(
                'assets/svgs/night.svg',
                width: 24,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.35,
                    bottom: 50),
                child: Text(
                  'Click the + button Below to get started',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: SizeConfig().textSize(context, 2.1)),
                ),
              ),
              Center(child: newActions(context, username))
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: open,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              open = false;
            });
            Navigator.of(context).push(new PageRouteBuilder(
                opaque: false,
                barrierColor: Colors.black.withOpacity(0.5),
                barrierDismissible: false,
                pageBuilder: (BuildContext context, __, _) {
                  return WillPopScope(
                    onWillPop: () {
                      setState(() {
                        open = true;
                      });
                      Navigator.pop(context);
                      return null;
                    },
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: SizeConfig().yMargin(
                                context,
                                MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? 75.7
                                    : 25.7),
                          ),
                          Container(
                            width: SizeConfig().xMargin(context, 35.3),
                            height: SizeConfig().yMargin(context, 20.2),
                            child: Stack(
                              overflow: Overflow.visible,
                              children: <Widget>[
                                Container(
                                  width: SizeConfig().xMargin(context, 35.3),
                                  height: SizeConfig().yMargin(context, 19.2),
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 30),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              open = true;
                                            });
                                            Navigator.pop(context);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddNote()));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 8),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  child: SvgPicture.asset(
                                                    'assets/svgs/createnote.svg',
                                                    width: 15,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text('Create Note',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .copyWith(
                                                                fontSize: SizeConfig()
                                                                    .textSize(
                                                                        context,
                                                                        1.5),
                                                                color: blue)),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              open = true;
                                            });
                                            Navigator.pop(context);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddTodo()));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  child: SvgPicture.asset(
                                                    'assets/svgs/addtodo.svg',
                                                    width: 15,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text('Add To Do',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .copyWith(
                                                                fontSize: SizeConfig()
                                                                    .textSize(
                                                                        context,
                                                                        1.5),
                                                                color: blue)),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: SizeConfig().yMargin(context, 14.4),
                                  left: SizeConfig().xMargin(context, 11.7),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        open = true;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: blue,
                                      ),
                                      child: Center(
                                          child: SvgPicture.asset(
                                              'assets/svgs/cancel.svg')),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }));
          },
        ),
      ),
    );
  }
}

Widget newActions(context, String username) => Wrap(
      alignment: WrapAlignment.start,
      spacing: SizeConfig().xMargin(context, 8.5),
      runSpacing: SizeConfig().yMargin(context, 2.1),
      children: <Widget>[
        ActionCard(
            svg: 'assets/svgs/note.svg',
            title: 'Notes',
            text: '12 Saved',
            onPressed: () => Navigation().pushTo(
                context,
                ShowNotes(
                  username: username,
                  name: 'note',
                ))),
        ActionCard(
            svg: 'assets/svgs/todo.svg',
            title: 'Todo',
            text: '3 Pending',
            onPressed: () => Navigation().pushTo(
                context,
                ShowNotes(
                  username: username,
                  name: 'note',
                ))),
        ActionCard(
          svg: 'assets/svgs/facts.svg',
          title: 'View Facts',
          text: '12 Saved',
        ),
        ActionCard(
          svg: 'assets/svgs/motivation.svg',
          title: 'Motivation',
          text: '12 Saved',
        ),
        ActionCard(
          svg: 'assets/svgs/calendar.svg',
          title: 'View Reminder',
          text: '12 Saved',
        ),
      ],
    );
