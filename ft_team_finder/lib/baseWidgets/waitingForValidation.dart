import 'package:flutter/material.dart';

class WaitingForValidation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {

          showDialog( context: formKey.currentContext, builder: (_) => makeConfirmationDialog(), barrierDismissible: false);
          // print("yo");
        });
      });
    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Linear progress indicator with a fixed color',
              style: Theme.of(context).textTheme.headline6,
            ),
            CircularProgressIndicator(
              value: controller.value,
              semanticsLabel: 'Linear progress indicator',
            ),
          ],
        ),
      ),
    );
  }

  Widget makeConfirmationDialog() {
    return AlertDialog(
      title: Text("Confirmation Required"),
      backgroundColor: Colors.yellow,
      elevation: 10,
      content: Text("Validating"),
      actions: [
        TextButton(
          child: Text("Confirm"),
          onPressed: () {
            Navigator.of(formKey.currentContext).pop();
          },
        ),
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(formKey.currentContext).pop();
          },
        )
      ],
    );
  }
}