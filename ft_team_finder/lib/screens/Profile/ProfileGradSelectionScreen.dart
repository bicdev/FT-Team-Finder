import 'package:flutter/material.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';

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
            height: 300,
            child: YearPicker(
                firstDate: DateTime(DateTime.now().year - 10, 1),
                lastDate: DateTime(DateTime.now().year, 1),
                initialDate: DateTime.now(),
                selectedDate: user.yearOfEntry ?? DateTime.now(),
                onChanged: (DateTime dateTime) {
                  print("grads start year: $dateTime");
                  setState(() {
                    user.yearOfEntry = dateTime;
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
}
