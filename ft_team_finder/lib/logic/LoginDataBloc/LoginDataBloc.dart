import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_team_finder/database/myLocalDatabase.dart';
import 'LoginDataEvent.dart';
import 'LoginDataState.dart';

class LoginDataBloc extends Bloc<LoginDataEvent, LoginDataState> {
  LoginDataBloc() : super(NewLoginDataState());

  @override
  Stream<LoginDataState> mapEventToState(LoginDataEvent event) async* {
    if (event is NewLoginEvent) {
      MyLocalDatabase.helper.insertLoginData(event.loginData);
    }
  }
}
