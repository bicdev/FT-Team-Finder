import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileBloc.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';
import 'package:ft_team_finder/screens/Profile/ProfilePicSelectionScreen.dart';

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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.forward),
        onPressed: forward(),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Form(
            key: formKey,
            child: Column(children: [
              makeNameInput(),
              Text("Do you have an alias/nickname?"),
              Row(children: [
                makeCheckbox(),
                Container(
                  height: 20,
                  width: 200,
                  child: makeAliasInput(),
                )
              ]),
            ]),
          ),
        ],
      ),
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
        setState(() {
          this.user.name = input;
        });
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
        setState(() {
          this.user.alias = input;
        });
      },
    );
  }

  forward() {
    this.formKey.currentState.save();
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return BlocProvider.value(
          value: BlocProvider.of<ProfileBloc>(context), child: PicScreen());
    }));
  }
}
