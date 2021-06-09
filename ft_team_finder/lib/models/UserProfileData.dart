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
    this.skills.backEnd = map["BE"];
    this.skills.frontEnd = map["FE"];
    this.skills.qualityAssurance = map["QA"];
    this.skills.dataBase = map["DB"];
    this.skills.designThinking = map["DT"];
    this.skills.scientificThinking = map["ST"];
  }

  static toMap(UserProfileData profile) {
    var map = Map<String, dynamic>();
    // map["loginData"] = profile.loginData;
    map["name"] = profile.name;
    map["alias"] = profile.alias;
    map["gradID"] = profile.gradID;
    map["yearOfEntry"] = profile.yearOfEntry;
    map["img"] = profile.img;
    map["BE"] = profile.skills.backEnd;
    map["FE"] = profile.skills.frontEnd;
    map["QA"] = profile.skills.qualityAssurance;
    map["DB"] = profile.skills.dataBase;
    map["DT"] = profile.skills.designThinking;
    map["ST"] = profile.skills.scientificThinking;
    return map;
  }
}
