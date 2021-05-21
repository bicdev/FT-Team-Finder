import 'models/UserProfileData.dart';
import 'models/LoginData.dart';

class Dummy {
  static List<UserProfileData> users = new List.empty(growable: true);

  List<String> emails = ["g22@dac", "e33@dac", "e44@dac", "a99@dac"];
  List<String> passwords = ["g22", "e33", "e44", "a99"];
  List<String> names = ["Gabriel", "Eric", "Erika", "Ana Luiza"];
  List<String> aliases = ["Bic", "Carguinha", "KC", ""];
  List<int> gradids = [1, 1, 1, 1];
  List<int> years = [2018, 2018, 2016, 2018];
  dynamic skills = [
    [6, 6, 4, 3, 3, 2],
    [3, 3, 3, 3, 3, 3],
    [3, 3, 3, 3, 6, 3],
    [6, 6, 6, 6, 6, 6]
  ];

  static UserProfileData getUser(int id) {
    return users[id];
  }

  Dummy() {
    for (int i = 0; i < 4; i++) {
      UserProfileData user = new UserProfileData();
      LoginData _l = new LoginData();
      _l.email = emails[i];
      _l.password = passwords[i];
      user.loginData = _l;
      user.name = names[i];
      user.alias = aliases[i];
      user.gradID = gradids[i];
      user.yearOfEntry = years[i];
      user.skills.save(skills[i]);
      user.profileCompleteness = 4;
      user.isActive = true;
      users.add(user);
    }
  }

  static List<UserProfileData> getUsers() {
    return users;
  }
}
