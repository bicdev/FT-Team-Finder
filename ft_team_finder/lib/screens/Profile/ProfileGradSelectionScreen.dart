import 'package:flutter/material.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';

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
    return MaterialApp(
        home: Scaffold(
            body: SafeArea(
                child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        makeHeaderBar(),
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
                  print("grads start year: ${user.yearOfEntry}");
                }),
          ),
        ]),
        makeBottomNavigationBar()
      ],
    ))));
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

  Widget makeBottomNavigationBar() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [makeBackButton(), makeForwardButton()],
    ));
  }

  Widget makeForwardButton() {
    return ElevatedButton(
        onPressed: () async {
          print("user grad id: ${user.gradID}");
          // formKey.currentState.save();
        },
        child: Icon(Icons.arrow_forward));
  }

  Widget makeBackButton() {
    return ElevatedButton(onPressed: () {}, child: Icon(Icons.arrow_back));
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
                "Profile Grad Selection",
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
}
