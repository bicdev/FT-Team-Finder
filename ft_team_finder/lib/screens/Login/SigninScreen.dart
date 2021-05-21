import 'package:flutter/material.dart';
import 'package:ft_team_finder/models/LoginData.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';
import 'package:ft_team_finder/screens/Profile/ProfileNameSelectionScreen.dart';

class SigninScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SigninScreenState();
  }
}

class SigninScreenState extends State<SigninScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  LoginData login = new LoginData();

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                makeEmailField(),
                makePasswordField(),
              ],
            ),
          ),
        ],
      ),
      forward: () => forward(),
    );
  }

  forward() {
    setState(() {
      this.formKey.currentState.save();
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              resizeToAvoidBottomInset: false,
              body: ProfileNameSelectionScreen()));
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
