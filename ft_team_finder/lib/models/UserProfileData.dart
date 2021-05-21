import 'package:flutter/material.dart';
import 'package:ft_team_finder/models/LoginData.dart';
import 'package:ft_team_finder/models/UserSkillsData.dart';

class UserProfileData {
  UserSkillsData skills = new UserSkillsData();
  LoginData loginData;
  String name;
  String alias;
  int gradID = 0; // 0 = none, 1 = BSI, 2 = TADS
  int yearOfEntry = DateTime.now().year;
  Image img;
  int profileCompleteness =
      0; //placeholder, this tells if the profile is ready to be active
  bool isActive = false; // this means visible by the community
  List<UserProfileData> group = List.empty(growable: true);

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

  bool hasAlias() {
    if (alias == "")
      return false;
    else
      return true;
  }

  bool isProfileComplete() {
    return this.profileCompleteness == 6 ? true : false;
  }

  bool validate() {
    bool r;
    (loginData.validate() && this.isProfileComplete()) ? r = true : r = false;
    return r;
  }
}
