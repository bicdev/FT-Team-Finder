import 'package:flutter/material.dart';
import 'package:ft_team_finder/screens/Login/SigninEmailScreen.dart';

class LoginEmailScreen extends SigninEmailScreen {
  @override
  State<StatefulWidget> createState() {
    return LoginEmailScreenState();
  }
}

class LoginEmailScreenState extends SigninEmailScreenState {
  @override
  forward() {
    bool correctCredentials;
    //here we will have a SQL query something like this:
    //select email, password from Login where email = login.email and password = login.password
    //if that returns something, means credentials match
    //if (sqlReturn.length == 1) correctCredentials = true;
    correctCredentials = false; //placeholder
    if (correctCredentials == true) {
      formKey.currentState.save();
      print("trying to log in as: ${login.email}");
      print("trying to log in as: ${login.password}");
    } else {
      formKey.currentState.reset();
      login = null;
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Credentials do not match!"),
        duration: Duration(seconds: 5),
        action: SnackBarAction(label: "sorry", onPressed: () {}),
      ));
    }
  }
}
