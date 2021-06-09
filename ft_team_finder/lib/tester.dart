import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ft_team_finder/database/MyLocalDatabase.dart';
import 'package:ft_team_finder/models/LoginData.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';
import 'package:ft_team_finder/models/UserSkillsData.dart';

class Tester extends StatefulWidget {
  const Tester({Key key}) : super(key: key);

  @override
  _TesterState createState() => _TesterState();
}

class _TesterState extends State<Tester> {
  final GlobalKey<FormState> formKey = new GlobalKey();
  LoginData login = LoginData();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            onSaved: (newValue) {
              login.email = newValue;
              login.password = newValue;
            },
          ),
          ElevatedButton(
              onPressed: () async {
                formKey.currentState.save();

                dynamic by = await rootBundle.load("assets/appLogo.png");
                Uint8List a = by.buffer.asUint8List();
                LoginData l = LoginData(email: "ccc", password: "ccc");
                UserSkillsData s = UserSkillsData.fromList(
                    backEnd: 6,
                    dataBase: 6,
                    designThinking: 6,
                    frontEnd: 6,
                    qualityAssurance: 6,
                    scientificThinking: 6);
                // MyLocalDatabase.helper.insertLoginData(l);
                UserProfileData u = UserProfileData(
                  loginData: l,
                  alias: "alias",
                  gradID: 1,
                  img: a,
                  name: "${this.login.email}",
                  yearOfEntry: 2018,
                  skills: s,
                );

                MyLocalDatabase.helper.updateProfile(u, 1);
                // MyLocalDatabase.helper.insertProfile(u);
              },
              child: Text("Insert")),
          ElevatedButton(
              onPressed: () async {
                List<Map<String, int>> m =
                    await MyLocalDatabase.helper.getAllIDs();
                print(m.toString());
                // List<UserProfileData> users =
                //     await MyLocalDatabase.helper.getAllProfiles();
                // for (UserProfileData user in users) {
                //   print("${user.name}");
                // }

                // UserProfileData u = await MyLocalDatabase.helper
                //     .getProfileByName("another name");

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) {
                //       return VisualizingProfileScreen(u, context);
                //     },
                //   ),
                // );

                // List<LoginData> a = await MyLocalDatabase.helper.getLogins();
                // for (LoginData u in a) {
                //   print("${u.email}, ${u.password}");
              },
              child: Text("Select")),
        ],
      ),
    );
  }
}
