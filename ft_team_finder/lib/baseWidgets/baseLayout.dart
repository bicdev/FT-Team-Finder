import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BaseLayout extends StatefulWidget {
  Widget inheritedChildren;
  BaseLayout(Widget widgetList) {
    this.inheritedChildren = widgetList;
  }

  @override
  _BaseLayoutState createState() => _BaseLayoutState(inheritedChildren);
}

class _BaseLayoutState extends State<BaseLayout> {
  Widget inheritedChildren;
  _BaseLayoutState(Widget widgetList) {
    this.inheritedChildren = widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
          Image.asset("assets/Backgrounds/bg.jpg", fit: BoxFit.cover),
          SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Container(
                  // padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      makeLogoPicContainer(),
                      makeProfilePicContainer()
                    ],
                  ),
                ),
                Divider(
                  color: Colors.pink,
                  height: 10.0,
                  thickness: 5.0,
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: inheritedChildren,
                ),
                Divider(
                  height: 10.0,
                  thickness: 5.0,
                ),
                makeBottomNavigationBar(),
              ],
            ),
          ))
        ]);
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
          print("hi");
          // formKey.currentState.save();
        },
        child: Icon(Icons.arrow_forward));
  }

  Widget makeBackButton() {
    return ElevatedButton(onPressed: () {}, child: Icon(Icons.arrow_back));
  }
}
