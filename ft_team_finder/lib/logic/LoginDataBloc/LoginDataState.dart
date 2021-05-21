import 'package:ft_team_finder/models/LoginData.dart';

abstract class LoginDataState {}

class CurrentLoginDataState extends LoginDataState {
  LoginData loginData;
  CurrentLoginDataState({this.loginData});
}

class NewLoginDataState extends LoginDataState {}
