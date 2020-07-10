import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:team_mobileforce_gong/models/note_model.dart';
import 'package:team_mobileforce_gong/models/todos.dart';

class GongDbhelper {
  static final GongDbhelper _dbHelper = GongDbhelper._internal();
  String tblNotes = "notes";
  String colPid = "id";
  String colId = "_id";
  String colTitle = "title";
  String colContent = "content";
  String colUserID = "userID";
  String colImportant = "important";
  String colDate = "date";
  String colUpload = "uploaded";
  String colUpdate = "shouldUpdate";
  String colColor = "color";

  String tblTodos = "todos";
  String colTime = "time";
  String colCompleted = "completed";
  String colCategory = "category";

  String tblupdateNotes = "updatenotes";
  String tbldeleteNotes = "deletenotes";
  String tblupdateTodos = "updatetodos";
  String tbldeleteTodos = "deletetodos";

  GongDbhelper._internal();

  factory GongDbhelper() {
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
    String path = dir.path + "gong.db";

    var dbNotes = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbNotes;
  }

  // Future<List> searchNotes(String query) async
  // {
  //   Database db = await this.db;
  //   var result = await db.rawQuery
  //     ("SELECT * FROM $tblNotes WHERE $colContent LIKE '%$query%' UNION  SELECT * FROM $tblNotes WHERE $colTitle LIKE '%$query%' ");
  //   return result;
  // }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE $tblNotes(
      $colPid INTEGER PRIMARY KEY,
      $colId TEXT, 
      $colTitle TEXT,
      $colContent TEXT, 
      $colUserID TEXT,
      $colImportant INTEGER,
      $colDate TEXT,
      $colUpload INTEGER,
      $colUpdate INTEGER,
      $colColor INTEGER)
      ''');
    await db.execute('''
      CREATE TABLE $tbldeleteNotes(
      $colPid INTEGER PRIMARY KEY,
      $colId TEXT, 
      $colTitle TEXT,
      $colContent TEXT,
      $colColor INTEGER,
      $colUserID TEXT,
      $colImportant INTEGER,
      $colDate TEXT,
      $colUpload INTEGER,
      $colUpdate INTEGER)
      ''');

    await db.execute('''
      CREATE TABLE $tblTodos(
      $colPid INTEGER PRIMARY KEY,
      $colId TEXT, 
      $colTitle TEXT,
      $colUserID TEXT,
      $colTime TEXT,
      $colCompleted INTEGER,
      $colDate TEXT,
      $colContent TEXT,  
      $colCategory TEXT,
      $colUpload INTEGER,
      $colUpdate INTEGER)
      ''');
    await db.execute('''
      CREATE TABLE $tbldeleteTodos(
      $colPid INTEGER PRIMARY KEY,
      $colId TEXT, 
      $colTitle TEXT,
      $colUserID TEXT,
      $colTime TEXT,
      $colCompleted INTEGER,
      $colDate TEXT,
      $colContent TEXT,  
      $colCategory TEXT,
      $colUpload INTEGER,
      $colUpdate INTEGER)
      ''');
  }

  Future<List> getNotes() async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $tblNotes order by $colPid DESC"); // order by $colId ASC
    return result;
  }

  // Future<List> getUpdateNotes() async {
  //   Database db = await this.db;
  //   var result = await db.rawQuery("SELECT * FROM $tblupdateNotes order by $colPid DESC");
  //   return result;
  // }
  Future<List> getDeleteNotes() async {
    Database db = await this.db;
    var result = await db
        .rawQuery("SELECT * FROM $tbldeleteNotes order by $colPid DESC");
    return result;
  }

  Future<List> getTodos() async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $tblTodos order by $colPid DESC"); // order by $colId ASC
    return result;
  }

  // Future<List> getUpdateTodos() async {
  //   Database db = await this.db;
  //   var result = await db.rawQuery("SELECT * FROM $tblupdateTodos order by $colPid DESC");// order by $colId ASC
  //   return result;
  // }
  Future<List> getDeleteTodos() async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $tbldeleteTodos order by $colPid DESC"); // order by $colId ASC
    return result;
  }

  Future<int> insertNote(Notes note) async {
    print(note);
    Database db = await this.db;
    var result = await db.insert(tblNotes, note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future<int> insertNoteFromDb(Notes note) async {
    print(note);
    Database db = await this.db;
    var check = await db.rawQuery(
      "SELECT * FROM $tblNotes WHERE $colId = ?", [note.sId ?? 'feel']
    );
    if (check.isEmpty) {
      var result = await db.insert(tblNotes, note.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return result;
    }
    return null;
  }

  // Future<int> insertUpdateNote(Notes note) async {
  //   Database db = await this.db;
  //   var result = await db.insert(tblupdateNotes, note.toJson());
  //   return result;
  // }
  Future<int> insertDeleteNote(Notes note) async {
    Database db = await this.db;
    var result = await db.insert(tbldeleteNotes, note.toJson());
    return result;
  }

  Future<int> insertTodo(Todos todo) async {
    Database db = await this.db;
    var result = await db.insert(tblTodos, todo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future<int> insertTodoFromDb(Todos todo) async {
    print(todo);
    Database db = await this.db;
    var check = await db.rawQuery(
      "SELECT * FROM $tblTodos WHERE $colId = ?", [todo.sId ?? 'feel']
    );
    if (check.isEmpty) {
      var result = await db.insert(tblTodos, todo.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return result;
    }
    return null;
  }

  // Future<int> insertUpdateTodo(Todos todo) async {
  //   Database db = await this.db;
  //   var result = await db.insert(tblupdateTodos, todo.toJson());
  //   return result;
  // }
  Future<int> insertDeleteTodo(Todos todo) async {
    Database db = await this.db;
    var result = await db.insert(tbldeleteTodos, todo.toJson());
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("select count (*) from $tblNotes"));
    return result;
  }

  Future<int> updateNote(Notes note) async {
    var db = await this.db;
    var result = await db.update(tblNotes, note.toJson(),
        where: "$colId = ?", whereArgs: [note.sId]);
    return result;
  }

  Future<int> updateTodo(Todos todo) async {
    var db = await this.db;
    var result = await db.update(tblTodos, todo.toJson(),
        where: "$colId = ?", whereArgs: [todo.sId]);
    return result;
  }

  Future<int> deleteNote(String id) async {
    int result;
    var db = await this.db;
    result =
        await db.rawDelete('DELETE FROM $tblNotes WHERE $colId = ?', ['$id']);
    return result;
  }

  Future<int> deleteStoreNote(String id) async {
    int result;
    var db = await this.db;
    result = await db
        .rawDelete('DELETE FROM $tbldeleteNotes WHERE $colId = ?', ['$id']);
    return result;
  }

  Future<int> deleteTodo(String id) async {
    int result;
    var db = await this.db;
    result =
        await db.rawDelete('DELETE FROM $tblTodos WHERE $colId = ?', ['$id']);
    return result;
  }

  Future<int> deleteStoreTodo(String id) async {
    int result;
    var db = await this.db;
    result = await db
        .rawDelete('DELETE FROM $tbldeleteTodos WHERE $colId = ?', ['$id']);
    return result;
  }
}
