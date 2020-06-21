import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/UI/screens/add_note.dart';
import 'package:team_mobileforce_gong/UI/theme_notifier.dart';
import 'package:team_mobileforce_gong/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/styles/color.dart';

class ShowNotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Hey Tayo',
          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().textSize(context, 3),),
        ),
        leading: GestureDetector(
          onTap: (){},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: SvgPicture.asset(
              'assets/svgs/ham.svg',
              color: Provider.of<ThemeNotifier>(context, listen: false).isDarkModeOn ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.35),
              child: Text(
                'Click the + button Below to get started',
                style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().textSize(context, 2.1),),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: SvgPicture.asset(
                        'assets/svgs/folder.svg',
                        width: SizeConfig().yMargin(context, 13.1),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'No Activities Yet',
                        style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().textSize(context, 3), fontWeight: FontWeight.bold, color: blue),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.55,
                      child: Text(
                        'Click the “+” button to add your first to-do',
                        style: Theme.of(context).textTheme.headline4.copyWith(fontSize: SizeConfig().textSize(context, 1.9)),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNote())),
      ),
    );
  }
}