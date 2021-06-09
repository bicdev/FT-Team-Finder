import 'package:ft_team_finder/models/UserProfileData.dart';

class ProfileState {}

class CurrentProfile extends ProfileState {
  UserProfileData profile;
  CurrentProfile({this.profile});
}

class UpdateProfile extends ProfileState {
  UserProfileData profile;

  UpdateProfile({this.profile});
}
