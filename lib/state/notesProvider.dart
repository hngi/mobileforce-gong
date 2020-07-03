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
  String error;

  // NotesProvider() {
  //   fetch();
  // }

  void fetch(String uid) async{
    await http.get(
      'http://gonghng.herokuapp.com/notes/user/$uid',
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
        'date': dateFormat.format(DateTime.now()).toString(),
        'important': important,
      }),
      headers: headers
    ).then((value){
      print(value.body);
      Notes note = new Notes(sId: uid, title: title, content: content, important: important, date: dateFormat.format(DateTime.now()).toString());
      notes.insert(0, note);
      notifyListeners();
    });
  }

  void updateNote(String uid, String title, String content, bool important, Notes note) async {
    
    int index = notes.indexOf(note);
    String id = notes[index].sId;
    print(id);
    //print(index);
    await put(
      'http://gonghng.herokuapp.com/notes/$id',
      body: jsonEncode({
        //'noteId': notes[index].sId,
        'title': title,
        'content': content,
        'important': important,
      }),
      headers: headers
    ).catchError((error) => print(error))
    .then((value){
      print(value.body);
      notes[index].title = title;
      notes[index].content = content;
      notes[index].important =important;
      notifyListeners();
    });
  }
}