
import 'package:ft_team_finder/models/LoginData.dart';
import 'package:ft_team_finder/models/UserSkillsData.dart';

class UserProfileData {
  UserSkillsData skills =
      new UserSkillsData(); //instantiation because constructor
  LoginData loginData;
  String name;
  String alias;
  bool isActive = false; // this means visible by the community
  int gradID = 0; // 0 = none, 1 = BSI, 2 = TADS
  int yearOfEntry;
  int profileCompleteness = 0; 
  List<int> groupsIDs = [];

  bool hasAlias(){
    if (alias == "")
      return false;
    else
      return true;
  }

  bool isProfileComplete(){
    return this.profileCompleteness == 4 ? true : false;
  }

  bool validate() {
    bool r;
    (loginData.validate() && this.isProfileComplete())
        ? r = true
        : r = false;
    return r;
  }
}
