import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_team_finder/constants.dart';
import 'package:ft_team_finder/logic/LoginDataBloc/LoginDataBloc.dart';
import 'package:ft_team_finder/logic/LoginDataBloc/LoginDataEvent.dart';
import 'package:ft_team_finder/logic/LoginDataBloc/LoginDataState.dart';
import 'package:ft_team_finder/models/LoginData.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';
import 'package:ft_team_finder/screens/Profile/ProfileNameSelectionScreen.dart';

// ignore: must_be_immutable
class SigninScreen extends BaseLayout {
  SigninScreen(BuildContext context) {
    this.child = Signin(context: context);
  }

  @override
  set child(Widget _child) {
    super.child = _child;
  }
}

class Signin extends StatefulWidget {
  const Signin({Key key, BuildContext context}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  LoginData login = new LoginData();
  @override
  Widget build(BuildContext context) {
    // formKey.currentState.initState();
    return BlocBuilder<LoginDataBloc, LoginDataState>(builder: (_, state) {
      return Container(
        child: Column(children: [
          Text("Sign in!"),
          Form(
            child: Container(
              height: Constants.height * 0.6,
              child: Column(
                children: [
                  makeEmailField(),
                  makePasswordField(),
                  ElevatedButton(
                    onPressed: forward(context),
                    child: Text("Sign"),
                  ),
                ],
              ),
            ),
          ),
        ]),
      );
    });
  }

  forward(BuildContext context) {
    // if (formKey.currentState != null)
    // this.formKey.currentState.save();
    BlocProvider.of<LoginDataBloc>(context)
        .add(NewLoginEvent(loginData: login));
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return Scaffold(body: NameScreen());
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

  Widget makePasswordField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      validator: passwordValidation,
      onSaved: (newValue) {
        login.password = newValue;
      },
      decoration: InputDecoration(labelText: "Password"),
    );
  }

  Widget makeEmailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: emailValidation,
      onSaved: (newValue) {
        login.email = newValue;
      },
      decoration: InputDecoration(
          hintText: "user@domain.br", labelText: "Email Address"),
    );
  }
}
