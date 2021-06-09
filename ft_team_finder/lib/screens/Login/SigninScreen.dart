import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_team_finder/constants.dart';
import 'package:ft_team_finder/logic/LoginDataBloc/LoginDataBloc.dart';
import 'package:ft_team_finder/logic/LoginDataBloc/LoginDataEvent.dart';
import 'package:ft_team_finder/logic/LoginDataBloc/LoginDataState.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileBloc.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileEvent.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileState.dart';
import 'package:ft_team_finder/models/LoginData.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';
import 'package:ft_team_finder/models/UserSkillsData.dart';
import 'package:ft_team_finder/screens/Profile/ProfileNameSelectionScreen.dart';

// ignore: must_be_immutable
class SigninScreen extends BaseLayout {
  SigninScreen(BuildContext context) {
    this.child = Signin();
  }

  @override
  set child(Widget _child) {
    super.child = _child;
  }
}

class Signin extends StatelessWidget {
  static final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  LoginData login = new LoginData();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginDataBloc, LoginDataState>(
        builder: (_, stateFromLogin) {
      return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (__, stateFromProfile) {
        return Container(
          child: Column(children: [
            Text("Sign in!"),
            Form(
              key: formKey,
              child: Container(
                height: Constants.height * 0.6,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (input) {
                        bool isEmpty = input.length == 0 ? true : false;
                        if (isEmpty) return "Insert email!";
                        return null;
                      },
                      onSaved: (newValue) {
                        this.login.email = newValue;
                      },
                      decoration: InputDecoration(
                          hintText: "user@domain.br",
                          labelText: "Email Address"),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: (input) {
                        bool isBigEnough = input.length > 5 ? true : false;
                        if (!isBigEnough)
                          return "Enter a strong password";
                        else
                          return null;
                      },
                      onSaved: (newValue) {
                        this.login.password = newValue;
                      },
                      decoration: InputDecoration(labelText: "Password"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        formKey.currentState.save();
                        BlocProvider.of<LoginDataBloc>(context)
                            .add(NewLoginEvent(loginData: login));
                        BlocProvider.of<ProfileBloc>(context).add(
                            NewProfileEvent(
                                profile: UserProfileData(
                                    yearOfEntry: DateTime.now().year,
                                    gradID: 0,
                                    loginData: login,
                                    skills: UserSkillsData.fromList(
                                        be: 1,
                                        db: 1,
                                        dt: 1,
                                        fe: 1,
                                        qa: 1,
                                        st: 1))));
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return Scaffold(
                              body: NameScreen(),
                              resizeToAvoidBottomInset: false);
                        }));
                      },
                      child: Text("Sign in"),
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     print("${this.login.email}, ${this.login.password}");
                    //   },
                    //   child: Text("print"),
                    // ),
                  ],
                ),
              ),
            ),
          ]),
        );
      });
    });
  }
}
