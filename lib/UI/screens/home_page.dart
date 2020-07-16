import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/UI/screens/add_note.dart';
import 'package:team_mobileforce_gong/UI/screens/add_todo.dart';
import 'package:team_mobileforce_gong/UI/screens/dispatch_page.dart';
import 'package:team_mobileforce_gong/models/note_model.dart';
import 'package:team_mobileforce_gong/models/todos.dart';
import 'package:team_mobileforce_gong/services/quotes/quote.dart';
import 'package:team_mobileforce_gong/services/quotes/quoteDb.dart';
import 'package:team_mobileforce_gong/state/authProvider.dart';
import 'package:team_mobileforce_gong/state/notesProvider.dart';
import 'package:team_mobileforce_gong/UI/screens/onboarding.dart';
import 'package:team_mobileforce_gong/UI/screens/password_reset_success.dart';
import 'package:team_mobileforce_gong/UI/widgets/drawer/drawer.dart';
import 'package:team_mobileforce_gong/services/navigation/app_navigation/navigation.dart';

import 'package:team_mobileforce_gong/state/theme_notifier.dart';
import 'package:team_mobileforce_gong/UI/widgets/action_card.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/state/todoProvider.dart';
import 'package:team_mobileforce_gong/util/styles/color.dart';

import 'facts.dart';
import 'show_notes.dart';
import 'sign_in.dart';

class HomePage extends StatefulWidget {
  final bool justLoggedIn;

  const HomePage({Key key, @required this.justLoggedIn}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool open = true;

  String username;
  String uid;

  Future<void> getUser() async {
    await FirebaseAuth.instance
        .currentUser()
        .then((user) => {
              setState(() {
                username = user.displayName;
                uid = user.uid;
              })
            })
        .then((value) {
      Provider.of<NotesProvider>(context, listen: false).fetch(uid, widget.justLoggedIn);
      Provider.of<TodoProvider>(context, listen: false).fetch(uid, widget.justLoggedIn);
    });
  }

  List<Quote> quotes = [];
  List<Quote> facts = [];

  @override
  void initState() {
    getUser();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      QuotesDatabase.db.getAllClients().then((value) => {
            for (int i = 0; i < value.length; i++)
              {
                if (value[i].author != 'Facts')
                  {
                    quotes.add(value[i]),
                  }
                else
                  {
                    facts.add(value[i]),
                  }
              }
          });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=> Navigation().pop(context),
          child: Scaffold(
          key: scaffoldKey,
          drawer: HomeDrawer(
            username: username,
          ),
          appBar: AppBar(
              elevation: 0,
              title: Text(
                'Hey ${username ?? 'There'}',
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontFamily:  "Montserrat",
                      fontSize: SizeConfig().textSize(context, 3),
                    ),
              ),
              leading: GestureDetector(
                onTap: () => scaffoldKey.currentState.openDrawer(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
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
                    Provider.of<ThemeNotifier>(context, listen: false)
                        .switchTheme(
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
              ]),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Provider.of<NotesProvider>(context).notes.length == 0 &&
                          Provider.of<TodoProvider>(context).todos.length == 0
                      ? Container(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.2,
                              bottom: 50),
                          child: Text(
                            'Click the + button Below to get started',
                            style: Theme.of(context).textTheme.headline6.copyWith(
                                fontSize: SizeConfig().textSize(context, 2.1)),
                          ),
                        )
                      : SizedBox(),
                  Center(child: newActions(context, facts, quotes))
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
                    barrierDismissible: true,
                    pageBuilder: (BuildContext context, __, _) {
                      return WillPopScope(
                        onWillPop: () async {
                          setState(() {
                            open = true;
                          });
                          Navigator.pop(context);
                          return false;
                        },
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: SizeConfig().yMargin(
                                    context,
                                    MediaQuery.of(context).orientation ==
                                            Orientation.portrait
                                        ? 70
                                        : 18),
                              ),
                              Container(
                                width: SizeConfig().xMargin(context, 40.3),
                                height: SizeConfig().yMargin(context, 28),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      width: SizeConfig().xMargin(context, 40.3),
                                      height: SizeConfig().yMargin(context, 22.2),
                                      padding: EdgeInsets.only(
                                          left: SizeConfig().xMargin(context, 4),
                                          right: SizeConfig().xMargin(context, 4),
                                          top: SizeConfig().yMargin(context, 1.2),
                                          bottom:
                                              SizeConfig().yMargin(context, 3.7)),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Provider.of<ThemeNotifier>(context,
                                                    listen: false)
                                                .isDarkModeOn
                                            ? Colors.grey.shade900
                                            : Colors.white,
                                      ),
                                      child: Column(children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              open = true;
                                            });
                                            Navigator.pop(context);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) => AddNote(
                                                        snote: new Notes.noID(
                                                            "", "", "", 1))));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: SizeConfig()
                                                    .yMargin(context, 1.8),
                                                horizontal: SizeConfig()
                                                    .xMargin(context, 1.9)),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  child: SvgPicture.asset(
                                                    'assets/svgs/createnote.svg',
                                                    width: 15,
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: SizeConfig()
                                                          .xMargin(context, 2.3)),
                                                  child: Text('Create Note',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          .copyWith(
                                                              fontSize:
                                                                  SizeConfig()
                                                                      .textSize(
                                                                          context,
                                                                          1.8),
                                                              color: blue)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                open = true;
                                              });
                                              Navigator.pop(context);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddTodo(
                                                              stodo:
                                                                  new Todos.noID(
                                                                      "",
                                                                      "",
                                                                      "",
                                                                      false,
                                                                      false,
                                                                      1))));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: SizeConfig()
                                                      .yMargin(context, 1.8),
                                                  horizontal: SizeConfig()
                                                      .xMargin(context, 1.9)),
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
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: SizeConfig()
                                                            .xMargin(
                                                                context, 2.3)),
                                                    child: Text('Add To Do',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .copyWith(
                                                                fontSize:
                                                                    SizeConfig()
                                                                        .textSize(
                                                                            context,
                                                                            1.8),
                                                                color: blue)),
                                                  )
                                                ],
                                              ),
                                            )),
                                      ]),
                                    ),
                                    Positioned(
                                        top: SizeConfig().yMargin(context, 18),
                                        left: SizeConfig().xMargin(context, 13),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              open = true;
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            width: SizeConfig().xMargin(
                                                context,
                                                SizeConfig()
                                                    .getXSize(context, 50)),
                                            height: SizeConfig().yMargin(
                                                context,
                                                SizeConfig()
                                                    .getYSize(context, 50)),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: blue,
                                            ),
                                            child: Center(
                                                child: SvgPicture.asset(
                                              'assets/svgs/cancel.svg',
                                              width: SizeConfig()
                                                  .xMargin(context, 4),
                                            )),
                                          ),
                                        ))
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
          )),
    );
  }
}

