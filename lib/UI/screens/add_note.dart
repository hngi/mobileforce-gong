import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_mobileforce_gong/models/note_model.dart';
import 'package:team_mobileforce_gong/services/localAuth/lockNotes.dart';
import 'package:team_mobileforce_gong/state/authProvider.dart';
import 'package:team_mobileforce_gong/state/notesProvider.dart';
import 'package:team_mobileforce_gong/state/theme_notifier.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/util/styles/color.dart';

class AddNote extends StatefulWidget {
  final String stitle;
  final String scontent;
  final bool simportant;
  final Notes snote;

  AddNote({Key key, this.stitle, this.scontent, this.simportant, this.snote}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<LocalAuth>(context);
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
                            //print(widget.stitle+' '+_title);
                            // if (snote.title != null ||
                            //     snote.content != null) {
                            //   String userID =
                            //       await Provider.of<AuthenticationState>(
                            //               context,
                            //               listen: false)
                            //           .currentUserId();
                            //   print(userID);
                            //   Provider.of<NotesProvider>(context,
                            //           listen: false)
                            //       .updateNote(
                            //           userID,
                            //           _title ?? snote.title,
                            //           _content ?? snote.content,
                            //           snote.important,
                            //           snote);
                            //   Navigator.pop(context);
                            // } else if (_title == null && _content == null) {
                            //   Navigator.pop(context);
                            // } else {
                            //   String userID =
                            //       await Provider.of<AuthenticationState>(
                            //               context,
                            //               listen: false)
                            //           .currentUserId();
                            //   print(userID);
                            //   Provider.of<NotesProvider>(context,
                            //           listen: false)
                            //       .createNote(
                            //           userID, _title, _content, false);
                            //   Navigator.pop(context);
                            // }
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
                      // IconButton(
                      //     icon: Icon(Icons.color_lens), onPressed: () {}),
                      InkWell(
                          onTap: () async {
                            //print(_title);
                            // snote.title = _title;
                            // snote.content = _content;
                            // Provider.of<NotesProvider>(context, listen: false)
                            //     .save(snote);
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
                                        snote);
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
                                  .createNote(
                                      userID, _title, _content, false);
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            child: Text(snote.title.isEmpty ? 'Save' : 'Update',
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
                  width: MediaQuery.of(context).size.width,
                  height: (MediaQuery.of(context).size.height) -
                      (MediaQuery.of(context).size.height * 0.15),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                      maxLines: null,
                                      maxLengthEnforced: false,
                                      keyboardType: TextInputType.multiline,
                                      style: TextStyle(fontSize: SizeConfig().textSize(context, 2.4)),
                                      initialValue: widget.scontent == null ? null : widget.scontent,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Title',
                                        hintStyle: TextStyle(
                                            fontSize: SizeConfig()
                                                .textSize(context, 3.5),
                                            fontWeight: FontWeight.w400,
                                            color: Provider.of<ThemeNotifier>(
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
                                  TextFormField(
                                    maxLines: null,
                                    minLines: SizeConfig()
                                        .yMargin(context, 2.7)
                                        .round(),
                                    maxLengthEnforced: false,
                                    keyboardType: TextInputType.multiline,
                                    style: TextStyle(
                                        fontSize: SizeConfig()
                                            .textSize(context, 2.4)),
                                    initialValue: snote.content.isEmpty
                                        ? ""
                                        : snote.content,
                                    decoration: InputDecoration(
                                      hintText: 'Enter your note here...',
                                      hintStyle: TextStyle(
                                          fontSize: SizeConfig()
                                              .textSize(context, 2.4),
                                          color: Provider.of<ThemeNotifier>(
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
                                ],
                              ),
                            ),
                          ],
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
                    Container(
                      child: SvgPicture.asset(
                        'assets/svgs/addimage.svg',
                        width: 40,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text('Add image',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(
                                  fontSize:
                                      SizeConfig().textSize(context, 1.9))),
                    ),
                    Spacer(),
                    snote.title.isEmpty
                        ? SizedBox()
                        : IconButton(
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
                            })
                  ],
                ),
              ),
            )
          ],
              // Container(
              //   padding: EdgeInsets.only(top: 10, left: 12, right: 12, bottom: MediaQuery.of(context).viewInsets.bottom,),
              //   decoration: BoxDecoration(
              //     border: Border(
              //       top: BorderSide(
              //         color: lightwhite,
              //         width: 1.0,
              //       ),
              //     )
              //   ),
              //   child: GestureDetector(
              //     onTap: () {
              //       scaffoldKey.currentState.showBottomSheet(
              //         (context) => Container(
              //           height: 100,
              //           child: Column(
              //             children: <Widget>[
              //               GestureDetector(
              //                 onTap: () {
              //                   Navigator.pop(context);
              //                   ImagePicker().getImage(source: ImageSource.camera).then((value)async {
              //                     Uint8List data = await value.readAsBytes();
              //                     print(data);
              //                     setState(() {
              //                       model.img.add(base64Encode(data));
              //                       print(Base64Decoder().convert(model.img[0]).toString());
              //                       //print(img.toString());
              //                     });
              //                   });
              //                 },
              //                 child: Container(
              //                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              //                   child: Row(
              //                     children: <Widget>[
              //                       SvgPicture.asset(
              //                         'assets/svgs/camera.svg',
              //                         width: 20,
              //                       ),
              //                       Container(
              //                         child: Text(
              //                           'Take Photo'
              //                         ),
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               GestureDetector(
              //                 onTap: () {
              //                   Navigator.pop(context);
              //                   ImagePicker().getImage(source: ImageSource.gallery).then((value)async {
              //                     Uint8List data = await value.readAsBytes();
              //                     setState(() {
              //                       model.img.add(base64Encode(data));
              //                     });
              //                   });
              //                 },
              //                 child: Container(
              //                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              //                   child: Row(
              //                     children: <Widget>[
              //                       SvgPicture.asset(
              //                         'assets/svgs/gallery.svg',
              //                         width: 20
              //                       ),
              //                       Container(
              //                         child: Text(
              //                           'Select from gallery'
              //                         ),
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //               )
              //             ],
              //           ),
              //         )
              //       );
              //     },
              //     child: Row(
              //       children: <Widget>[
              //         Container(
              //           child: SvgPicture.asset(
              //             'assets/svgs/addimage.svg',
              //             width: 40,
              //           ),
              //         ),
              //         Container(
              //           margin: EdgeInsets.only(left: 15),
              //           child: Text('Add image',
              //               style: Theme.of(context).textTheme.headline4.copyWith(
              //                   fontSize: SizeConfig().textSize(context, 1.9))),
              //         )
              //       ],
              //     ),
              //   ),
              // )
            // ],
            )
          ),
        );
      
  }

  share(BuildContext context) {
    final RenderBox box = context.findRenderObject();

    Share.share(snote.title ?? 'Untitled',
        subject: snote.content ?? '',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  Color getBackgroundColor(int backgroundColor) {
    switch (backgroundColor) {
      case 1:
        return Colors.white;
        break;
      case 2:
        return Colors.red;
        break;
      case 3:
        return Colors.yellow;
        break;
      case 4:
        return Colors.lightBlue;
        break;
      default:
        return Colors.white;
    }
  }
}

//This method deals with changing backgroundColor of the Note.
/*  void changeColor(int value) {
    setState(() {
      todo.backgroundColor = value;
    });
    if (todo.id != null) {
      helper.updateTodo(todo);
    }
    else {
      helper.insertTodo(todo);
    }

  }*/
