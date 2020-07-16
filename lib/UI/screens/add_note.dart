import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_mobileforce_gong/models/note_model.dart';
import 'package:team_mobileforce_gong/services/localAuth/lockNotes.dart';
import 'package:team_mobileforce_gong/state/authProvider.dart';
import 'package:team_mobileforce_gong/models/CustomPopUpMenu.dart';
import 'package:team_mobileforce_gong/state/notesProvider.dart';
import 'package:team_mobileforce_gong/state/theme_notifier.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/util/styles/color.dart';

//final List<String> colorChoices = const <String>['Green', 'Purple', 'Orange', "Yellow", "Red",];

final List<CustomPopupMenu> colorChoices =[
  CustomPopupMenu(title: "Green", style: TextStyle(color: Colors.green[300])),
  CustomPopupMenu(title: "Purple", style: TextStyle(color:  Colors.purple[200])),
  CustomPopupMenu(title: "Orange", style: TextStyle(color: Colors.orange[300])),
  CustomPopupMenu(title: "Yellow", style: TextStyle(color: Colors.yellow[600])),
  CustomPopupMenu(title: "Red", style: TextStyle(color: Colors.red[300])),
  CustomPopupMenu(title: "Default", style: TextStyle(color: Colors.black)),
];





const green = 'Green';
const purple = 'Purple';
const orange = 'Orange';
const yellow = "Yellow";
const red = "Red";
const defaultColor = "Default";

final List<CustomPopupMenu> choices =[
  CustomPopupMenu(title: "Cedarville", style: TextStyle(fontFamily: "Cedarville")),
  CustomPopupMenu(title: "ComicNeue", style: TextStyle(fontFamily: "ComicNeue")),
  CustomPopupMenu(title: "Gilroy", style: TextStyle(fontFamily: "Gilroy")),
  CustomPopupMenu(title: "Montserrat", style: TextStyle(fontFamily: "Montserrat")),
  CustomPopupMenu(title: "Shadows", style: TextStyle(fontFamily: "Shadows"))
];

const Cedarville = 'Cedarville';
const ComicNeue = 'ComicNeue';
const Gilroy = 'Orange';
const Montserrat = "Montserrat";
const Shadows = "Shadows";

class AddNote extends StatefulWidget {
  final String stitle;
  final String scontent;
  final bool simportant;
  final Notes snote;

  AddNote({Key key, this.stitle, this.scontent, this.simportant, this.snote})
      : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState(snote);
}

class _AddNoteState extends State<AddNote> {
  Notes snote;
  String _title;
  String _content;

