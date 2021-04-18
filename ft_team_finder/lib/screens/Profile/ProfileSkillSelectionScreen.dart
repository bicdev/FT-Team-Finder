import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:ft_team_finder/screens/Profile/UserProfileData.dart';

class ProfileSkillSelectionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SkillSelectorState();
}

class SkillSelectorState extends State<ProfileSkillSelectionScreen> {
  UserProfileData user = new UserProfileData();
  int vBE = 1;
  int vDB = 1;
  int vDT = 1;
  int vFE = 1;
  int vQA = 1;
  int vST = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(8),
              children: [
                makeHeaderBar(),
                makeSkillSelectorContainer(),
                makeBottomNavigationBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget makeSkillSelectorContainer() {
    return Container(
        height: 600,
        child: Column(
          children: [
            makeSkillBarContainer("BE", makeSliderContainer(vBE, 0), vBE),
            makeSkillBarContainer("DB", makeSliderContainer(vDB, 1), vDB),
            makeSkillBarContainer("DT", makeSliderContainer(vDT, 2), vDT),
            makeSkillBarContainer("FE", makeSliderContainer(vFE, 3), vFE),
            makeSkillBarContainer("QA", makeSliderContainer(vQA, 4), vQA),
            makeSkillBarContainer("ST", makeSliderContainer(vST, 5), vST),
            SizedBox(
              height: 300,
              width: 300,
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

  Widget makeBottomNavigationBar(){
    return Container( child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [ makeBackButton(), makeForwardButton()],));

  }

  Widget makeForwardButton(){
    return ElevatedButton(onPressed: (){}, child: Icon(Icons.arrow_forward));
  }

  Widget makeBackButton(){
    return ElevatedButton(onPressed: (){}, child: Icon(Icons.arrow_back));
  }

  Widget makeHeaderBar() {
    return Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          makeLogoPicContainer(),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Text(
                "Profile Creation",
                style: TextStyle(color: Colors.white),
              ),
              makeProgressBarContainer(3)
            ],
          ),
          makeProfilePicContainer()
        ],
      ),
    );
  }

  Widget makeProgressBarContainer(double progress) {
    return Container(
      child: SizedBox(
        height: 10,
        width: 100,
        child: LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
        ),
      ),
    );
  }

  Widget makeProfilePicContainer() {
    return Container(
      child: ClipOval(
        child: Image.asset(
          "assets/profilePic.jpg",
          height: 100,
          width: 100,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget makeLogoPicContainer() {
    return Container(
      child: ClipOval(
        child: Image.asset(
          "assets/peepoCute.png",
          height: 100,
          width: 100,
          fit: BoxFit.fill,
        ),
      ),
    );
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
}
