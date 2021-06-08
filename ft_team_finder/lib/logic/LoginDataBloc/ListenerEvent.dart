import 'package:ft_team_finder/models/LoginData.dart';

abstract class LoginDataListenerEvent {}

class AskNewList extends LoginDataListenerEvent {}

class UpdateList extends LoginDataListenerEvent {
  List<LoginData> loginList;
  UpdateList({this.loginList});
}
