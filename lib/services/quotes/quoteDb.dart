
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'quote.dart';

class QuotesDatabase{
  QuotesDatabase._();
  static final QuotesDatabase db = QuotesDatabase._();


  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var path = await getDatabasesPath();
    var dbPath = join(path, 'Quotes.db');
    // ignore: argument_type_not_assignable
    return await openDatabase(
        dbPath, version: 1, onCreate: (Database db, int version) async {
      print("executing create query from onCreate callback");
      await db.execute('''
        create table Quotes(
          id integer primary key autoincrement,
          quote text,
          author content not null
        );
      ''');
    });
  }

  Future<List<Quote>> getAllClients() async {
    final db = await database;
    var res = await db.query("Quotes");
    List<Quote> list =
      res.isNotEmpty ? res.map((c) => Quote.fromJson(c)).toList() : [];
      print(list);

  return list; 
      
    }



    Future<void> updateQuote(Quote note) async {
      // Get a reference to the database.
      final Database db = await database;
      print('update called');
      // Update the given Dog.
      await db.update(
        'Quotes',
        note.toMap(),
        // Ensure that the Dog has a matching id.
        where: "id = ?",
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [note.id],
      );
      print('update finished');
    }

    Future<void> deleteQuote(int id) async {
      // Get a reference to the database.
      final db = await database;

      // Remove the Dog from the database.
      await db.delete(
        'Quotes',
        // Use a `where` clause to delete a specific dog.
        where: "id = ?",
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [id],
      );
    }

  newQuote(Quote newQuote) async {
    final db = await database;
    var res = await db.insert("Quotes", newQuote.toMap());
    return res;
  }

  getQuote(int id) async{
    final db = await database;
    var res = await db.query('Quotes', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Quote.fromJson(res.first) : Null;
  }


}

