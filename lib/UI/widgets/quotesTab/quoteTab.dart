import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/services/navigation/page_transitions/animations.dart';
import 'package:team_mobileforce_gong/services/quotes/quote.dart';
import 'package:team_mobileforce_gong/services/quotes/quoteApi.dart';
import 'package:team_mobileforce_gong/services/quotes/quoteState.dart';
import 'package:team_mobileforce_gong/services/responsiveness/responsiveness.dart';

class QuoteTab extends StatefulWidget {
  @override
  _QuoteTabState createState() => _QuoteTabState();
}

class _QuoteTabState extends State<QuoteTab> {
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
              timer()
          });
    });
    super.initState();
  }

  Future<void> timer() async {
    Timer(Duration(seconds: 8), () {
      setState(() {
        populated = false;
      });
      print(populated);
    });
  }

  @override
  Widget build(BuildContext context) {
    return populated
        ? Container(
            // constraints: BoxConstraints.loose(Size.fromHeight(100)),
            decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            width: SizeConfig().xMargin(context, 110),
            height: SizeConfig().yMargin(context, 18),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      quote.quote ?? '',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: SizeConfig().textSize(context, 2.3)),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text('-' + quote.author ?? '',
                          style: GoogleFonts.aBeeZee(
                              color: Colors.white,
                              fontSize: SizeConfig().textSize(context, 2))),
                    ),
                  )
                ],
              ),
            ))
        : SizedBox();
  }
}
