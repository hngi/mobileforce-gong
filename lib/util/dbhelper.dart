
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:team_mobileforce_gong/models/todos.dart';

class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();
  String tblTodo = "todo";
  String colId = "id";
  String colTitle = "title";
  String colTime = "time";
  String colCompleted = "completed";
  //date of Creation.
  String colUpdatedDate = "updateddate";
  String colDate = "date";
  String colBackgroundColor = "backgroundcolor";

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "todos.db";

    var dbTodos = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbTodos;
  }

  void _createDb(Database db, int newVersion) async
  {
    await db.execute(
        "CREATE TABLE $tblTodo($colId INTEGER PRIMARY KEY, $colTitle TEXT, " +
            "$colTime TEXT, $colUpdatedDate TEXT, $colCompleted INTEGER, $colBackgroundColor INTEGER, $colDate TEXT)");
  }

  Future<int> insertTodo(Todos todo) async {
    Database db = await this.db;
    var result = await db.insert(tblTodo, todo.toMap());
    return result;
  }

  Future<List> getTodos() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM $tblTodo order by $colId ASC");
    return result;
  }

  Future<List> searchTodo(String query) async {
    Database db = await this.db;
    var result = await db.rawQuery
      ("SELECT * FROM $tblTodo WHERE $colTime LIKE '%$query%' UNION  SELECT * FROM $tblTodo WHERE $colTitle LIKE '%$query%' ");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("select count (*) from $tblTodo")
    );
    return result;
  }

  Future<int> updateTodo(Todos todo) async {
    var db = await this.db;
    print("Color/Updated: "+ todo.backgroundColor.toString()+ "");
    var result = await db.update(tblTodo, todo.toMap(),
        where: "$colId = ?", whereArgs: [todo.sId]);
    return result;
  }

  Future<int> deleteTodo(int id) async {
    int result;
    var db = await this.db;
    result = await db.rawDelete('DELETE FROM $tblTodo WHERE $colId = $id');
    return result;
  }


}