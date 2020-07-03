import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/UI/screens/show_notes.dart';
import 'package:team_mobileforce_gong/services/navigation/app_navigation/navigation.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/state/theme_notifier.dart';

class HomeDrawer extends StatefulWidget {
  final String username;
  final String photoUrl;

  HomeDrawer({Key key, this.username, this.photoUrl}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  var darktheme;
  SizeConfig config = SizeConfig();

  @override
  Widget build(BuildContext context) {
    darktheme = Provider.of<ThemeNotifier>(context).isDarkModeOn ?? false;
    return Drawer(
        child: Column(
      // padding: EdgeInsets.zero,
      children: <Widget>[
        createDrawerHeader(context),
        SizedBox(
          height: 20,
          child: Container(
            color: darktheme ? Color(0xff0D141A) : Colors.white,
          ),
        ),
        // Divider(
        //   thickness: 1,
        //   color: Color.fromRGBO(9, 132, 227, 0.4),
        // ),
        Expanded(
            child: Container(
          color: darktheme ? Color(0xff0D141A) : Colors.white,
          // color: Colors.red,
          child: ListView(
            padding: const EdgeInsets.only(top: 0),
            children: <Widget>[
              createDrawerBodyItem(context: context, text: 'Edit Profile'),
              Divider(
                thickness: 1,
                color: Color.fromRGBO(9, 132, 227, 0.4),
              ),
              createDrawerBodyItem(
                  context: context,
                  text: 'View All Notes',
                  onTap: () => Navigation().pushTo(
                      context,
                      ShowNotes(
                        username: widget.username,
                        name: 'note',
                      ))),
              Divider(
                thickness: 1,
                color: Color.fromRGBO(9, 132, 227, 0.4),
              ),
              createDrawerBodyItem(
                  context: context,
                  text: 'View To-Dos',
                  onTap: () => Navigation().pushTo(
                      context,
                      ShowNotes(
                        username: widget.username,
                        name: 'todo',
                      ))),
              Divider(
                thickness: 1,
                color: Color.fromRGBO(9, 132, 227, 0.4),
              ),
              createDrawerBodyItem(context: context, text: 'View Categories'),
              Divider(
                thickness: 1,
                color: Color.fromRGBO(9, 132, 227, 0.4),
              ),
              createDrawerBodyItem(context: context, text: 'See Quotes'),
              Divider(
                thickness: 1,
                color: Color.fromRGBO(9, 132, 227, 0.4),
              ),
              createDrawerBodyItem(context: context, text: 'Auto System'),
              Divider(
                thickness: 1,
                color: Color.fromRGBO(9, 132, 227, 0.4),
              ),
              createDrawerBodyItem(
                context: context,
                text: 'Dark Mode',
                onTap: () {
                  Provider.of<ThemeNotifier>(context, listen: false)
                      .switchTheme(
                          !Provider.of<ThemeNotifier>(context, listen: false)
                              .isDarkModeOn);
                },
              ),
              Divider(
                thickness: 1,
                color: Color.fromRGBO(9, 132, 227, 0.4),
              ),
              createDrawerBodyItem(context: context, text: 'Setting'),
              Divider(
                thickness: 1,
                color: Color.fromRGBO(9, 132, 227, 0.4),
              ),
              createDrawerBodyItem(context: context, text: 'About'),
              Divider(
                thickness: 1,
                color: Color.fromRGBO(9, 132, 227, 0.4),
              ),
            ],
          ),
        )),
        createDrawerFooter(context),
      ],
    ));
  }

  Widget createDrawerFooter(BuildContext context) {
    return Container(
      color: darktheme ? Color(0xff0D141A) : Colors.white,
      height: config.yMargin(context, 16),
      child: DrawerHeader(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          child: Container(
            color: Color(0xff0984E3),
            child: Center(),
          )),
    );
  }

  Widget createDrawerBodyItem(
      {BuildContext context, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Padding(
        padding: EdgeInsets.only(left: 68.0, top: 14),
        child: Text(text,
            style: GoogleFonts.roboto(
                fontStyle: FontStyle.normal,
                color: darktheme ? Colors.white : Color(0xff312E2E),
                fontSize: config.textSize(context, 2.3),
                fontWeight: FontWeight.w400)),
      ),
      onTap: onTap,
    );
  }

  Widget createDrawerHeader(BuildContext context) {
    return Container(
      height: config.yMargin(context, 18),
      child: DrawerHeader(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          child: Container(
            color: Color(0xff0984E3),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3),
                          shape: BoxShape.circle),
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/Ellipse 14 (1).png'),
                        radius: 30,
                      ),
                    ),
                    Text(
                      widget.username ?? 'User',
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffFBFBF8)),
                    )
                    // RichText(
                    //   text: TextSpan(
                    //       text: username ?? 'User',
                    //       style: GoogleFonts.roboto(
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.bold,
                    //           color: Color(0xffFBFBF8)),
                    //       children: <TextSpan>[
                    //         TextSpan(
                    //             text: ' Mercy',
                    //             style: GoogleFonts.roboto(
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.w400,
                    //                 color: Color(0xffFBFBF8)))
                    //       ]),
                    // ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class DrawerItem extends StatefulWidget {
  final text;
  final GestureTapCallback onTap;

  const DrawerItem({Key key, this.text, this.onTap}) : super(key: key);
  @override
  _DrawerItemState createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  SizeConfig config = SizeConfig();
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: config.yMargin(context, 9),
      decoration: BoxDecoration(
        color: clicked ? Color.fromRGBO(9, 132, 227, 0.2) : Colors.transparent,
        border: Border.all(color: Color.fromRGBO(9, 132, 227, 0.4), width: 1),
      ),
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.only(left: 68.0, top: 14),
          child: Text(this.widget.text,
              style: GoogleFonts.roboto(
                  fontStyle: FontStyle.normal,
                  color: Color(0xff312E2E),
                  fontSize: config.textSize(context, 4.7),
                  fontWeight: FontWeight.w400)),
        ),
        onTap: () {
          setState(() {
            clicked = !clicked;
          });
        },
      ),
    );
  }
}
