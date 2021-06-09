import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_team_finder/logic/LoginDataBloc/ListenerBloc.dart';
import 'package:ft_team_finder/logic/LoginDataBloc/ListenerState.dart';
import 'package:ft_team_finder/models/LoginData.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';
import 'package:ft_team_finder/screens/Login/SigninScreen.dart';

import '../../constants.dart';
import '../../hub.dart';

// ignore: must_be_immutable
class LoginScreen extends BaseLayout {
  static final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  LoginData login = new LoginData();

  LoginScreen(BuildContext context) {
    this.child = wid(context);
  }

  @override
  set child(Widget _child) {
    super.child = _child;
  }

  Widget wid(BuildContext context) {
    return BlocBuilder<LoginDataListenerBloc, LoginDataListenerState>(
        builder: (contextA, state) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  Text("Log in"),
                  makeEmailField(),
                  makePasswordField(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        child: Text("Register"),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return Scaffold(
                                body: SigninScreen(context),
                                resizeToAvoidBottomInset: false);
                          }));
                        },
                      ),
                      ElevatedButton(
                        child: Text("Login"),
                        onPressed: () {
                          forward(context, state.loginList);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  forward(BuildContext context, List<LoginData> logins) {
    formKey.currentState.save();
    for (LoginData loginData in logins) {
      if (loginData.email == this.login.email &&
          loginData.password == this.login.password) {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return Hub();
        }));
      } else {
        formKey.currentState.reset();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Incorrect Credentials!"),
          duration: Constants.defaultSnackBarDuration,
        ));
      }
    }
  }

  String passwordValidation(String input) {
    bool isBigEnough = input.length > 10 ? true : false;
    if (!isBigEnough)
      return "Enter a strong password";
    else
      return null;
  }

  String emailValidation(String input) {
    bool isEmpty = input.length == 0 ? true : false;
    if (isEmpty) return "Insert email!";
    return null;
  }

  emailConsolidation(String input) {
    login.email = input;
  }

  passwordConsolidation(String input) {
    login.password = input;
  }

  Widget makePasswordField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      validator: passwordValidation,
      onSaved: passwordConsolidation,
      decoration: InputDecoration(labelText: "Password"),
    );
  }

  Widget makeEmailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: emailValidation,
      onSaved: emailConsolidation,
      decoration: InputDecoration(
          hintText: "user@domain.br", labelText: "Email Address"),
    );
  }
}
