
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
  String error;
  bool select = false;
  List<Todos> deletes = [];

  void setSelect() {
    select = !select;
    deletes = [];
    notifyListeners();
  }

  void addDelete(Todos todo) {
    deletes.add(todo);
    notifyListeners();
  }

  void removeDeletes(int index) {
    deletes.removeAt(index);
    notifyListeners();
  }

  void completed(bool val, int index) {
    todos[index].completed = !val;
  }

  void setValue(DateTime date, TimeOfDay time, BuildContext context){
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    value = null;
    if(dformat.format(date) == dformat.format(DateTime.now())) {
      //print(localizations.formatTimeOfDay(time));
      hValue = 'Remind me at '+localizations.formatTimeOfDay(time);
    } else {
      hValue = 'Reminder for '+dformat.format(date).toString()+' '+localizations.formatTimeOfDay(time);
    }
  }

  void setVal(String val) {
    value = val;
    notifyListeners();
  }

  void fetch(String uid) async{
    await http.get(
      'http://gonghng.herokuapp.com/todo/user/$uid',
      headers:headers
    ).then((value){
      var jsonRes = convert.jsonDecode(value.body) as List;
      todos = jsonRes.map((e) => Todos.fromJson(e)).toList();
      notifyListeners();
    });
  }

  void createTodo(String title, String category, String uid, String content, DateTime date, TimeOfDay time) async {
    print(time);
    await post(
      'http://gonghng.herokuapp.com/todo',
      body: jsonEncode({
        'title': title,
        'userID': uid,
        'time': time != null ? time.hour.toString()+':'+time.minute.toString() : null,
        'completed': false,
        'content': content,
        'category': category,
        'date': date == null ? null : dformat.format(date).toString()
      }),
      headers: headers
    ).then((value){
      print(value.body);
      hValue = null;
      value = null;
      Todos todo = new Todos(title: title, content: content, userID: uid, category: category, time: time != null ? time.hour.toString()+':'+time.minute.toString() : null, date: date == null ? null : dformat.format(date).toString(), completed: false);
      todos.insert(0, todo);
      notifyListeners();
    });
  }

  void updateTodo(String title, String category, String uid, String content, DateTime date, TimeOfDay time, Todos todo) async {
    int index = todos.indexOf(todo);
    String id = todos[index].sId;
    await http.put(
      'http://gonghng.herokuapp.com/todo/$id',
      body: jsonEncode({
        //'reminderId': todos[index].sId,
        'title': title,
        'content': content,
        'category': category,
        'date': dformat.format(date).toString(),
        'completed': false,
        'time': time != null ? time.hour.toString()+':'+time.minute.toString() : null,
      }),
      headers: headers
    ).then((value){
      todos[index].title = title;
      todos[index].content = content;
      todos[index].category = category;
      todos[index].completed = false;
      todos[index].date = dformat.format(date).toString();
      todos[index].time = time != null ? time.hour.toString()+':'+time.minute.toString() : null;
      notifyListeners();
    });
  }

  void updateCompleted(String title, String category, String uid, String content, String date, String time, bool completed, Todos todo) async {
    int index = todos.indexOf(todo);
    String id = todos[index].sId;
    await http.put(
      'http://gonghng.herokuapp.com/todo/$id',
      body: jsonEncode({
        //'reminderId': todos[index].sId,
        'title': title,
        'content': content,
        'category': category,
        'completed' : completed,
        'date': date,
        'time': time,
      }),
      headers: headers
    ).then((value){
      todos[index].title = title;
      todos[index].content = content;
      todos[index].category = category;
      todos[index].completed = completed;
      todos[index].date = date;
      todos[index].time = time;
      notifyListeners();
    });
  }
  void deleteTodo() async {
    for(var todo in deletes) {
      String id = todo.sId;
      int index = todos.indexOf(todo);
      await delete(
        'http://gonghng.herokuapp.com/todo/$id',
        headers: headers
      ).then((value){
        print(value.body);
        todos.removeAt(index);
        notifyListeners();
      });
    }
    setSelect();
  }
}