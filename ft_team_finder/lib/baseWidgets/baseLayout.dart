import 'package:flutter/material.dart';

import '../constants.dart';

// ignore: must_be_immutable
abstract class BaseLayout extends StatelessWidget {
  Widget child;

  @override
  Widget build(BuildContext context) {
    Constants().init(context);
    return Container(
      width: Constants.height * 0.62,
      height: Constants.height * 0.62,
      child: Stack(fit: StackFit.expand, children: [
        Image.asset("assets/Backgrounds/bg.jpg", fit: BoxFit.cover),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
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
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: child,
                ),
                Divider(
                  height: 10.0,
                  thickness: 5.0,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget makeLogoPicContainer() {
    return Container(
      child: ClipOval(
        child: Image.asset(
          'assets/appLogo.png', //placeholder
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
          "assets/peepoCute.png",
          height: 100,
          width: 100,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
