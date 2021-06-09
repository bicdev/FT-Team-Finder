import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileBloc.dart';
import 'package:ft_team_finder/logic/ProfileBloc/ProfileState.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class GroupsScreen extends BaseLayout {
  GroupsScreen() {
    this.child = wid();
  }

  @override
  set child(Widget _child) {
    super.child = _child;
  }

  Widget wid() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is CurrentProfile) {
          return ListView.builder(itemBuilder: (context, position) {
            UserProfileData member = state.profile.group.elementAt(position);
            return ListTile(
              title: Text(member.name),
              trailing: ElevatedButton(
                child: Icon(Icons.delete),
                onPressed: () {
                  state.profile.group.remove(member);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "${member.name} removed from ${state.profile.name}'s group"),
                    duration: Constants.defaultSnackBarDuration,
                  ));
                },
              ),
            );
          });
        }
        return Text("This should never appear on screen");
      },
    );
  }
}
