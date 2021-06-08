import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_team_finder/database/myLocalDatabase.dart';
import 'package:ft_team_finder/models/LoginData.dart';
import '../LoginDataBloc/ListenerEvent.dart';
import '../LoginDataBloc/ListenerState.dart';

class LoginDataListenerBloc
    extends Bloc<LoginDataListenerEvent, LoginDataListenerState> {
  StreamSubscription _localSubscription;

  LoginDataListenerBloc() : super(LoginDataListenerState(loginList: [])) {
    add(AskNewList());
    _localSubscription = MyLocalDatabase.helper.streamLogins.listen((response) {
      try {
        List<LoginData> loginList = response;
        add(UpdateList(loginList: loginList));
      } catch (e) {}
    });
  }

  @override
  Stream<LoginDataListenerState> mapEventToState(
      LoginDataListenerEvent event) async* {
    if (event is AskNewList) {
      var response = await MyLocalDatabase.helper.getLogins();
      List<LoginData> loginList = response;
      yield LoginDataListenerState(loginList: loginList);
    } else if (event is UpdateList) {
      yield LoginDataListenerState(loginList: event.loginList);
    }
  }

  close() {
    _localSubscription.cancel();
    return super.close();
  }
}
