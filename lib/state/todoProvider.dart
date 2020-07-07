
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:team_mobileforce_gong/models/todo.dart';
import 'dart:convert' as convert;
import 'package:team_mobileforce_gong/models/todos.dart';
import 'package:team_mobileforce_gong/state/authProvider.dart';
import 'package:team_mobileforce_gong/util/dbhelper.dart';

class TodoProvider with ChangeNotifier{
  DbHelper helper = DbHelper();
  String value;
  String hValue;
  List<String> drop = ['No Reminder', 'Next 10 mins', 'Next 30 mins', 'Next 1 hour', 'Custom Reminder'];
  final dformat = new DateFormat('dd/MM/yy');
  List<Todos> todos = [];
  Map<String,String> headers = {'Content-type': 'application/json','Accept': 'application/json'};
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TodoProvider() {
//     fetch();
    getData();
  }

  void completed(bool val, int index) {
    todos[index].isCompleted = !val;
  }

  void setVal(String val) {
    value = val;
    notifyListeners();
  }

  Future getUser() async {
    final FirebaseUser user = await _auth.currentUser();
    if(user != null){
      return user;
    }
    return null;
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
    ).then((value) {
      var jsonRes = convert.jsonDecode(value.body) as List;
      todos = jsonRes.map((e) => Todos.fromJson(e)).toList();
    });
      notifyListeners();
  }

  List<Todos> getData() {
    final dbFuture = helper.initializeDb();
    List<Todos> todoList = List<Todos>();
    dbFuture.then((result) {
      final todosFuture = helper.getTodos();
      todosFuture.then((result) {
        int count = result.length;
        for (int i = 0; i < count; i++) {
          todoList.add(Todos.fromObject(result[i]));
        }
        todos =  todoList;
      });
    });
    notifyListeners();
    return todoList;


  }


  void createTodo(Todos todo) async {
    FirebaseUser user = await getUser();
    todo.userID = user.uid;
    print(todo.title);
    await post(
      'http://gonghng.herokuapp.com/todo',
      body: jsonEncode({
        'title': todo.title,
        'userID': todo.userID,
        'time': todo.time,
        'completed': 'false',
        'date': todo.date,
      }),
      headers: headers
    ).then((value){
      print(value.body);
      hValue = null;
      fetch(todo.userID);
    });
  }

//method to insert the todo into the sqlite database.
  void save(Todos todo) async {
    if (todo.id != null) {
      helper.updateTodo(todo);
    }
    else {
      helper.insertTodo(todo);
    }
    getData();
  }

  bool isTodoCompleted(int value){
    if(value == 1){
      return true;
    }else{
      return false;
    }
  }

        Color getBackgroundColor(int backgroundColor) {
          switch(backgroundColor){
            case 1:
              return Colors.white;
              break;
            case 2:
              return Colors.red;
              break;
            case 3:
              return Colors.yellow;
              break;
            case 4:
              return Colors.lightBlue;
              break;
            default:
              return Colors.white;
          }
        }
}