import 'package:flutter/material.dart';
import 'package:ft_team_finder/screens/Profile/UserProfileData.dart';

class ProfileNameSelectionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileNameSelectionScreenState();
  }
}

class ProfileNameSelectionScreenState
    extends State<ProfileNameSelectionScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  UserProfileData user = new UserProfileData();
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          makeHeaderBar(),
          Form(
              key: formKey,
              child: Column(
                children: [
                makeNameInput(),
                Text("Do you have an alias/nickname?"),
                Row(children: [
                  makeCheckbox(),
                  Container(
                    height: 20,
                    width: 200,
                    child: makeAliasInput(),
                  )
                ]),
              ])),
          makeBottomNavigationBar()
        ],
      )),
    ));
  }

  Widget makeCheckbox() {
    return Checkbox(
        value: user.hasAlias,
        onChanged: (bool input) {
          setState(() {
            user.hasAlias = input;
          });
        });
  }

  Widget makeNameInput() {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.text,
      validator: (String input) {
        bool isEmpty = input.length == 0 ? true : false;
        if (isEmpty) return "Insert name!";
        return null;
      },
      onSaved: (String input) {
        print("Saved name: $input");
      },
      decoration:
          InputDecoration(hintText: "Tell us your name!", labelText: "Name"),
    );
  }

  Widget makeAliasInput() {
    return TextFormField(
      readOnly: !user.hasAlias,
      enabled: user.hasAlias,
      keyboardType: TextInputType.text,
      onSaved: (String input) {
        print("Saved alias: $input");
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
          formKey.currentState.save();
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
                "Profile Name Selection",
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