  _AddNoteState(this.snote);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    checkLocked();
    super.initState();
  }

  bool _locked = false;

  Future<void> checkLocked() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLocked = prefs.getBool(snote.sId) ?? false;
    setState(() {
      _locked = isLocked;
    });
  }
  var darktheme;
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<LocalAuth>(context);
    var model = Provider.of<NotesProvider>(context);
    darktheme = Provider.of<ThemeNotifier>(context).isDarkModeOn ?? false;
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Container(
          padding: EdgeInsets.only(bottom: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    left: SizeConfig().xMargin(context, 5.9),
                    right: SizeConfig().xMargin(context, 5.9),
                    top: SizeConfig().yMargin(context, 3.0),
                    bottom: SizeConfig().yMargin(context, 1.6)),
                width: MediaQuery.of(context).size.width,
                height: SizeConfig().yMargin(context, 18),
                color: blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig().yMargin(context, 2.1),
                                  horizontal:
                                      SizeConfig().xMargin(context, 1.9)),
                              child: SvgPicture.asset(
                                'assets/svgs/backarrow.svg',
                                width: 25,
                              ),
                            )),
                        snote.title.isEmpty
                            ? SizedBox()
                            : IconButton(
                                icon: Icon(Icons.share),
                                onPressed: () => share(context))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                              snote.title.isEmpty ? 'New Note' : 'Edit Note',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      fontSize:
                                          SizeConfig().textSize(context, 2.7),
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                        ),
                        InkWell(
                            onTap: () async {
                              if (widget.stitle != null ||
                                  widget.scontent != null) {
                                if (_title == null && _content == null) {
                                  Navigator.pop(context);
                                } else {
                                  String userID =
                                      await Provider.of<AuthenticationState>(
                                              context,
                                              listen: false)
                                          .currentUserId();
                                  Provider.of<NotesProvider>(context,
                                          listen: false)
                                      .updateNote(
                                          userID,
                                          _title ?? snote.title,
                                          _content ?? snote.content,
                                          snote.important,
                                          snote,snote.color);
                                  Navigator.pop(context);
                                }
                              } else if (_title == null && _content == null) {
                                Navigator.pop(context);
                              } else {
                                String userID =
                                    await Provider.of<AuthenticationState>(
                                            context,
                                            listen: false)
                                        .currentUserId();
                                Provider.of<NotesProvider>(context,
                                        listen: false)
                                    .createNote(userID, _title, _content, false,
                                        snote.color,snote.font);
                                Navigator.pop(context);
                              }
                            },
                            child: Container(
                              child: Text(
                                  snote.title.isEmpty ? 'Save' : 'Update',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          fontSize: SizeConfig()
                                              .textSize(context, 2.1),
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300)),
                            )),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    color: model.getBackgroundColor(snote.color, darktheme),
                    width: MediaQuery.of(context).size.width,
                    height: (MediaQuery.of(context).size.height) -
                        (MediaQuery.of(context).size.height * 0.15),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                            maxLines: null,
                                            maxLengthEnforced: false,
                                            keyboardType:
                                                TextInputType.multiline,
                                            style: TextStyle(
                                                fontFamily: model.getTextFont(snote.font),
                                                fontSize: SizeConfig()
                                                    .textSize(context, 2.4)),
                                            initialValue: widget.stitle == null
                                                ? null
                                                : widget.stitle,
                                            decoration: InputDecoration(
                                              hintText: 'Enter Title',
                                              hintStyle: TextStyle(
                                                  fontSize: SizeConfig()
                                                      .textSize(context, 3.5),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: model.getTextFont(snote.font),
                                                  color:
                                                      Provider.of<ThemeNotifier>(
                                                                  context,
                                                                  listen: false)
                                                              .isDarkModeOn
                                                          ? Colors.grey[400]
                                                          : Colors.grey[600]),
                                              contentPadding:
                                                  new EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 10.0),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                _title = value;
                                              });
                                            }),
                                        Expanded(
                                          child: TextFormField(
                                            maxLines: null,
                                            minLines: SizeConfig().yMargin(context, 2.7).round(),
                                            maxLengthEnforced: false,
                                            keyboardType: TextInputType.multiline,
                                            style: TextStyle(
                                                fontFamily: model.getTextFont(snote.font),
                                                fontSize: SizeConfig()
                                                    .textSize(context, 2.4)),
                                            initialValue: snote.content.isEmpty
                                                ? ""
                                                : snote.content,
                                            decoration: InputDecoration(
                                              hintText:
                                                  'Enter your note here...',
                                              hintStyle: TextStyle(
                                                  fontFamily: model.getTextFont(snote.font),
                                                  fontSize: SizeConfig()
                                                      .textSize(context, 2.4),
                                                  color:
                                                      Provider.of<ThemeNotifier>(
                                                                  context,
                                                                  listen: false)
                                                              .isDarkModeOn
                                                          ? Colors.grey[400]
                                                          : Colors.grey[600]),
                                              contentPadding:
                                                  new EdgeInsets.symmetric(
                                                      vertical: 20.0,
                                                      horizontal: 10.0),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                _content = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 12,
                  right: 12,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(
                    color: lightwhite,
                    width: 1.0,
                  ),
                )),
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: <Widget>[
                      // Container(
                      //   child: SvgPicture.asset(
                      //     'assets/svgs/addimage.svg',
                      //     width: 40,
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.only(left: 15),
                      //   child: Text('Add image',
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .headline4
                      //           .copyWith(
                      //               fontSize:
                      //                   SizeConfig().textSize(context, 1.9))),
                      // ),

                      PopupMenuButton<String>(
                        icon: Icon(Icons.color_lens),
                        onSelected: selectColor,
                        itemBuilder: (BuildContext context) {
                          return colorChoices.map((CustomPopupMenu choice) {
                            return PopupMenuItem<String>(
                              value: choice.title,
                              child: Text(choice.title,
                              style: choice.style,),
                            );
                          }).toList();
                        },
                      ),
                      SizedBox(width: 10),
                      PopupMenuButton<String>(
                        onSelected: selectFont,
                        icon: Icon(Icons.font_download),
                        tooltip: "Select Font",
                        itemBuilder: (BuildContext context) {
                          return choices.map((CustomPopupMenu choice) {
                            return PopupMenuItem<String>(
                              value: choice.title,
                              child: Text(choice.title,style: choice.style,),
                            );
                          }).toList();
                        },
                      ),
                      Spacer(),
                      snote.title.isEmpty
                          ? SizedBox()
                          : GestureDetector(
                              onTap: () async {
                                await state.checkBiometrics();
                                await state.getAvailableBiometrics();
                                bool check = state.canCheckBiometrics;
                                if (_locked == true) {
                                  if (check == true) {
                                    await Provider.of<LocalAuth>(context,
                                            listen: false)
                                        .authenticate();
                                    String status = state.successful;
                                    if (status == 'Successful') {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setBool(snote.sId, false);
                                      bool test = prefs.getBool(snote.sId);
                                      print(test);
                                      setState(() {
                                        _locked = false;
                                      });
                                      scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                  'Lock disabled Successfully')));
                                    } else {
                                      scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                  'Authorization failed')));
                                    }
                                  } else {
                                    //show pin input
                                  }
                                } else {
                                  if (check == true) {
                                    await Provider.of<LocalAuth>(context,
                                            listen: false)
                                        .authenticate();
                                    String status = state.successful;
                                    if (status == 'Successful') {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setBool(snote.sId, true);
                                      bool test = prefs.getBool(snote.sId);
                                      print(test);
                                      setState(() {
                                        _locked = true;
                                      });
                                      scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                  'Note locked successful')));
                                    } else {
                                      scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                  'Authorization failed')));
                                    }
                                  } else {
                                    //show pin input
                                  }
                                }
                              },
                              child: Row(children: <Widget>[
                                Text(
                                  _locked ? 'Unlock Note' : 'Lock Note',
                                  style: GoogleFonts.aBeeZee(
                                    color: darktheme ? Colors.white : Colors.black,
                                      fontSize:
                                          SizeConfig().textSize(context, 2)),
                                ),
                                IconButton(
                                    icon: _locked
                                        ? Icon(Icons.enhanced_encryption)
                                        : Icon(Icons.no_encryption),
                                    onPressed: () async {
                                      await state.checkBiometrics();
                                      await state.getAvailableBiometrics();
                                      bool check = state.canCheckBiometrics;
                                      if (_locked == true) {
                                        if (check == true) {
                                          await Provider.of<LocalAuth>(context,
                                                  listen: false)
                                              .authenticate();
                                          String status = state.successful;
                                          if (status == 'Successful') {
                                            final prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.setBool(snote.sId, false);
                                            bool test =
                                                prefs.getBool(snote.sId);
                                            print(test);
                                            setState(() {
                                              _locked = false;
                                            });
                                            scaffoldKey.currentState
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        Colors.green,
                                                    content: Text(
                                                        'Lock disabled Successfully')));
                                          } else {
                                            scaffoldKey.currentState
                                                .showSnackBar(SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                        'Authorization failed')));
                                          }
                                        } else {
                                          scaffoldKey.currentState
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        Colors.red,
                                                    content: Text(
                                                        'Oops, Biometrics isn\'t enabled on your device')));
                                        }
                                      } else {
                                        if (check == true) {
                                          await Provider.of<LocalAuth>(context,
                                                  listen: false)
                                              .authenticate();
                                          String status = state.successful;
                                          if (status == 'Successful') {
                                            final prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.setBool(snote.sId, true);
                                            bool test =
                                                prefs.getBool(snote.sId);
                                            print(test);
                                            setState(() {
                                              _locked = true;
                                            });
                                            scaffoldKey.currentState
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        Colors.green,
                                                    content: Text(
                                                        'Note locked successful')));
                                          } else {
                                            scaffoldKey.currentState
                                                .showSnackBar(SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                        'Authorization failed')));
                                          }
                                        } else {
                                          scaffoldKey.currentState
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        Colors.red,
                                                    content: Text(
                                                        'Oops, Biometrics isn\'t enabled on your device')));
                                        }
                                      }
                                    })
                              ]),
                            )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  share(BuildContext context) {
    final RenderBox box = context.findRenderObject();

    Share.share(snote.title ?? 'Untitled',
        subject: snote.content ?? '',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  void selectColor(String value) async {

    switch (value) {
      case defaultColor:
        changeColor(1);
        break;
      case red:
        changeColor(2);
        break;
      case yellow:
        changeColor(3);
        break;
      case green:
        changeColor(4);
        break;
      case orange:
        changeColor(5);
        break;
      case purple:
        changeColor(6);
        break;
      default:
    }
  }

  void selectFont( String value){
    switch(value){
      case Shadows:
        changeFont(1);
        break;
      case Cedarville:
       changeFont(2);
        break;
      case Montserrat:
        changeFont(3);
        break;
      case ComicNeue:
        changeFont(4);
        break;
      case Gilroy:
        changeFont(5);
        break;
      default:
        changeFont(6);
        break;
    }
  }

  void changeColor(int color) async {

    snote.color = color;
    String userID =
        await Provider.of<AuthenticationState>(context, listen: false)
            .currentUserId();
    Provider.of<NotesProvider>(context, listen: false).updateNote(
        userID,
        _title ?? snote.title,
        _content ?? snote.content,
        snote.important,
        snote,snote.color);
  }

  void changeFont(int font) async{
    print("Font is $font " );
    snote.font = font;
    String userID = await Provider.of<AuthenticationState>(context, listen: false).currentUserId();
    Provider.of<NotesProvider>(context, listen: false).updateNote(
        userID,
        _title ?? snote.title,
        _content ?? snote.content,
        snote.important,
        snote,snote.color);
  }
}

