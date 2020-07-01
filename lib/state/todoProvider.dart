
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:team_mobileforce_gong/models/todos.dart';

class TodoProvider with ChangeNotifier{
  String value;
  String hValue;
  List<String> drop = ['No Reminder', 'Next 10 mins', 'Next 30 mins', 'Next 1 hour', 'Custom Reminder'];
  final dformat = new DateFormat('dd/MM/yy');
  List<Todos> todos = [];
  Map<String,String> headers = {'Content-type': 'application/json','Accept': 'application/json'};

  void completed(bool val, int index) {
    todos[index].completed = !val;
  }

  void setValue(DateTime date, TimeOfDay time, BuildContext context){
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    if(dformat.format(date) == dformat.format(DateTime.now())) {
      //print(localizations.formatTimeOfDay(time));
      hValue = 'Remind me at '+localizations.formatTimeOfDay(time);
    } else {
      hValue = 'Reminder for '+dformat.format(date).toString()+' '+localizations.formatTimeOfDay(time);
    }
  }

  void fetch(String uid) async{
    await http.post(
      'http://gonghng.herokuapp.com/todo/user',
      body: jsonEncode({
        'userId': uid
      }),
      headers:headers
    ).then((value){
      var jsonRes = convert.jsonDecode(value.body) as List;
      todos = jsonRes.map((e) => Todos.fromJson(e)).toList();
      notifyListeners();
    });
  }

  void createTodo(String title, String uid, String content, DateTime date, TimeOfDay time) async {
    print(title);
    await post(
      'http://gonghng.herokuapp.com/todo',
      body: jsonEncode({
        'title': title,
        'userID': uid,
        'time': time.hour.toString()+':'+time.minute.toString(),
        'completed': 'false',
        'date': dformat.format(date).toString()
      }),
      headers: headers
    ).then((value){
      print(value.body);
      hValue = null;
      fetch(uid);
    });
  }
}