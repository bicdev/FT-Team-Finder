import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';
import 'package:ft_team_finder/models/UserSkillsData.dart';

class VisualizingProfileScreen extends StatelessWidget {
  UserProfileData user;
  UserSkillsData skills;

  VisualizingProfileScreen(UserProfileData loggedInUser){
    this.user = loggedInUser;
    skills = user.skills;
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Column(
        children: [],
      ),
    );
  }

  Widget makeSkillsChart() {
    return SizedBox(
      height: 200,
      width: 200,
      child: RadarChart.light(
        useSides: true,
        reverseAxis: false,
        data: [
          [skills.backEnd, skills.dataBase , skills.designThinking, skills.frontEnd, skills.qualityAssurance, skills.scientificThinking]
        ],
        features: ["BE", "DB", "DT", "FE", "QA", "ST"],
        ticks: [6],
      ),
    );
  }
}
