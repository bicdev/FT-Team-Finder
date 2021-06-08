import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';
import 'package:ft_team_finder/baseWidgets/customDialog.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileBloc.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';

import '../../hub.dart';

// ignore: must_be_immutable
class SkillsScreen extends BaseLayout {
  SkillsScreen() {
    this.child = ProfileSkillSelectionScreen();
  }

  @override
  set child(Widget _child) {
    super.child = _child;
  }
}

class ProfileSkillSelectionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ProfileSkillSelectionScreenState();
}

class ProfileSkillSelectionScreenState
    extends State<ProfileSkillSelectionScreen> {
  UserProfileData user = new UserProfileData(loginData: null);
  int vBE = 1;
  int vDB = 1;
  int vDT = 1;
  int vFE = 1;
  int vQA = 1;
  int vST = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.forward),
          onPressed: forward(),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          child: makeSkillSelectorContainer(),
        ));
  }

  Widget makeSkillSelectorContainer() {
    return Container(
        height: 400,
        child: ListView(
          children: [
            makeSkillBarContainer("BE", makeSliderContainer(vBE, 0), vBE),
            makeSkillBarContainer("DB", makeSliderContainer(vDB, 1), vDB),
            makeSkillBarContainer("DT", makeSliderContainer(vDT, 2), vDT),
            makeSkillBarContainer("FE", makeSliderContainer(vFE, 3), vFE),
            makeSkillBarContainer("QA", makeSliderContainer(vQA, 4), vQA),
            makeSkillBarContainer("ST", makeSliderContainer(vST, 5), vST),
            SizedBox(
              height: 200,
              width: 200,
              child: RadarChart.light(
                useSides: true,
                reverseAxis: false,
                data: [
                  [vBE, vDB, vDT, vFE, vQA, vST]
                ],
                features: ["BE", "DB", "DT", "FE", "QA", "ST"],
                ticks: [6],
              ),
            )
          ],
        ));
  }

  Widget makeSliderContainer(int value, int opt) {
    return Slider(
      divisions: 5,
      min: 1,
      max: 6,
      value: value.toDouble(),
      onChanged: (double input) {
        setState(() {
          switch (opt) {
            case 0:
              this.vBE = input.toInt();
              break;
            case 1:
              this.vDB = input.toInt();
              break;
            case 2:
              this.vDT = input.toInt();
              break;
            case 3:
              this.vFE = input.toInt();
              break;
            case 4:
              this.vQA = input.toInt();
              break;
            case 5:
              this.vST = input.toInt();
              break;
            default:
          }
        });
      },
    );
  }

  Widget makeSkillBarContainer(String skill, Slider s, int value) {
    return Container(
      height: 50,
      child: Row(
        children: [Text(skill), s, Text("$value")],
      ),
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
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return BlocProvider.value(
          value: BlocProvider.of<ProfileBloc>(context), child: Hub());
    }));
  }
}
