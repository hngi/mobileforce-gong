import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/state/theme_notifier.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/util/styles/color.dart';

class AddNote extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.only(bottom: 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 15),
              width: MediaQuery.of(context).size.width,
              height: SizeConfig().yMargin(context, 18),
              color: blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                      child: SvgPicture.asset(
                        'assets/svgs/backarrow.svg',
                        width: 25,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text('New Note',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      fontSize:
                                          SizeConfig().textSize(context, 2.7),
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Text('Save',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        fontSize:
                                            SizeConfig().textSize(context, 2.1),
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)),
                          ),
                        )
                      ],
                    ),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                                    style: TextStyle(
                                        fontSize: SizeConfig()
                                            .textSize(context, 3.5)),
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
                                      contentPadding: new EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 10.0),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                  ),
                                  TextFormField(
                                    maxLines: null,
                                    minLines: SizeConfig()
                                        .yMargin(context, 2.7)
                                        .round(),
                                    maxLengthEnforced: false,
                                    keyboardType: TextInputType.multiline,
                                    style: TextStyle(
                                        fontSize: SizeConfig()
                                            .textSize(context, 2.1)),
                                    decoration: InputDecoration(
                                      hintText: 'Enter your note here...',
                                      hintStyle: TextStyle(
                                          fontSize: SizeConfig()
                                              .textSize(context, 2.1),
                                          color: Provider.of<ThemeNotifier>(
                                                      context,
                                                      listen: false)
                                                  .isDarkModeOn
                                              ? Colors.grey[400]
                                              : Colors.grey[600]),
                                      contentPadding: new EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 10.0),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
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
                  //                    <--- top side
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
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              fontSize: SizeConfig().textSize(context, 1.9))),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
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
