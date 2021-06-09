import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_team_finder/logic/LoginDataBloc/LoginDataBloc.dart';
import 'package:ft_team_finder/screens/Login/LoginScreen.dart';
import 'logic/LoginDataBloc/ListenerBloc.dart';
import 'logic/ProfileBloc/ProfileBloc.dart';
import 'logic/UsersBloc/UsersBloc.dart';
import 'tester.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // Widget homeScreen = LoginScreen(context);
    Widget homeScreen = Tester();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginDataBloc()),
        BlocProvider(create: (_) => LoginDataListenerBloc()),
        BlocProvider(create: (_) => ProfileBloc()),
        BlocProvider(create: (_) => UsersBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(resizeToAvoidBottomInset: false, body: homeScreen),
      ),
    );
  }
}
