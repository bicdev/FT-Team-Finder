import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';
import 'package:ft_team_finder/constants.dart';
import 'package:ft_team_finder/database/MyLocalDatabase.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileBloc.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileEvent.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileState.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';

import 'ProfilePicSelectionScreen.dart';

// ignore: must_be_immutable
class NameScreen extends BaseLayout {
  NameScreen() {
    this.child = ProfileNameSelectionScreen();
  }

  @override
  set child(Widget _child) {
    super.child = _child;
  }
}

class ProfileNameSelectionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileNameSelectionScreenState();
  }
}

class ProfileNameSelectionScreenState
    extends State<ProfileNameSelectionScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  UserProfileData user;
  bool _hasAlias = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (_, state) {
        state is CurrentProfile
            ? this.user = state.profile
            : print("this shouldnt happen");
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: formKey,
              child: Column(children: [
                makeNameInput(),
                Text("Do you have an Github account? Tell us your username"),
                Row(children: [
                  makeCheckbox(),
                  Container(
                    height: 20,
                    width: 200,
                    child: makeAliasInput(),
                  )
                ]),
                ElevatedButton(
                  child: Icon(Icons.forward),
                  onPressed: () async {
                    this.formKey.currentState.save();
                    // print("${this.user.name}, ${this.user.alias}");
                    // await MyLocalDatabase.helper
                    //     .updateMyProfile(this.user);
                    BlocProvider.of<ProfileBloc>(context)
                        .add(UpdateEvent(profile: this.user));
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return Scaffold(
                          body: PicScreen(), resizeToAvoidBottomInset: false);
                    }));
                  },
                ),
              ]),
            ),
          ],
        );
      },
    );
  }

  Widget makeCheckbox() {
    return Checkbox(
        value: _hasAlias,
        onChanged: (bool input) {
          setState(() {
            _hasAlias = input;
          });
        });
  }

  Widget makeNameInput() {
    return TextFormField(
      keyboardType: TextInputType.text,
      validator: (String input) {
        bool isEmpty = input.length == 0 ? true : false;
        if (isEmpty) return "Insert name!";
        return null;
      },
      onSaved: (String input) {
        this.user.name = input;
      },
      decoration: InputDecoration(
        hintText: "Tell us your name!",
        labelText: "Name",
      ),
    );
  }

  Widget makeAliasInput() {
    return TextFormField(
      readOnly: !_hasAlias,
      enabled: _hasAlias,
      keyboardType: TextInputType.text,
      onSaved: (String input) {
        this.user.alias = input;
      },
    );
  }
}
