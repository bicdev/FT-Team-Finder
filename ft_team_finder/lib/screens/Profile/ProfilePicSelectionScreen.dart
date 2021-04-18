import 'package:flutter/material.dart';
import 'package:ft_team_finder/models/ImagePicker.dart';

class ProfilePicSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.grey,
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(8),
              children: [
                makeHeaderBar(),
                ClipOval(
                  child: ImagePicker(),
                ),
                makeBottomNavigationBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget makeBottomNavigationBar() {
  return Container(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [makeBackButton(), makeForwardButton()],
  ));
}

Widget makeForwardButton() {
  return ElevatedButton(onPressed: () {}, child: Icon(Icons.arrow_forward));
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
              "Profile Picture Selection",
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