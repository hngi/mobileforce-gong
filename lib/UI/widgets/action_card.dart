import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/state/theme_notifier.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';

class ActionCard extends StatefulWidget {
  final String svg;
  final String title;
  final String text;
  final Function onPressed;

  const ActionCard({Key key, this.svg, this.title, this.text, this.onPressed}) : super(key: key);

  @override
  _ActionCardState createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  var darktheme;

  @override
  Widget build(BuildContext context) {
    darktheme = Provider.of<ThemeNotifier>(context).isDarkModeOn ?? false;
    return InkWell(
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        decoration: BoxDecoration(
          color: darktheme ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Ink(
          height: SizeConfig().yMargin(context, 18),
          width: SizeConfig().xMargin(context, 40.3),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: SvgPicture.asset(
                    widget.svg,
                    width: SizeConfig().yMargin(context, 4.9),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 3),
                      child: Text(
                        widget.title,
                        style: Theme.of(context).textTheme.headline6.copyWith(fontSize: SizeConfig().textSize(context, 2.1), fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: Text(
                        widget.text,
                        style: Theme.of(context).textTheme.headline4.copyWith(fontSize: SizeConfig().textSize(context, 2)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}