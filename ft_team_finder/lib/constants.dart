import 'package:flutter/material.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';

class Constants {
  //Data Constants
  static UserProfileData loggedInUser;
  //Theme Constants
  static double height;
  static double width;

  void init(BuildContext context){
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }
}
