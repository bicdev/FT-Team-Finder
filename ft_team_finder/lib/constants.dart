import 'package:flutter/material.dart';

class Constants {
  static int myId;
  //Theme Constants
  static double height;
  static double width;
  static final Duration defaultSnackBarDuration = Duration(seconds: 2);
  static final TextStyle defaultTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 22,
  );

  void init(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }
}
