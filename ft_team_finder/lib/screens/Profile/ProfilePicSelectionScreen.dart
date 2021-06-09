import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_team_finder/baseWidgets/ImagePicker.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileBloc.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileEvent.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileState.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';
import 'ProfileGradSelectionScreen.dart';

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
  UserProfileData user;
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (_, state) {
      state is CurrentProfile
          ? this.user = state.profile
          : print("this shouldnt happen");
      return Container(
        height: 400,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(8),
          children: [
            Text("${this.user.name}"),
            ClipOval(
              child: Container(
                height: 300,
                child: ImagePicker(),
              ),
            ),
            ElevatedButton(
                child: Icon(Icons.forward),
                onPressed: () async {
                  dynamic bytes = await rootBundle.load("assets/peepoCute.png");
                  Uint8List blob = bytes.buffer.asUint8List();
                  this.user.img = blob;
                  BlocProvider.of<ProfileBloc>(context)
                      .add(UpdateEvent(profile: this.user));
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return Scaffold(
                        body: GradScreen(), resizeToAvoidBottomInset: false);
                  }));
                }),
          ],
        ),
      );
    });
  }
}
