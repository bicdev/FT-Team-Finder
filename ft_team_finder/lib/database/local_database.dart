import 'dart:async';
import 'dart:io';
import 'package:ft_team_finder/models/LoginData.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseServer {
  // Singleton Pattern
  static LocalDatabaseServer helper = LocalDatabaseServer._createInstance();

  LocalDatabaseServer._createInstance();

  // Every operation should be async
  // Local persistency are slow
  static Database _database;

  Future<Database> get database async {
    if (_database == null) _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "team_finder.db";

    var teamfinderDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return teamfinderDatabase;
  }

  _createDb(Database db, int newVersion) async {
    await db.execute('PRAGMA foreign_keys = ON');
    await db.execute(
        "CREATE TABLE loginData (id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, password TEXT)");
    await db.execute(
        "CREATE TABLE userSkills (id INTEGER PRIMARY KEY AUTOINCREMENT, be INTEGER, fe INTEGER, qa INTEGER, db INTEGER, dt INTEGER, st INTEGER)");
  }

  _configureDb(Database db) async {
}


  /* CRUD */
  Future<int> insertLoginData(LoginData loginData) async {
    Database db = await this.database;
    int result = await db.insert(
      tableName,
      loginData.toMap(),
    );
    // (await db.rawQuery(
    //         "SELECT sql FROM sqlite_master WHERE tbl_name = 'loginData' AND type = 'table'"))
    //     .forEach((row) {
    //   print(row.values);
    // }); // this is for debugging
    notify();
    return result;
  }

  getLoginDataList() async {
    Database db = await this.database;
    var noteMapList = await db.query(table)

    List<Note> noteList = [];
    List<int> idList = [];

    for (int i = 0; i < noteMapList.length; i++) {
      Note note = Note.fromMap(noteMapList[i]);
      note.dataLocation = 1;
      noteList.add(note);
      idList.add(noteMapList[i]["id"]);
    }
    return [noteList, idList];
  }

  Future<int> updateNote(Note note, int noteId) async {
    Database db = await this.database;
    var result = await db.update(
      tableName,
      note.toMap(),
      where: "$colId = ?",
      whereArgs: [noteId],
    );

    notify();
    return result;
  }

  deleteNote(int noteId) async {
    Database db = await this.database;
    // var sql = "DELETE FROM $tableName WHERE $colId = $noteId";
    // var result = db.rawDelete(sql);
    var result = db.delete(
      "$tableName",
      where: "$colId = ?",
      whereArgs: [noteId],
    );
    notify();
    return result;
  }
  /* end CRUD */

  /* STREAMING */
  static StreamController _controller;
  Stream get stream {
    if (_controller == null) {
      _controller = StreamController();
    }
    return _controller.stream.asBroadcastStream();
  }

  dispose() {
    if (!_controller.hasListener) {
      _controller.close();
      _controller = null;
    }
  }

  notify() async {
    if (_controller != null) {
      var response = await getLoginDataList();
      _controller.sink.add(response);
    }
  }
  /* end STREAMING */
}
