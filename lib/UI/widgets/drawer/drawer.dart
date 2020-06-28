import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';

class HomeDrawer extends StatelessWidget {
  SizeConfig config = SizeConfig();
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      // padding: EdgeInsets.zero,
      children: <Widget>[
        createDrawerHeader(context),
        SizedBox(height: 20),
        // Divider(
        //   thickness: 1,
        //   color: Color.fromRGBO(9, 132, 227, 0.4),
        // ),
        Expanded(
            child: Container(
          // color: Colors.red,
          child: ListView(
            padding: const EdgeInsets.only(top: 0),
            children: <Widget>[
              DrawerItem(text: 'Edit Profile'),
              createDrawerBodyItem(context: context, text: 'View All Notes'),
              Divider(
                thickness: 1,
                color: Color.fromRGBO(9, 132, 227, 0.4),
              ),
              createDrawerBodyItem(context: context, text: 'View To-Dos'),
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
              createDrawerBodyItem(context: context, text: 'Dark Mode'),
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
                color: Color(0xff312E2E),
                fontSize: config.textSize(context, 4.7),
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
                    RichText(
                      text: TextSpan(
                          text: 'Akpan',
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffFBFBF8)),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Mercy',
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffFBFBF8)))
                          ]),
                    ),
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
