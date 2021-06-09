import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ft_team_finder/models/LoginData.dart';
import 'package:ft_team_finder/models/UserSkillsData.dart';

class UserProfileData {
  UserSkillsData skills = new UserSkillsData();
  LoginData loginData;
  List<UserProfileData> group = List.empty(growable: true);
  String name;
  String alias = "";
  int gradID = 0; // 0 = none, 1 = BSI, 2 = TADS
  int yearOfEntry = DateTime.now().year;
  Uint8List img;

  UserProfileData(
      {@required this.loginData,
      this.name,
      this.alias,
      this.gradID,
      this.yearOfEntry,
      this.img,
      this.skills}) {
    this.group.add(this);
  }

  UserProfileData.fromMap(dynamic map) {
    this.loginData = map["loginData"];
    this.name = map["name"];
    this.alias = map["alias"];
    this.gradID = map["gradID"];
    this.yearOfEntry = map["yearOfEntry"];
    this.img = map["img"];
    this.skills.be = map["BE"];
    this.skills.fe = map["FE"];
    this.skills.qa = map["QA"];
    this.skills.db = map["DB"];
    this.skills.dt = map["DT"];
    this.skills.st = map["ST"];
  }

  static toMap(UserProfileData profile) {
    var map = Map<String, dynamic>();
    // map["loginData"] = profile.loginData;
    map["name"] = profile.name ?? "";
    map["alias"] = profile.alias ?? "";
    map["gradID"] = profile.gradID ?? "";
    map["yearOfEntry"] = profile.yearOfEntry ?? "";
    map["img"] = profile.img ?? "";
    map["BE"] = profile.skills.be ?? 1;
    map["FE"] = profile.skills.fe ?? 1;
    map["QA"] = profile.skills.qa ?? 1;
    map["DB"] = profile.skills.db ?? 1;
    map["DT"] = profile.skills.dt ?? 1;
    map["ST"] = profile.skills.st ?? 1;
    return map;
  }
}
