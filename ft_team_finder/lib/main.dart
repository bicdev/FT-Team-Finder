import 'package:flutter/material.dart';
import 'package:ft_team_finder/screens/Login/LoginEmailScreen.dart';
import 'package:ft_team_finder/screens/Login/SigninEmailScreen.dart';

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
    return MaterialApp(home: Scaffold(body: LoginEmailScreen()));
    // return MaterialApp(home: Scaffold(body: SigninEmailScreen()));
  }
}