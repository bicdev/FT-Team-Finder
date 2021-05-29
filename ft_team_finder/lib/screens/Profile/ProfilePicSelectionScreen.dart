import 'package:flutter/material.dart';
import 'package:ft_team_finder/baseWidgets/ImagePicker.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';
import 'package:ft_team_finder/baseWidgets/customDialog.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';
import 'package:ft_team_finder/screens/Profile/ProfileGradSelectionScreen.dart';

class ProfilePicSelectionScreen extends StatefulWidget {
  @override
  _ProfilePicSelectionScreenState createState() =>
      _ProfilePicSelectionScreenState();
}

class _ProfilePicSelectionScreenState extends State<ProfilePicSelectionScreen> {
  UserProfileData user = new UserProfileData(loginData: null);
  Image imgPicking;
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      home: () => home(),
      forward: () => forward(),
      child: Container(
        height: 400,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(8),
          children: [
            ClipOval(
              child: Container(
                height: 300,
                child: ImagePicker(),
              ),
            ),
          ],
        ),
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
    // setState(() {
    //   this.user.img = ImagePicker().getImage(); //placeholder
    // });
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              resizeToAvoidBottomInset: false,
              body: ProfileGradSelectionScreen()));
    }));
  }
}
