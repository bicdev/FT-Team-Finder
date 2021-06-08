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
}
