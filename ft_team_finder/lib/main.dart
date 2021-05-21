import 'package:flutter/material.dart';
import 'package:ft_team_finder/dummy.dart';
import 'package:ft_team_finder/screens/Login/SigninScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Dummy d = new Dummy();

  @override
  Widget build(BuildContext context) {
    Widget homeScreen = SigninScreen();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(resizeToAvoidBottomInset: false, body: homeScreen));
  }
}
