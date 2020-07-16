import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_mobileforce_gong/UI/screens/dispatch_page.dart';
import 'package:team_mobileforce_gong/UI/screens/showQuotes.dart';
import 'package:team_mobileforce_gong/UI/screens/show_notes.dart';
import 'package:team_mobileforce_gong/services/auth/util.dart';
import 'package:team_mobileforce_gong/services/navigation/app_navigation/navigation.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/state/authProvider.dart';
import 'package:team_mobileforce_gong/state/theme_notifier.dart';
import 'package:team_mobileforce_gong/util/styles/color.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../screens/profile.dart';
import '../rate.dart';

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
  WidgetBuilder builder = buildProgressIndicator;
  String uid;
  String photoUrl;
  String usernamee;

  

  Future<void> docSnapshot() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        uid = user.uid;
      });
    });
    var something =
        await Firestore.instance.collection('userData').document(uid).get();
    DocumentSnapshot doc = something;
    print(doc);
    if (doc['uid'] == uid) {
      setState(() {
        photoUrl = doc['photoUrl'];
        usernamee = doc['username'];
      });
    }
    print(doc);
  }

  @override
  void initState() {
    docSnapshot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    darktheme = Provider.of<ThemeNotifier>(context).isDarkModeOn ?? false;
    final state = Provider.of<AuthenticationState>(context);
    return Drawer(
        child: Column(
      // padding: EdgeInsets.zero,
      children: <Widget>[
        createDrawerHeader(context),
        // Divider(
        //   thickness: 1,
        //   color: Color.fromRGBO(9, 132, 227, 0.4),
        // ),
        Expanded(
            child: Container(
          color: darktheme ? Colors.black : Colors.white,
          //padding: EdgeInsets.symmetric(vertical: 20),
          // color: Colors.red,
          child: ListView(
            padding: const EdgeInsets.only(top: 0),
            children: <Widget>[
              createDrawerBodyItem(
                  context: context,
                  text: 'Profile',
                  onTap: () {
                    Navigation().pushTo(context, Profile());
                  }),
              Divider(
                thickness: 1,
                color: Color.fromRGBO(9, 132, 227, 0.4),
              ),
              // 
              createDrawerBodyItem(
                  context: context,
                  text: 'See Quotes',
                  onTap: () {
                    Navigation().pushTo(context, ShowQuotes());
                  }),

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
              createDrawerBodyItem(
                  context: context,
                  text: 'Rate Us',
                  onTap: () async {
                    Navigation().pushTo(
                        context,
                        RateMyAppBuilder(
                          builder: builder,
                          onInitialized: (context, rateMyApp) async {
                            await rateMyApp.showRateDialog(context,
                                dialogStyle: DialogStyle(
                                    titleStyle: TextStyle(
                                        color: darktheme
                                            ? Colors.white
                                            : Colors.black)),
                                dialogColor: darktheme
                                    ? Color(0xff0D141A)
                                    : Colors.white);
                            Navigator.pop(context);
                          },
                        ));
                  }),
              // Divider(
              //   thickness: 1,
              //   color: Color.fromRGBO(9, 132, 227, 0.4),
              // ),
              // createDrawerBodyItem(
              //   context: context,
              //   text: 'Contact', onTap: () => launch(_emailLaunchUri.toString())
              // ),
              Divider(
                thickness: 1,
                color: Color.fromRGBO(9, 132, 227, 0.4),
              ),
              createDrawerBodyItem(
                  context: context,
                  text: 'Sign Out',
                  onTap: () {
                    state.logout().then((value) => gotoLoginScreen(context));
                  }),
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

  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'hello@hng.tech',
      queryParameters: {'subject': 'Gong Feedback/Complaints'});

  static Widget buildProgressIndicator(BuildContext context) =>
      const Center(child: CircularProgressIndicator());

  Widget createDrawerFooter(BuildContext context) {
    return Container(
      color: darktheme ? Color(0xff0D141A) : blue,
      height: config.yMargin(context, 15),
      child: Container(),
    );
  }

  Widget createDrawerBodyItem(
      {BuildContext context, String text, GestureTapCallback onTap}) {
    return ListTile(
      leading: SizedBox(),
      title: Container(
        padding: EdgeInsets.only(top: config.yMargin(context, 2.5)),
        child: Text(
          text,
          style: TextStyle(
              fontStyle: FontStyle.normal,
              color: darktheme ? Colors.white : Color(0xff312E2E),
              fontSize: config.textSize(context, 2.3),
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.left,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget createDrawerHeader(BuildContext context) {
    return Container(
      //height: config.yMargin(context, 18),
      color: darktheme ? Color(0xff0D141A) : blue,
      padding: EdgeInsets.only(
          top: config.yMargin(context, 5),
          bottom: config.xMargin(context, 1.8)),
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: config.yMargin(context, 1)),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  shape: BoxShape.circle),
              child: CircleAvatar(
                backgroundImage: photoUrl == null
                    ? AssetImage('assets/images/images.jpg')
                    : NetworkImage(photoUrl),
                radius: 30,
              ),
            ),
            Text(
              widget.username ?? 'User',
              style: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: config.textSize(context, 3),
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
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
              style: TextStyle(
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
