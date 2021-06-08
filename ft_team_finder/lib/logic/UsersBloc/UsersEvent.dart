import 'package:ft_team_finder/models/UserProfileData.dart';

abstract class UsersEvent {}

class AskNewList extends UsersEvent {}

class UpdateList extends UsersEvent {
  List<UserProfileData> users;
  UpdateList({this.users});
}
