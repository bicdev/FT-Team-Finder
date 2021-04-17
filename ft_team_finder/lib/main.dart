import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:ft_team_finder/UserProfileData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SkillSelector(),
    );
  }
}

class SkillSelector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SkillSelectorState();
}

class SkillSelectorState extends State<SkillSelector> {
  UserProfileData user = new UserProfileData();
  int vBE = 1;
  int vFE = 1;
  int vQA = 1;
  int vDB = 1;
  int vDT = 1;
  int vST = 1;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Skill Selector"),
      ),
      body: Container(
        child: Column(children: <Widget>[
          makeSkillBar("BE", makeSlider(vBE, 0), vBE),
          makeSkillBar("FE", makeSlider(vFE, 1), vFE),
          makeSkillBar("QA", makeSlider(vQA, 2), vQA),
          makeSkillBar("DB", makeSlider(vDB, 3), vDB),
          makeSkillBar("DT", makeSlider(vDT, 4), vDT),
          makeSkillBar("ST", makeSlider(vST, 5), vST),
          Expanded(
            child: RadarChart.light(
              useSides: true,
              reverseAxis: false,
              data: [
                [vBE, vFE, vQA, vDB, vDT, vST]
              ],
              features: ["BE", "DB", "DT", "FE", "QA", "ST"],
              ticks: [6],
            ),
          ),
        ]),
      ),
    ));
  }

  Widget makeSlider(int value, int opt) {
    return Slider(
      divisions: 5,
      min: 1,
      max: 6,
      value: value.toDouble(),
      onChanged: (double input) {
        setState(() {
          switch (opt) {
            case 0:
              this.vBE= input.toInt();
              break;
            case 1:
              this.vDB = input.toInt();
              break;
            case 2:
              this.vQA = input.toInt();
              break;
            case 3:
              this.vFE = input.toInt();
              break;
            case 4:
              this.vDT = input.toInt();
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

  Widget makeSkillBar(String skill, Slider s, int value) {
    return Row(
      children: [Text(skill), s, Text("$value")],
    );
  }
}
