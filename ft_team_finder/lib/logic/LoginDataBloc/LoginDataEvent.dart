import 'package:ft_team_finder/models/LoginData.dart';

abstract class LoginDataEvent {}

class NewLoginEvent extends LoginDataEvent {
  LoginData loginData;
  NewLoginEvent({this.loginData});
}

class SetLoggedUserEvent extends LoginDataEvent {
  LoginData loginData;
  SetLoggedUserEvent({this.loginData});
}
