import 'package:flutter/material.dart';
import 'package:ft_team_finder/screens/Login/SigninScreen.dart';

class LoginScreen extends SigninScreen {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends SigninScreenState {
  @override
  forward() {
    bool correctCredentials;
    //here we will have a SQL query something like this:
    //select email, password from Login where email = login.email and password = login.password
    //if that returns something, means credentials match
    //if (sqlReturn.length == 1) correctCredentials = true;
    correctCredentials = true; //placeholder
    if (correctCredentials == true) {
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
