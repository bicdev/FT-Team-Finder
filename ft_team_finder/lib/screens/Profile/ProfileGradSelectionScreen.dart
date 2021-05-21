import 'package:flutter/material.dart';
import 'package:ft_team_finder/baseWidgets/customDialog.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';
import 'package:ft_team_finder/screens/Profile/ProfileSkillSelectionScreen.dart';

class ProfileGradSelectionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileGradSelectionScreenState();
  }
}

class ProfileGradSelectionScreenState
    extends State<ProfileGradSelectionScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  UserProfileData user = new UserProfileData();
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
        home: () => home(),
        forward: () => forward(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Select your Grad:"),
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("BSI"),
                  makeRadioButton(1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("TADS"), makeRadioButton(2)],
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(left: Radius.zero),
                    border: Border.all(color: Colors.black, width: 3)),
                width: 300,
                height: 250,
                child: YearPicker(
                    firstDate: DateTime(DateTime.now().year - 10, 1),
                    lastDate: DateTime(DateTime.now().year, 1),
                    initialDate: DateTime.now(),
                    selectedDate: DateTime(user.yearOfEntry),
                    onChanged: (DateTime dateTime) {
                      print("grads start year: $dateTime");
                      setState(() {
                        user.yearOfEntry = dateTime.year;
                      });
                    }),
              ),
            ]),
          ],
        ));
  }

  Widget makeRadioButton(int value) {
    return Radio(
      value: value,
      groupValue: user.gradID,
      onChanged: (int input) {
        setState(() {
          user.gradID = input;
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
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              resizeToAvoidBottomInset: false,
              body: ProfileSkillSelectionScreen()));
    }));
  }
}
