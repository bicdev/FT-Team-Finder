import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileBloc.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileState.dart';
import 'package:ft_team_finder/logic/UsersBloc/UsersBloc.dart';
import 'package:ft_team_finder/logic/UsersBloc/UsersState.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';
import 'package:ft_team_finder/models/UserSkillsData.dart';
import '../../constants.dart';

// ignore: must_be_immutable
class BrowsingProfilesScreen extends BaseLayout {
  UserProfileData user;
  BrowsingProfilesScreen() {
    this.child = wid();
  }

  @override
  set child(Widget _child) {
    super.child = _child;
  }

  Widget wid() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (contextA, stateA) {
      if (stateA is CurrentProfile) this.user = stateA.profile;
      return BlocBuilder<UsersBloc, UsersState>(builder: (contextB, stateB) {
        return layout(stateB.users);
      });
    });
  }

  Scaffold layout(List<UserProfileData> users) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(builder: (__, constraints) {
        Constants().init(__);
        return Container(
          width: constraints.maxWidth,
          height:
              Constants.height * 0.62, //placeholder: yeah magic number i know
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: users.length,
            itemBuilder: (BuildContext _, int index) {
              String grad = (users[index].gradID == 1) ? "BSI" : "TADS";
              return ExpansionTile(
                title: Text(users[index].name),
                subtitle: Text("$grad, ${users[index].yearOfEntry}"),
                trailing: makeInviteButton(__, users[index]),
                children: [
                  Container(
                      width: Constants.width * 0.5,
                      height: Constants.height * 0.3,
                      child: makeSkillsChart(
                        users[index],
                      )),
                ],
              );
            },
          ),
        );
      }),
    );
  }

  Widget makeInviteButton(BuildContext context, UserProfileData user) {
    return ElevatedButton(
        onPressed: () {
          this.user.group.add(user);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("${this.user.name} added to ${user.name}'s group"),
            duration: Constants.defaultSnackBarDuration,
          ));
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.pink)),
        child: Icon(Icons.person_add));
  }

  Widget makeSkillsChart(UserProfileData user) {
    UserSkillsData skills = user.skills;
    return SizedBox(
      child: RadarChart.light(
        useSides: true,
        reverseAxis: false,
        data: [
          [
            skills.backEnd,
            skills.dataBase,
            skills.designThinking,
            skills.frontEnd,
            skills.qualityAssurance,
            skills.scientificThinking
          ]
        ],
        features: ["BE", "DB", "DT", "FE", "QA", "ST"],
        ticks: [6],
      ),
    );
  }
}
