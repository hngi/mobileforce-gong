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

import 'showQuotes.dart';

enum QuoteType { Facts, Motivation }

class Facts extends StatefulWidget {
  final QuoteType quoteType;

  const Facts({Key key, this.quoteType}) : super(key: key);

  @override
  _FactsState createState() => _FactsState();
}

class _FactsState extends State<Facts> {
  QuoteService quoteService = QuoteService();
  final random = Random();
  bool populated = false;
  bool populated2 = false;
  List<Quote> quotes = [];
  List<Quote> facts = [];

  Quote quote = Quote(author: '', quote: '', id: '');
  Quote fact = Quote(author: '', quote: '', id: '');

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      QuotesDatabase.db.getAllClients().then((value) => {
            for (int i = 0; i < value.length; i++)
              {
                if (value[i].author != 'Facts')
                  {
                    quotes.add(value[i]),
                    if (quotes.length > 1)
                      {
                        print(quotes.length),
                        setState(() {
                          quote = quotes[random.nextInt(value.length)];
                          populated2 = true;
                          print(quote.quote);
                        })
                      }
                    else
                      {
                        setState(() {
                          quote = quotes[0];
                          populated2 = true;
                          print(quote.quote);
                        })
                      }
                  }
                else
                  {
                    facts.add(value[i]),
                    if (facts.length > 1)
                      {
                        setState(() {
                          fact = facts[random.nextInt(value.length)];
                          populated = true;
                          print(fact.quote);
                          print(facts.length);
                        })
                      }
                    else
                      {
                        setState(() {
                          fact = facts[0];
                          populated = true;
                          print(fact.quote);
                        })
                      }
                  }
              }
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
      floatingActionButton: FloatingActionButton.extended(
        label: Text('View More'),
        onPressed: () => Get.to(ShowQuotes()),
      ),
      appBar: AppBar(
        actions: [
          widget.quoteType == QuoteType.Motivation
              ? quotes.length > 1
                  ? RaisedButton(
                      color: darktheme ? Color(0xff0D141A) : null,
                      elevation: 0,
                      onPressed: () {
                        setState(() {
                          quote =
                              quotes[random.nextInt(state.quoteList.length)];
                          populated = true;
                        });
                      },
                      child: Text('Next',
                          style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig().textSize(context, 2.4),
                              color: darktheme ? Colors.white : Colors.black)))
                  : Container()
              : facts.length > 1
                  ? RaisedButton(
                      color: darktheme ? Color(0xff0D141A) : null,
                      elevation: 0,
                      onPressed: () {
                        setState(() {
                          quote =
                              quotes[random.nextInt(state.quoteList.length)];
                          populated = true;
                        });
                      },
                      child: Text('Next',
                          style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig().textSize(context, 2.4),
                              color: darktheme ? Colors.white : Colors.black)))
                  : Container(),
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: darktheme ? Colors.white : Colors.black),
            onPressed: () => Get.back()),
        title: Text(
            widget.quoteType == QuoteType.Facts
                ? 'Saved Facts'
                : 'Saved Quotes',
            style: GoogleFonts.aBeeZee(
                color: darktheme ? Colors.white : Colors.black)),
      ),
      // backgroundColor: darktheme ? Color(0xff0D141A) : Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: widget.quoteType == QuoteType.Facts
              ? populated
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
                              widget.quoteType == QuoteType.Motivation
                                  ? quote.quote ?? ''
                                  : fact.quote,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.aBeeZee(
                                  color:
                                      darktheme ? Colors.white : Colors.black,
                                  fontSize:
                                      SizeConfig().textSize(context, 2.3)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                  '- ${widget.quoteType == QuoteType.Motivation ? quote.author ?? '' : fact.author}' ??
                                      '',
                                  style: GoogleFonts.aBeeZee(
                                      color: darktheme
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize:
                                          SizeConfig().textSize(context, 2))),
                            ),
                          )
                        ],
                      ),
                    )
                  : Text('No saved Facts',
                      style: GoogleFonts.aBeeZee(
                          color: darktheme ? Colors.white : Colors.black))
              : populated2
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
                              widget.quoteType == QuoteType.Motivation
                                  ? quote.quote ?? ''
                                  : fact.quote,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.aBeeZee(
                                  color:
                                      darktheme ? Colors.white : Colors.black,
                                  fontSize:
                                      SizeConfig().textSize(context, 2.3)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                  '- ${widget.quoteType == QuoteType.Motivation ? quote.author ?? '' : fact.author}' ??
                                      '',
                                  style: GoogleFonts.aBeeZee(
                                      color: darktheme
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize:
                                          SizeConfig().textSize(context, 2))),
                            ),
                          )
                        ],
                      ),
                    )
                  : Text('No saved Quotes',
                      style: GoogleFonts.aBeeZee(
                          color: darktheme ? Colors.white : Colors.black)),
        ),
      ),
    );
  }
}
