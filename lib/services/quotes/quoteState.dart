import 'package:flutter/cupertino.dart';
import 'package:team_mobileforce_gong/services/quotes/quote.dart';
import 'package:team_mobileforce_gong/services/quotes/quoteApi.dart';

class QuoteState with ChangeNotifier {
  QuoteService quoteService = QuoteService();

  List<Quote> _quoteList = [];

  List<Quote> get quoteList =>  _quoteList;

  set quoteList(List<Quote> quoteList){
    _quoteList = quoteList;
    notifyListeners();
  }
}