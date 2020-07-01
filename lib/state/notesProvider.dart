import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/models/note_model.dart';
import 'package:team_mobileforce_gong/services/auth/auth.dart';
import 'package:team_mobileforce_gong/state/authProvider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NotesProvider with ChangeNotifier{
  List<Notes> notes = [];
  var dateFormat = DateFormat("dd/MM/yy");
  Map<String,String> headers = {'Content-type': 'application/json','Accept': 'application/json'};

  // NotesProvider() {
  //   fetch();
  // }

  void fetch(String uid) async{
    await http.post(
      'http://gonghng.herokuapp.com/notes/user',
      body: jsonEncode({
        'userId': uid
      }),
      headers: headers
    ).then((value){
      var jsonres = convert.jsonDecode(value.body) as List;
      notes = jsonres.map((e) => Notes.fromJson(e)).toList();
      notifyListeners();
    });
    
  }

  void createNote(String uid, String title, String content, bool important) async{
    print(title);
    await post(
      'http://gonghng.herokuapp.com/notes',
      body: jsonEncode({
        'title': title,
        'content': content,
        'userID': uid,
        'important': important,
        'date': dateFormat.format(DateTime.now()).toString()
      }),
      headers: headers
    ).then((value){
      fetch(uid);
    });
  }
}