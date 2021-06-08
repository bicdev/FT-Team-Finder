import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_team_finder/logic/LoginDataBloc/LoginDataBloc.dart';
import 'package:ft_team_finder/logic/LoginDataBloc/LoginDataEvent.dart';
import 'package:ft_team_finder/models/LoginData.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';
import 'package:ft_team_finder/screens/Profile/ProfileNameSelectionScreen.dart';

// ignore: must_be_immutable
class SigninScreen extends BaseLayout {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  LoginData login = new LoginData();

  SigninScreen(BuildContext context) {
    this.child = wid(context);
  }

  @override
  set child(Widget _child) {
    super.child = _child;
  }

  Widget wid(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.forward),
        onPressed: forward(context),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                Text("Sign in"),
                makeEmailField(),
                makePasswordField(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  forward(BuildContext context) {
    this.formKey.currentState.save();
    BlocProvider.of<LoginDataBloc>(context)
        .add(NewLoginEvent(loginData: login));
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return BlocProvider.value(
          value: BlocProvider.of<LoginDataBloc>(context), child: NameScreen());
    }));
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
