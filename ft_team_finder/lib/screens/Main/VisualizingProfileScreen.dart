import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';
import 'package:ft_team_finder/baseWidgets/customDialog.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';
import 'package:ft_team_finder/models/UserSkillsData.dart';

// ignore: must_be_immutable
class VisualizingProfileScreen extends StatelessWidget {
  UserProfileData user;
  UserSkillsData skills;

  VisualizingProfileScreen(UserProfileData loggedInUser) {
    this.user = loggedInUser;
    this.skills = user.skills;
  }

  @override
  Widget build(BuildContext context) {
    String grad = (this.user.gradID == 1) ? "BSI" : "TADS";
    return BaseLayout(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("${this.user.name}'s Profile"),
              Text("$grad - ${this.user.yearOfEntry}"),
            ],
          ),
          Divider(),
          makeSkillsChart(this.skills),
          Divider(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            makeContactButton(context, user), makeInviteButton(context, user),
          ]),
        ],
      ),
    );
  }

  Widget makeInviteButton(BuildContext context, UserProfileData user){
    return ElevatedButton(
        onPressed: () {
          showDialog(context: context,
                  builder: (BuildContext context){
                  return CustomDialog(
                    title: "Invite",
                    descriptions: "Invite ${user.name} to group?",
                    text: "Invite",
                    icon: Icons.person_add,
                  );
                  }
                );
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.pink)),
        child: Icon(Icons.person_add));
  }

  Widget makeContactButton(BuildContext context, UserProfileData user) {
    return ElevatedButton(
        onPressed: () {
          showDialog(context: context,
                  builder: (BuildContext context){
                  return CustomDialog(
                    title: "Contact",
                    descriptions: "${user.name}'s public contact info:\n ${user.loginData.email}",
                    text: "Thanks",
                    icon: Icons.message_outlined,
                  );
                  }
                );
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
