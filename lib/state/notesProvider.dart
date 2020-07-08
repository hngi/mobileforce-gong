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

  String error;
  bool select = false;
  List<Notes> deletes = [];

   NotesProvider() {
//     fetch();
   getData();
   }

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


  void save(Notes note) async {
    note.date = new DateFormat.yMd().format(DateTime.now());
    if (note.id != null) {
      helper.updateNote(note);
    }
    else {
      helper.insertNote(note);
    }
    print("Saved Note ${note.title}");
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


  void setSelect() {
    select = !select;
    deletes = [];
    notifyListeners();
  }

  void addDelete(Notes note) {
    deletes.add(note);
    notifyListeners();
  }

  void removeDeletes(int index) {
    deletes.removeAt(index);
    notifyListeners();
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
  void deleteNote() async {
    for(var note in deletes) {
      //print(note.sId);
      String id = note.sId;
      int index = notes.indexOf(note);
      await delete(
          'http://gonghng.herokuapp.com/notes/$id',
          headers: headers
      ).then((value){
        print(value.body);
        notes.removeAt(index);
        notifyListeners();
      });
    }
    setSelect();
  }


}