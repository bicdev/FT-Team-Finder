import 'package:ft_team_finder/models/UserProfileData.dart';

class ProfileEvent {}

class NewProfileEvent extends ProfileEvent {
  UserProfileData profile;
  NewProfileEvent({this.profile});
}

class UpdateEvent extends ProfileEvent {
  UserProfileData profile;

  UpdateEvent({this.profile});
}
