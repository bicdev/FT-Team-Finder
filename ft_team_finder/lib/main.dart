import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_team_finder/logic/LoginDataBloc/LoginDataBloc.dart';
import 'package:ft_team_finder/screens/Login/LoginScreen.dart';
import 'constants.dart';
import 'logic/LoginDataBloc/ListenerBloc.dart';
import 'logic/ProfileBloc/ProfileBloc.dart';
import 'logic/UsersBloc/UsersBloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Widget homeScreen = Tester();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginDataBloc()),
        BlocProvider(create: (_) => LoginDataListenerBloc()),
        BlocProvider(create: (_) => ProfileBloc()),
        BlocProvider(create: (_) => UsersBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeApp(),
      ),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    Constants().init(context);
    Widget homeScreen = LoginScreen(context);
    return Scaffold(resizeToAvoidBottomInset: false, body: homeScreen);
  }
}
