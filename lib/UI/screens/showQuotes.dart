import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/services/quotes/quote.dart';
import 'package:team_mobileforce_gong/services/quotes/quoteApi.dart';
import 'package:team_mobileforce_gong/services/quotes/quoteDb.dart';
import 'package:team_mobileforce_gong/services/quotes/quoteState.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';
import 'package:team_mobileforce_gong/state/theme_notifier.dart';

class ShowQuotes extends StatefulWidget {
  @override
  _ShowQuotesState createState() => _ShowQuotesState();
}

class _ShowQuotesState extends State<ShowQuotes> {
  QuoteService quoteService = QuoteService();
  final random = Random();
  bool populated = false;

  Quote quote = Quote(author: '', quote: '', id: '');

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      QuoteState quoteState = Provider.of<QuoteState>(context, listen: false);
      quoteService.getAllQuotes(quoteState).then((value) => {
            if (quoteState.quoteList.isNotEmpty)
              {
                setState(() {
                  quote = quoteState
                      .quoteList[random.nextInt(quoteState.quoteList.length)];
                  populated = true;
                  print(quote.quote);
                })
              },
          });
    });
    super.initState();
  }

  var darktheme;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<QuoteState>(context);
    darktheme = Provider.of<ThemeNotifier>(context).isDarkModeOn ?? false;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: [
         populated ? RaisedButton(
              color: darktheme ? Color(0xff0D141A) : null,
              elevation: 0,
              onPressed: () {
                setState(() {
                  quote =
                      state.quoteList[random.nextInt(state.quoteList.length)];
                  populated = true;
                });
              },
              child: Text('Next',
                  style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig().textSize(context, 2.4),
                      color: darktheme ? Colors.white : Colors.black))) :Container(),
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: darktheme ? Colors.white : Colors.black),
            onPressed: () => Get.back()),
        title: Text(quote.author == 'Facts' ? 'Did you know?' : 'Quotes',
            style: GoogleFonts.aBeeZee(
                color: darktheme ? Colors.white : Colors.black)),
      ),
      // backgroundColor: darktheme ? Color(0xff0D141A) : Colors.white,
      floatingActionButton: populated
          ? FloatingActionButton.extended(
              onPressed: () {
                QuotesDatabase.db
                    .newQuote(Quote(author: quote.author, quote: quote.quote));
                scaffoldKey.currentState.showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Save successfully'),
                ));
              },
              label: Text(quote.author == 'Facts' ? 'Save Fact' : 'Save Quote'),
            )
          : Container(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: populated
              ? Container(
                  width: 400,
                  height: SizeConfig().yMargin(context, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          quote.quote ?? '',
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.aBeeZee(
                              color: darktheme ? Colors.white : Colors.black,
                              fontSize: SizeConfig().textSize(context, 2.3)),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text('-' + quote.author ?? '',
                              style: GoogleFonts.aBeeZee(
                                  color:
                                      darktheme ? Colors.white : Colors.black,
                                  fontSize: SizeConfig().textSize(context, 2))),
                        ),
                      )
                    ],
                  ),
                )
              : Text('Nothing to show. Check your internet Connection',
                  style: GoogleFonts.aBeeZee(
                      color: darktheme ? Colors.white : Colors.black)),
        ),
      ),
    );
  }
}
