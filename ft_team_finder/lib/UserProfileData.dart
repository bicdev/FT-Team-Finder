import 'package:ft_team_finder/LoginData.dart';
import 'package:ft_team_finder/UserSkillsData.dart';

class UserProfileData {
  UserSkillsData skills =
      new UserSkillsData(); //instantiation because constructor
  LoginData loginData;
  String name;
  String alias;
  String graduation;
  int yearOfEntry = 0;
  List<int> groupsIDs = [];
  bool isActive = false; // this means visible by the community
  int profileCompleteness = 0; 

  bool isProfileComplete(){
    return this.profileCompleteness == 4 ? true : false;
  }

  bool validate() {
    bool r;
    (loginData.validate() &&
            name != null &&
            alias != null &&
            graduation != null &&
            yearOfEntry != 0)
        ? r = true
        : r = false;
    return r;
  }
}
