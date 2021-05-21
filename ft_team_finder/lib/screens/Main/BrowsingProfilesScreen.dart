import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';
import 'package:ft_team_finder/models/UserSkillsData.dart';
import '../../dummy.dart';

class BrowsingProfilesScreen extends StatefulWidget {
  @override
  _BrowsingProfilesScreenState createState() => _BrowsingProfilesScreenState();
}

class _BrowsingProfilesScreenState extends State<BrowsingProfilesScreen> {
  Dummy d = new Dummy();
  List<UserProfileData> users = List.empty(growable: true);

  List<UserProfileData> queryUsers() {
    return Dummy
        .users; //this is placeholder, will be replaced by SQL Query of all active users
  }

  @override
  Widget build(BuildContext context) {
    users = queryUsers();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BaseLayout(
      forward: () {
        setState(() => forward());
      },
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: height * 0.62, //placeholder: yeah magic number i know
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              String grad = (this.users[index].gradID == 1) ? "BSI" : "TADS";
              return ExpansionTile(
                title: Text(users[index].name),
                subtitle: Text("$grad, ${users[index].yearOfEntry}"),
                trailing: makeInviteButton(context, users[index]),
                children: [
                  Container(
                      width: width * 0.5,
                      height: height * 0.3,
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
          Groups gs = Dummy.getUser(0)
              .groups[0]; //placeholder select which group to add to
          gs.members.add(user); //placeholder SQL
          print(
              "${user.name} was added into ${Dummy.getUser(0).groups[0].name}");
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

  forward() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home:
              Scaffold(resizeToAvoidBottomInset: false, body: GroupsScreen()));
    }));
  }
}
