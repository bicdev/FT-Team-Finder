import 'package:flutter/material.dart';
import 'package:ft_team_finder/dummy.dart';
import 'package:ft_team_finder/screens/Main/VisualizingProfileScreen.dart';

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
    return MaterialApp(home: Scaffold(body: VisualizingProfileScreen(d.getUser(0))));
    // return MaterialApp(home: Scaffold(body: SigninEmailScreen()));
  }
}