import 'package:flutter/material.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';
import 'package:ft_team_finder/baseWidgets/customDialog.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';
import 'package:ft_team_finder/screens/Profile/ProfilePicSelectionScreen.dart';

class ProfileNameSelectionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileNameSelectionScreenState();
  }
}

class ProfileNameSelectionScreenState
    extends State<ProfileNameSelectionScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  UserProfileData user = new UserProfileData(loginData: null);
  TextEditingController _controller = new TextEditingController();
  bool _hasAlias = false;

  TextStyle theme = new TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black87,
      fontSize: 22); //placeholder theme constant

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
        home: () => home(),
        forward: () => forward(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: formKey,
              child: Column(children: [
                makeNameInput(),
                Text("Do you have an alias/nickname?", style: theme),
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
        ));
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
      controller: _controller,
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
          hintStyle: theme,
          labelStyle: theme),
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

  home() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Finish your Profile!",
            descriptions: "",
            text: "OK",
            icon: Icons.check,
          );
        });
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
              body: ProfilePicSelectionScreen()));
    }));
  }
}
