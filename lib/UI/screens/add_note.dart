import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/UI/theme_notifier.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/util/styles/color.dart';

class AddNote extends StatelessWidget {
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
              padding: EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 15),
              width: MediaQuery.of(context).size.width,
              height: SizeConfig().yMargin(context, 15.1),
              color: blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){Navigator.pop(context);},
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                      child: SvgPicture.asset(
                        'assets/svgs/backarrow.svg',
                        width: 25,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'New Note',
                          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().textSize(context, 2.7), color: Colors.white, fontWeight: FontWeight.w600)
                        ),
                      ),
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          child: Text(
                            'Save',
                            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().textSize(context, 2.1), color: Colors.white, fontWeight: FontWeight.w300)
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: (MediaQuery.of(context).size.height) - (MediaQuery.of(context).size.height*0.15),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                                    style: TextStyle(fontSize: SizeConfig().textSize(context, 3.5)),
                                    decoration: InputDecoration(
                                      hintText: 'Enter Title',
                                      hintStyle: TextStyle(fontSize: SizeConfig().textSize(context, 3.5), fontWeight: FontWeight.w400, color: Provider.of<ThemeNotifier>(context, listen: false).isDarkModeOn ? Colors.grey[400] : Colors.grey[600]),
                                      contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                  ),
                                  TextFormField(
                                    maxLines: null,
                                    minLines: SizeConfig().yMargin(context, 2.7).round(),
                                    maxLengthEnforced: false,
                                    keyboardType: TextInputType.multiline,
                                    style: TextStyle(fontSize: SizeConfig().textSize(context, 2.1)),
                                    decoration: InputDecoration(
                                      hintText: 'Enter your note here...',
                                      hintStyle: TextStyle(fontSize: SizeConfig().textSize(context, 2.1), color: Provider.of<ThemeNotifier>(context, listen: false).isDarkModeOn ? Colors.grey[400] : Colors.grey[600]),
                                      contentPadding: new EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
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
              padding: EdgeInsets.only(top: 10, left: 12, right: 12, bottom: MediaQuery.of(context).viewInsets.bottom,),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide( //                    <--- top side
                    color: lightwhite,
                    width: 1.0,
                  ),
                )
              ),
              child: GestureDetector(
                onTap: (){},
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
                      child: Text(
                        'Add image',
                        style: Theme.of(context).textTheme.headline4.copyWith(fontSize: SizeConfig().textSize(context, 1.9))
                      ),
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
}