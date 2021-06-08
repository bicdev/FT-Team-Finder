import 'package:flutter/material.dart';

class Constants {
  //Theme Constants
  static double height;
  static double width;
  static final Duration defaultSnackBarDuration = Duration(seconds: 2);

  void init(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }
}
