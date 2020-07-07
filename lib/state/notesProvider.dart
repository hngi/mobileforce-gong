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

import 'package:team_mobileforce_gong/util/noteDbhelper.dart';

class NotesProvider with ChangeNotifier{
  NoteDbhelper helper = new NoteDbhelper();
  List<Notes> notes = [];
  var dateFormat = DateFormat("dd/MM/yy");
  Map<String,String> headers = {'Content-type': 'application/json','Accept': 'application/json'};

   NotesProvider() {
//     fetch();
   getData();
   }

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
        'important': 'false',
        'date': dateFormat.format(DateTime.now()).toString()
      }),
      headers: headers
    ).then((value){
      fetch(uid);
    });
  }


  void save(Notes note) async {
    note.date = new DateFormat.yMd().format(DateTime.now());
    if (note.id != null) {
      helper.updateNote(note);
    }
    else {
      helper.insertNote(note);
    }
    print("Saved Note ${note.title}");
    int count  = await helper.getCount();
    print(count.toString() + "Notes Provider,save method");
    getData();
  }

  List<Notes> getData() {
    final dbFuture = helper.initializeDb();
    List<Notes> noteList = List<Notes>();
    dbFuture.then((result) {
      final notesFuture = helper.getNotes();
      notesFuture.then((result) {
        int count = result.length;
        for (int i = 0; i < count; i++) {
          noteList.add(Notes.fromObject(result[i]));
        }
        notes =  noteList;
      });
    });
    notifyListeners();
    print(noteList.length.toString() + "get data method, note count.");
    return noteList;


  }
}