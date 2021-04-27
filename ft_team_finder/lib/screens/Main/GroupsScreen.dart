import 'package:flutter/material.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';
import 'package:ft_team_finder/dummy.dart';
import 'package:ft_team_finder/models/Groups.dart';
import 'package:ft_team_finder/models/UserProfileData.dart';
import '../../constants.dart';
import 'BrowsingProfilesScreen.dart';

class GroupsScreen extends StatefulWidget {
  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Dummy d = new Dummy();
  UserProfileData user; //this is placeholder, will be current logged in users
  String groupName;
  String groupDescription;
  bool _fadeState = true;

  @override
  Widget build(BuildContext context) {
    Constants().init(context);
    user = Constants.loggedInUser;

    Widget creationLayout = Container(
        child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  onSaved: (String input) {
                    setState(() {
                      this.groupName = input;
                    });
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: "Group's Name"),
                ),
                TextFormField(
                  onSaved: (String input) {
                    setState(() {
                      this.groupDescription = input;
                    });
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: "Group's Description"),
                ),
              ],
            )));

    return BaseLayout(
      forward: () {
        setState(() => forward());
      },
      home: () {
        setState(() => home());
      },
      child: Column(
        children: [
          makeLayoutSwapper(),
          makeAnimatedCrossFade(makeGroupsLayout(), creationLayout),
        ],
      ),
    );
  }

  Widget makeGroupsLayout() {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: constraints.maxWidth,
        height: Constants.height * 0.55, //yeah magic number i know
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: user.groups.length,
          itemBuilder: (BuildContext context, int index) {
            return ExpansionTile(
              title: Text(user.groups[index].name),
              subtitle: Text("${user.groups[index].description}"),
              trailing: makeDeleteGroupButton(user, index),
              children: [
                Container(
                  width: Constants.width * 0.5,
                  height: Constants.height * 0.3,
                  child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text("${user.groups[index].members[index].name}"),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      );
    });
  }

  Widget makeAnimatedCrossFade(Widget from, Widget into) {
    return AnimatedCrossFade(
        firstChild: from,
        secondChild: into,
        crossFadeState:
            _fadeState ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: Duration(seconds: 2));
  }

  Widget makeLayoutSwapper() {
    IconData icon = _fadeState ? Icons.add : Icons.search;
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.pink)),
        onPressed: () {
          setState(() {
            _fadeState = !_fadeState;
          });
        },
        child: Icon(icon));
  }

  Widget makeDeleteGroupButton(UserProfileData user, int index) {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            user.groups.removeAt(index);
          });
          print("removed $index group from ${user.name}");
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.pink)),
        child: Icon(Icons.delete));
  }

  forward() {
    if (_fadeState == false) {
      this.formKey.currentState.save();
      print("$groupName $groupDescription");
      Groups g = new Groups(
          groupID: getUnusedId(),
          description: this.groupDescription,
          name: this.groupName,
          members: List.empty(growable: true),
          leader: this.user);
          Constants.loggedInUser.groups.add(g);
          // user.groups.add(g);
          // Dummy.getUser(0).groups.add(g);
      this.formKey.currentState.reset();
    } else
      print("nothing");
  }

  home() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              resizeToAvoidBottomInset: false, body: BrowsingProfilesScreen()));
    }));
  }

  int getUnusedId() {
    int query = 0; //placeholding for the size of a sql query of all groups
    return query + 1;
  }
}