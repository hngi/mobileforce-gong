import 'dart:async';
import 'dart:convert';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:team_mobileforce_gong/models/todos.dart';
import 'package:team_mobileforce_gong/util/GongDbhelper.dart';
import 'package:uuid/uuid.dart';

class TodoProvider with ChangeNotifier {
  String value;
  String hValue;
  List<String> drop = [
    'No Reminder',
    'Next 10 mins',
    'Next 30 mins',
    'Next 1 hour',
    'Custom Reminder'
  ];
  final dformat = new DateFormat('dd/MM/yy');
  List<Todos> todos = [];
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };
  String error;
  bool select = false;
  List<Todos> deletes = [];
  StreamSubscription<DataConnectionStatus> createListener;
  StreamSubscription<DataConnectionStatus> updateListener;
  StreamSubscription<DataConnectionStatus> completedListener;
  StreamSubscription<DataConnectionStatus> deleteListener;
  var uuid = Uuid();

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

  void setValue(DateTime date, TimeOfDay time, BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    value = null;
    if (dformat.format(date) == dformat.format(DateTime.now())) {
      //print(localizations.formatTimeOfDay(time));
      hValue = 'Remind me at ' + localizations.formatTimeOfDay(time);
    } else {
      hValue = 'Reminder for ' +
          dformat.format(date).toString() +
          ' ' +
          localizations.formatTimeOfDay(time);
    }
  }

  // void fetch(String uid) async{
  //  await http.get(
  //     'http://gonghng.herokuapp.com/todo/user/$uid',
  //     headers:headers
  //   ).then((value) {
  //     var jsonRes = convert.jsonDecode(value.body) as List;
  //     todos = jsonRes.map((e) => Todos.fromJson(e)).toList();
  //   });
  //     notifyListeners();}

  void setVal(String val) {
    value = val;
    notifyListeners();
  }

  void fetch(String uid, bool newUser) async {
    if (newUser == true) {
      await http
          .get('http://gonghng.herokuapp.com/todo/user/$uid', headers: headers)
          .then((value) async {
        var jsonRes = convert.jsonDecode(value.body) as List;
        List<Todos> todoss = (jsonRes.map((e) => Todos.fromJson2(e)).toList());
        if (todoss.isNotEmpty) {
          for (int i = 0; i < todoss.length; i++) {
            GongDbhelper().insertTodoFromDb(todoss[i]);
          }
        }
        await GongDbhelper().getTodos().then((value) {
          todos = value.map((e) => Todos.fromJson(e)).toList();
          notifyListeners();
        }).then((value) {});
      });
    }

    await GongDbhelper().getTodos().then((value) {
      todos = value.map((e) => Todos.fromJson(e)).toList();
      notifyListeners();
    }).then((value) {
      createDataFunc();
      updateDataFunc();
      deleteDataFunc();
    });
  }

  void createTodo(String title, String category, String uid, String content,
      DateTime date, TimeOfDay time) async {
    print(uuid.v4());
    Todos todo = new Todos(
      sId: uuid.v4(),
      title: title,
      userID: uid,
      time: time != null
          ? time.hour.toString() + ':' + time.minute.toString()
          : null,
      completed: false,
      date: date == null ? null : dformat.format(date).toString(),
      content: content,
      category: category,
      uploaded: false,
      shouldUpdate: false,
    );
    await GongDbhelper().insertTodo(todo).then((value) {
      hValue = null;
      todos.insert(0, todo);
      notifyListeners();
    }).then((value) {
      print('1');
      createDataFunc();
    });
    // print(time);
  }

  void updateTodo(String title, String category, String uid, String content,
      DateTime date, TimeOfDay time, Todos todo) async {
    int index = todos.indexOf(todo);
    //String id = todos[index].sId;

    Todos utodo = new Todos(
        sId: todo.sId,
        title: title,
        userID: uid,
        time: time != null
            ? time.hour.toString() + ':' + time.minute.toString()
            : null,
        completed: false,
        date: date == null ? null : dformat.format(date).toString(),
        content: content,
        category: category,
        uploaded: todo.uploaded,
        shouldUpdate: true);

    await GongDbhelper().updateTodo(utodo).then((value) {
      todos[index].title = title;
      todos[index].content = content;
      todos[index].category = category;
      todos[index].completed = false;
      todos[index].date = dformat.format(date).toString();
      todos[index].time = time != null
          ? time.hour.toString() + ':' + time.minute.toString()
          : null;
      notifyListeners();
    }).then((value) {
      updateDataFunc();
    });
  }

  void updateCompleted(
      String title,
      String category,
      String uid,
      String content,
      String date,
      String time,
      bool completed,
      Todos todo) async {
    int index = todos.indexOf(todo);
    String id = todos[index].sId;
    print('1');

    Todos utodo = new Todos(
        sId: todo.sId,
        title: title,
        userID: uid,
        time: time,
        completed: completed,
        date: date,
        content: content,
        category: category,
        uploaded: todo.uploaded,
        shouldUpdate: true);

    await GongDbhelper().updateTodo(utodo).then((value) {
      todos[index].title = title;
      todos[index].content = content;
      todos[index].category = category;
      todos[index].completed = completed;
      todos[index].date = date;
      todos[index].time = time;
      todos[index].shouldUpdate = true;
      notifyListeners();
    }).then((value) {
      print('2');
      updateComDataFunc();
    });
  }

  void deleteTodo() async {
    for (var todo in deletes) {
      String id = todo.sId;
      int index = todos.indexOf(todo);

      await GongDbhelper().insertDeleteTodo(todo);

      await GongDbhelper().deleteTodo(id).then((value) {
        todos.removeAt(index);
        notifyListeners();
      });
    }
    setSelect();
    deletes = [];
    deleteDataFunc();
  }

  void createDataFunc() {
    print('h');
    createListener =
        DataConnectionChecker().onStatusChange.listen((event) async {
      print(event);
      switch (event) {
        case DataConnectionStatus.connected:
          print(event);
          for (var t in todos) {
            print(t.uploaded);
            if (!t.uploaded) {
              print('2');
              await post('http://gonghng.herokuapp.com/todo',
                      body: jsonEncode({
                        'todoID': t.sId,
                        'title': t.title,
                        'userID': t.userID,
                        'time': t.time,
                        'completed': t.completed,
                        'content': t.content,
                        'category': t.category,
                        'date': t.date
                      }),
                      headers: headers)
                  .then((value) async {
                print(value.body);
                if (value.statusCode == 200) {
                  Todos utodo = new Todos(
                      sId: t.sId,
                      title: t.title,
                      userID: t.userID,
                      time: t.time,
                      completed: t.completed,
                      date: t.date,
                      content: t.content,
                      category: t.category,
                      uploaded: true,
                      shouldUpdate: t.shouldUpdate);
                  await GongDbhelper().updateTodo(utodo);

                  todos[todos.indexOf(t)].uploaded = true;
                }
              });
            }
          }
          createListener.cancel();
          notifyListeners();
          break;
        case DataConnectionStatus.disconnected:
          print('jnjn');
          int check = 0;
          for (var t in todos) {
            if (!t.uploaded) check += 1;
          }
          if (check == 0) {
            createListener.cancel();
          }
          break;
      }
    });
  }

  void updateDataFunc() {
    updateListener =
        DataConnectionChecker().onStatusChange.listen((event) async {
      switch (event) {
        case DataConnectionStatus.connected:
          for (var t in todos) {
            if (t.shouldUpdate) {
              await http
                  .put('http://gonghng.herokuapp.com/todo',
                      body: jsonEncode({
                        //'reminderId': todos[index].sId,
                        'todoID': t.sId,
                        'title': t.title,
                        'content': t.content,
                        'category': t.category,
                        'date': t.date,
                        'completed': t.completed,
                        'time': t.time,
                      }),
                      headers: headers)
                  .then((value) async {
                Todos utodo = new Todos(
                    sId: t.sId,
                    title: t.title,
                    userID: t.userID,
                    time: t.time,
                    completed: t.completed,
                    date: t.date,
                    content: t.content,
                    category: t.category,
                    uploaded: t.uploaded,
                    shouldUpdate: false);
                await GongDbhelper().updateTodo(utodo);

                todos[todos.indexOf(t)].shouldUpdate = false;
              });
            }
          }
          updateListener.cancel();
          notifyListeners();
          break;
        case DataConnectionStatus.disconnected:
          int check = 0;
          for (var t in todos) {
            if (t.shouldUpdate) check += 1;
          }
          if (check == 0) {
            updateListener.cancel();
          }
          break;
      }
    });
  }

  void updateComDataFunc() {
    print('3');
    completedListener =
        DataConnectionChecker().onStatusChange.listen((event) async {
      switch (event) {
        case DataConnectionStatus.connected:
          print('4');
          for (var t in todos) {
            if (t.shouldUpdate) {
              print(t.completed);
              await http
                  .put('http://gonghng.herokuapp.com/todo',
                      body: jsonEncode({
                        //'reminderId': todos[index].sId,
                        'todoID': t.sId,
                        'title': t.title,
                        'content': t.content,
                        'category': t.category,
                        'completed': t.completed,
                        'date': t.date,
                        'time': t.time,
                      }),
                      headers: headers)
                  .then((value) async {
                print(value.body);
                Todos utodo = new Todos(
                    sId: t.sId,
                    title: t.title,
                    userID: t.userID,
                    time: t.time,
                    completed: t.completed,
                    date: t.date,
                    content: t.content,
                    category: t.category,
                    uploaded: t.uploaded,
                    shouldUpdate: false);
                await GongDbhelper().updateTodo(utodo);

                todos[todos.indexOf(t)].shouldUpdate = false;
              });
            }
          }
          completedListener.cancel();
          notifyListeners();
          break;
        case DataConnectionStatus.disconnected:
          int check = 0;
          for (var t in todos) {
            if (t.shouldUpdate) check += 1;
          }
          if (check == 0) {
            completedListener.cancel();
          }
          break;
      }
    });
  }

  void deleteDataFunc() async {
    await GongDbhelper().getDeleteTodos().then((value) {
      deletes = value.map((e) => Todos.fromJson(e)).toList();
    }).then((value) {
      deleteListener =
          DataConnectionChecker().onStatusChange.listen((event) async {
        switch (event) {
          case DataConnectionStatus.connected:
            for (var t in deletes) {
              final request = http.Request(
                  'DELETE', Uri.parse('http://gonghng.herokuapp.com/todo'));
              request.headers.addAll(headers);
              request.body = jsonEncode({"todoID": t.sId});
              await request.send().then((value) async {
                await GongDbhelper().deleteStoreTodo(t.sId).then((value) {
                  deletes.removeAt(deletes.indexOf(t));
                });
              });
            }
            deleteListener.cancel();
            notifyListeners();
            break;
          case DataConnectionStatus.disconnected:
            if (deletes.length == 0) {
              deleteListener.cancel();
            }
            break;
        }
      });
    });
  }
}
