import 'package:flutter/material.dart';
import 'package:ft_team_finder/models/LoginData.dart';

class SigninEmailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SigninEmailScreenState();
  }
}

class SigninEmailScreenState extends State<SigninEmailScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  LoginData login = new LoginData();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: SafeArea(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
          makeHeaderBar(),
          Form(
              key: formKey,
              child: Column(children: [
                makeEmailField(),
              ])),
              makeBottomNavigationBar(),
        ]))));
  }

  Widget makeEmailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (String input) {
        bool isEmpty = input.length == 0 ? true : false;
        if (isEmpty) return "Insert email!";
        return null;
      },
      onSaved: (String input) {
        login.email = input;
        print("login email: ${login.email}");
      },
      decoration: InputDecoration(
          hintText: "user@domain.br", labelText: "Email Address"),
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
          formKey.currentState.save();
        },
        child: Icon(Icons.arrow_forward));
  }

  Widget makeBackButton() {
    return ElevatedButton(onPressed: () {}, child: Icon(Icons.arrow_back));
  }

  Widget makeHeaderBar() {
    return Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          makeLogoPicContainer(),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Text(
                "Sign In",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
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
}
