import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:team_mobileforce_gong/models/note_model.dart';

class NoteDbhelper {
  static final NoteDbhelper _dbHelper = NoteDbhelper._internal();
  String tblNotes = "note";
  String colId = "id";
  String colTitle = "title";
  String colDescription = "description";
  String colDate = "date";
  String colBackgroundColor = "backgroundcolor";

  NoteDbhelper._internal();

  factory NoteDbhelper() {
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
    String path = dir.path + "notes.db";

    var dbNotes = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbNotes;
  }

  Future<List> searchNotes(String query) async
  {
    Database db = await this.db;
    var result = await db.rawQuery
      ("SELECT * FROM $tblNotes WHERE $colDescription LIKE '%$query%' UNION  SELECT * FROM $tblNotes WHERE $colTitle LIKE '%$query%' ");
    return result;
  }


  void _createDb(Database db, int newVersion) async
  {
    await db.execute(
        "CREATE TABLE $tblNotes($colId INTEGER PRIMARY KEY, $colTitle TEXT, " +
            "$colDescription TEXT, $colBackgroundColor INTEGER, $colDate TEXT)");
  }

  Future<int> insertNote(Notes note) async {
    Database db = await this.db;
    var result = await db.insert(tblNotes, note.toMap());
    return result;
  }

  Future<List> getNotes() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM $tblNotes order by $colId ASC");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("select count (*) from $tblNotes")
    );
    return result;
  }

  Future<int> updateNote(Notes note) async {
    var db = await this.db;
    var result = await db.update(tblNotes, note.toMap(),
        where: "$colId = ?", whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNote(int id) async {
    int result;
    var db = await this.db;
    result = await db.rawDelete('DELETE FROM $tblNotes WHERE $colId = $id');
    return result;
  }


}
