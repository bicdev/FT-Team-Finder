import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BaseLayout extends StatelessWidget {
  Widget child;
  Function forward;
  final VoidCallback forwardSelected;

  BaseLayout({@required Widget child, this.forwardSelected, this.forward}) {
    this.child = child;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Image.asset("assets/Backgrounds/bg.jpg", fit: BoxFit.cover),
      SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              // padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [makeLogoPicContainer(), makeProfilePicContainer()],
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
      children: [makeForwardButton()],
    ));
  }

  Widget makeForwardButton() {
    return ElevatedButton(
        onPressed: () => forwardSelected(),
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.pink)),
        child: Icon(Icons.arrow_forward));
  }
}