import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_team_finder/database/MyLocalDatabase.dart';
import 'package:ft_team_finder/logic/UsersBloc/UsersEvent.dart';
import 'package:ft_team_finder/logic/UsersBloc/UsersState.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  StreamSubscription subscription;
  List<UserProfileData> users;
  UsersBloc() : super(UsersState(users: [])) {
    add(AskNewList());
    subscription = MyLocalDatabase.helper.streamProfiles.listen((response) {
      users = response[0];
      add(UpdateList(users: this.users));
    });
  }

  @override
  Stream<UsersState> mapEventToState(UsersEvent event) async* {
    if (event is AskNewList) {
      var response = await MyLocalDatabase.helper.getAllProfiles();
      this.users = response;
      yield UsersState(users: this.users);
    } else if (event is UpdateList) {
      yield UsersState(users: this.users);
    }
  }

  close() {
    subscription.cancel();
    return super.close();
  }
}
