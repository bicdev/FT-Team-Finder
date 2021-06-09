import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileBloc.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileState.dart';
import 'package:ft_team_finder/screens/Main/BrowsingProfilesScreen.dart';
import 'package:ft_team_finder/screens/Main/GroupsScreen.dart';
import 'package:ft_team_finder/screens/Main/VisualizingProfileScreen.dart';

import 'baseWidgets/baseLayout.dart';

// ignore: must_be_immutable
class HubLayout extends BaseLayout {
  HubLayout() {
    this.child = Hub();
  }

  @override
  set child(Widget _child) {
    super.child = _child;
  }
}

class Hub extends StatefulWidget {
  const Hub({Key key}) : super(key: key);

  @override
  _HubState createState() => _HubState();
}

class _HubState extends State<Hub> {
  List<Widget> telas = [];
  int telaIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (_, state) {
      if (state is CurrentProfile) {
        BrowsingProfilesScreen browsingProfilesScreen =
            BrowsingProfilesScreen();
        VisualizingProfileScreen myProfileScreen =
            VisualizingProfileScreen(state.profile, context);
        GroupsScreen myGroups = GroupsScreen();
        telas.addAll([myProfileScreen, browsingProfilesScreen, myGroups]);
      }
      return Scaffold(
        body: telas[telaIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "My Profile"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Finder"),
            BottomNavigationBarItem(
                icon: Icon(Icons.people), label: "My Group"),
          ],
          currentIndex: telaIndex,
          onTap: (int novoIndex) {
            setState(() {
              telaIndex = novoIndex;
            });
          },
          fixedColor: Colors.blueGrey,
        ),
      );
    });
  }
}
