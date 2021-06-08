import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_team_finder/baseWidgets/ImagePicker.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileBloc.dart';

import 'ProfileSkillSelectionScreen.dart';

// ignore: must_be_immutable
class PicScreen extends BaseLayout {
  PicScreen() {
    this.child = ProfilePicSelectionScreen();
  }

  @override
  set child(Widget _child) {
    super.child = _child;
  }
}

class ProfilePicSelectionScreen extends StatefulWidget {
  @override
  _ProfilePicSelectionScreenState createState() =>
      _ProfilePicSelectionScreenState();
}

class _ProfilePicSelectionScreenState extends State<ProfilePicSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.forward),
        onPressed: forward(),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
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

  forward() {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return BlocProvider.value(
          value: BlocProvider.of<ProfileBloc>(context), child: SkillsScreen());
    }));
  }
}
