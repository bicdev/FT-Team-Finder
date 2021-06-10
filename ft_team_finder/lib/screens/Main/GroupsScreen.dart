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
    this.child = Groups();
  }

  @override
  set child(Widget _child) {
    super.child = _child;
  }
}

class Groups extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GroupsState();
  }
}

class GroupsState extends State<Groups> {
  List<UserProfileData> group = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is CurrentProfile) {
          this.group.addAll(state.profile.group);
          return Container(
            height: Constants.height * 0.6,
            child: Column(children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      this.group = state.profile.group;
                    });
                  },
                  child: Text("Refresh")),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: this.group.length,
                  itemBuilder: (context, position) {
                    UserProfileData member = this.group.elementAt(position);
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
                  })
            ]),
          );
        }
        return Text("This should never appear on screen");
      },
    );
  }
}
