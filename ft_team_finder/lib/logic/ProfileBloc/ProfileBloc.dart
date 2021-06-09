import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_team_finder/database/myLocalDatabase.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileEvent.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileState.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(CurrentProfile(profile: null));

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is NewProfileEvent) {
      MyLocalDatabase.helper.insertProfile(event.profile);
      yield CurrentProfile(profile: event.profile);
    } else if (event is UpdateEvent) {
      MyLocalDatabase.helper.updateMyProfile(event.profile);
      yield CurrentProfile(profile: event.profile);
    }
  }
}
