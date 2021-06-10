import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';
import 'package:ft_team_finder/baseWidgets/customDialog.dart';
import 'package:ft_team_finder/constants.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileBloc.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileState.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';
import 'package:ft_team_finder/models/UserSkillsData.dart';

// ignore: must_be_immutable
class VisualizingProfileScreen extends BaseLayout {
  UserProfileData user;
  UserProfileData myProfile;

  VisualizingProfileScreen(
      UserProfileData userBeingVisualized, BuildContext context) {
    this.user = userBeingVisualized;
    this.child = wid(context);
  }

  @override
  set child(Widget _child) {
    super.child = _child;
  }

  Widget wid(BuildContext context) {
    // Constants().init(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (_, state) {
        state is CurrentProfile
            ? this.myProfile = state.profile
            : print("this shouldnt happen");
        String grad = (this.user.gradID == 1) ? "BSI" : "TADS";
        return Container(
          height: Constants.height * 0.6,
          child: ListView(
            children: [
              ClipOval(
                  child: Image.memory(
                this.user.img,
                height: Constants.height * 0.2,
                width: Constants.width * 0.2,
              )),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: Constants.width * 0.4,
                      child: Text(
                        "${this.user.name}'s Profile",
                        style: Constants.defaultTextStyle,
                      )),
                  Text(
                    "$grad - ${this.user.yearOfEntry}",
                    style: Constants.defaultTextStyle,
                  ),
                ],
              ),
              Divider(),
              makeSkillsChart(this.user.skills),
              Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                makeContactButton(context, this.user),
              ]),
            ],
          ),
        );
      },
    );
  }

  Widget makeInviteButton(BuildContext context, UserProfileData user) {
    bool alreadyInTheGroup = false;
    if (user.group.contains(this.user)) alreadyInTheGroup = true;

    return ElevatedButton(
        onPressed: () {
          if (alreadyInTheGroup)
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Hey, this guy is already in your group"),
              duration: Constants.defaultSnackBarDuration,
            ));
          else {
            user.group.add(this.user);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("${this.user.name} added to ${user.name}'s group"),
              duration: Constants.defaultSnackBarDuration,
            ));
          }
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.pink)),
        child: Icon(Icons.person_add));
  }

  Widget makeContactButton(BuildContext context, UserProfileData user) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialog(
                  title: "Contact",
                  descriptions:
                      "${user.name}'s public contact info:\n ${user.loginData.email}",
                  text: "Thanks",
                  icon: Icons.message_outlined,
                );
              });
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.pink)),
        child: Icon(Icons.message_outlined));
  }

  Widget makeSkillsChart(UserSkillsData skills) {
    return SizedBox(
      height: 200,
      width: 200,
      child: RadarChart.light(
        useSides: true,
        reverseAxis: false,
        data: [
          [skills.be, skills.db, skills.dt, skills.fe, skills.qa, skills.st]
        ],
        features: ["BE", "DB", "DT", "FE", "QA", "ST"],
        ticks: [6],
      ),
    );
  }
}
