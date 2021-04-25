import 'package:flutter/material.dart';
import 'package:ft_team_finder/models/LoginData.dart';

class SigninPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SigninPasswordScreenState();
  }
}

class SigninPasswordScreenState extends State<SigninPasswordScreen>{
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
                makePasswordField(),
              ])),
          makeBottomNavigationBar(),
        ]))));
  }

  Widget makeConfirmationDialog() {
    return AlertDialog(
      title: Text("Validation Required"),
      backgroundColor: Colors.yellow,
      elevation: 10,
      content: Text("Validating"),
      actions: [
        TextButton(
          child: Text("Confirm"),
          onPressed: () {
            print("Validation concluded");
            Navigator.of(formKey.currentContext).pop();
          },
        ),
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            print("Validation cancelled");
            Navigator.of(formKey.currentContext).pop();
          },
        )
      ],
    );
  }

  Widget makePasswordField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      validator: (String input) {
        bool isBigEnough = input.length > 10 ? true : false;
        if (!isBigEnough) return "Too Small!!";
        return null;
      },
      onSaved: (String input) {
        login.password = input;
      },
      decoration: InputDecoration(labelText: "Insert a strong password!"),
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
          await showDialog( context: formKey.currentContext, builder: (_) => makeConfirmationDialog(), barrierDismissible: false);
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
