import 'package:ft_team_finder/models/LoginData.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';

class Dummy {
  List<UserProfileData> _user;
  LoginData l;
  
  List<String> emails = ["g22@dac", "e33@dac", "e44@dac", "a99@dac"];
  List<String> passwords = ["g22", "e33", "e44", "a99"];
  List<String> names = ["Gabriel", "Eric", "Erika", "Ana Luiza"];
  List<String> aliases = ["Bic", "Carguinha", "KC", ""];
  List<int> gradids = [1,1,1,1];
  List<int> years = [2018, 2018, 2016, 2018];
  List<List<int>> skills = [[6,6,4,3,3,2],[3,3,3,3,3,3],[1,1,1,1,6,1],[6,6,6,6,6,6]];

  UserProfileData getUser(int id){
    return _user[id];
  }

  Dummy(){
    for (int i=0; i < 4; i++){
      l.email = emails[i];
      l.password = passwords[i];
      _user[i].loginData = l;
      _user[i].name = names[i];
      _user[i].alias = aliases[i];
      _user[i].gradID = gradids[i];
      _user[i].yearOfEntry = years[i];
      _user[i].skills.save(skills[i]);
      _user[i].profileCompleteness = 4;
      _user[i].isActive = true;
    }
  }
}