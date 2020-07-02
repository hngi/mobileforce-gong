import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:team_mobileforce_gong/services/quotes/quote.dart';
import 'package:team_mobileforce_gong/services/quotes/quoteState.dart';

import 'util.dart';

class QuoteService {
  Future<List<Quote>> getAllQuotes(QuoteState quoteState) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      Response response =
          await http.get(quoteUrl, headers: headers);
      if (response.statusCode != 200) {
        print('Some error occured');
        return null;
      }

      List<Quote> _finalQuote = [];
      List apiData = json.decode(response.body);

      for (var i = 0; i < apiData.length; i++) {
        _finalQuote.add(Quote(
            quote: apiData[i]['quote'],
            author: apiData[i]['author'],
            id: apiData[i]['_id'],
            ));
      }

      quoteState.quoteList = _finalQuote;
      print(_finalQuote.length);
      return _finalQuote;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
