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
    String path = directory.path + "team_finder4.db";

    Database myDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return myDatabase;
  }

  _createDb(Database db, int newVersion) async {
    await db.execute('PRAGMA foreign_keys = ON');
    await db.execute(
        "CREATE TABLE loginData (id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, password TEXT)");
    await db.execute(
        "CREATE TABLE profiles (id INTEGER PRIMARY KEY AUTOINCREMENT,  name TEXT,  alias TEXT,  gradID INTEGER,  yearOfEntry INTEGER,  img BLOB,  BE INTEGER,  FE INTEGER,  QA INTEGER,  DB INTEGER,  DT INTEGER,  ST INTEGER,  loginID INTEGER,  FOREIGN KEY (loginId) REFERENCES loginData (id))");
  }

  // INSERT
  //TESTED WORKS
  insertLoginData(LoginData loginData) async {
    Database db = await this.database;
    int r = await db.insert("loginData", loginData.toMap());
    // print("-- inserted id: $r");
  }

  //TESTED WORKS
  insertProfile(UserProfileData profile) async {
    Database db = await this.database;

    Map<String, dynamic> map = UserProfileData.toMap(profile);
    var id = await db.rawQuery(
        "SELECT id FROM loginData WHERE email = '${profile.loginData.email}'");
    map["loginID"] = id[0]["id"];
    db.insert("profiles", map);
  }

  // QUERY
  //TESTED WORKS
  Future<List<LoginData>> getLogins() async {
    Database db = await this.database;
    var query = await db.query("loginData");

    List<LoginData> loginList = [];
    for (int i = 0; i < query.length; i++) {
      LoginData loginData = LoginData.fromMap(query[i]);
      loginList.add(loginData);
    }

    return loginList;
  }

  //TESTED WORKS
  Future<List<UserProfileData>> getAllProfiles() async {
    List<UserProfileData> users = [];
    Database db = await this.database;
    var query = await db.query("profiles");
    for (int i = 0; i < query.length; i++) {
      UserProfileData user = UserProfileData.fromMap(query[i]);
      var id = await db.rawQuery(
          "SELECT email, password FROM loginData WHERE id = '${query[i]["id"]}'");
      user.loginData =
          LoginData(email: id[0]["email"], password: id[0]["password"]);
      users.add(user);
    }

    return users;
  }

  //TESTED WORKS
  Future<UserProfileData> getProfileByName(String name) async {
    Database db = await this.database;
    var query = await db.query("profiles", where: "name = '$name'");
    UserProfileData user = UserProfileData.fromMap(query[0]);
    var id = await db.rawQuery(
        "SELECT email, password FROM loginData WHERE id = '${query[0]["id"]}'");
    user.loginData =
        LoginData(email: id[0]["email"], password: id[0]["password"]);
    return user;
  }

  //TESTED WORKS
  Future<List<Map<String, int>>> getAllIDs() async {
    Database db = await this.database;
    var query = await db.rawQuery("SELECT id, name FROM profiles");
    // print(query.toString()); //really good for debugging
    List<Map<String, int>> map = [];
    for (int i = 0; i < query.length; i++) {
      Map<String, int> m = {query[i]['name']: query[i]['id']};
      map.add(m);
    }
    return map;
  }

  // UPDATE
  //TESTED WORKS
  updateProfile(UserProfileData profile, int id) async {
    Database db = await this.database;
    int r = await db.update("profiles", UserProfileData.toMap(profile),
        where: "id = '$id'");
    // print("updated $r");
  }

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