Widget newActions(context, List<Quote> facts, List<Quote> quotes) => Wrap(
      alignment: WrapAlignment.start,
      spacing: SizeConfig().xMargin(context, 6),
      runSpacing: SizeConfig().yMargin(context, 2.1),
      children: <Widget>[
        ActionCard(
          svg: 'assets/svgs/note.svg',
          title: 'Notes',
          text: Provider.of<NotesProvider>(context).notes.length != 0
              ? Provider.of<NotesProvider>(context, listen: true)
                      .notes
                      .length
                      .toString() +
                  ' saved'
              : '0 saved',
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DispatchPage(
                        name: 'note',
                      ))),
        ),
        ActionCard(
          svg: 'assets/svgs/todo.svg',
          title: 'Todo',
          text: Provider.of<TodoProvider>(context).todos.length != 0
              ? Provider.of<TodoProvider>(context, listen: true)
                      .todos
                      .length
                      .toString() +
                  ' Pending'
              : '0 Pending',
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DispatchPage(
                    name: 'todo',
                  ))),
        ),
        ActionCard(
          svg: 'assets/svgs/facts.svg',
          title: 'View Facts',
          text: '${facts.length} Saved',
          onPressed: () => Navigation().pushTo(
              context,
              Facts(
                quoteType: QuoteType.Facts,
              )),
        ),
        ActionCard(
          svg: 'assets/svgs/motivation.svg',
          title: 'Motivation',
          text: '${quotes.length} Saved',
          onPressed: () => Navigation()
              .pushTo(context, Facts(quoteType: QuoteType.Motivation)),
        ),
        // ActionCard(
        //   svg: 'assets/svgs/calendar.svg',
        //   title: 'View Reminder',
        //   text: '12 Saved',
        // ),
      ],
    );
