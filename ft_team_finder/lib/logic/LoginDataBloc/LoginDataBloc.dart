import 'package:flutter_bloc/flutter_bloc.dart';

import 'LoginDataEvent.dart';
import 'LoginDataState.dart';

class LoginDataBloc extends Bloc<LoginDataEvent, LoginDataState> {
  LoginDataBloc() : super(NewLoginDataState());

  @override
  Stream<LoginDataState> mapEventToState(LoginDataEvent event) async* {
    if (event is NewLoginEvent) {
      //db insert
    } else {
      yield CurrentLoginDataState();
    }
  }
}
