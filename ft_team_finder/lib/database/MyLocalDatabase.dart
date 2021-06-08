import 'dart:async';
import 'dart:io';
import 'package:ft_team_finder/models/LoginData.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyLocalDatabase {
  /* 
    Criando singleton
  */
  static MyLocalDatabase helper = MyLocalDatabase._createInstance();
  MyLocalDatabase._createInstance();

  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "team_finder.db";

    Database myDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return myDatabase;
  }

  _createDb(Database db, int newVersion) async {
    await db.execute('PRAGMA foreign_keys = ON');
    await db.execute("");
    await db.execute("");
  }

  // INSERT
  insertLoginData(LoginData loginData) async {}
  insertProfile(UserProfileData profile) async {}

  // QUERY
  Future<List<LoginData>> getLogins() async {}
  Future<List<UserProfileData>> getAllProfiles() async {}
  Future<UserProfileData> getProfileByName(String name) async {}

  // UPDATE
  updateProfile(UserProfileData profile, int id) {}

  // STREAM
  notify() async {
    if (_controllerLogins != null) {
      var response = await getLogins();
      _controllerLogins.sink.add(response);
    }
    if (_controllerProfiles != null) {
      var response = await getAllProfiles();
      _controllerLogins.sink.add(response);
    }
  }

  dispose() {
    if (!_controllerLogins.hasListener) {
      _controllerLogins.close();
      _controllerLogins = null;
    }
    if (!_controllerProfiles.hasListener) {
      _controllerProfiles.close();
      _controllerProfiles = null;
    }
  }

  Stream get streamLogins {
    if (_controllerLogins == null) {
      _controllerLogins = StreamController.broadcast();
    }
    return _controllerLogins.stream.asBroadcastStream();
  }

  Stream get streamProfiles {
    if (_controllerProfiles == null) {
      _controllerProfiles = StreamController.broadcast();
    }
    return _controllerProfiles.stream.asBroadcastStream();
  }

  static StreamController _controllerLogins;
  static StreamController _controllerProfiles;
}
