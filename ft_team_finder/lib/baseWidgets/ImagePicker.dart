import 'package:flutter/material.dart';

class ImagePicker extends StatelessWidget {
// NOT USING ACTUAL IMPLEMENTATION, HOPE TO SEE IN CLASS
  final String picPath = "assets/peepoCute.png";

  Widget getImage() {
// RETURNING PLACEHOLDER PROFILE IMAGE
    return Image.asset(
      picPath,
      height: 300,
      width: 300,
      fit: BoxFit.fill,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          color: Colors.black,
          alignment: Alignment.center,
          child: getImage(),
        ),
        ClipOval(
          child: ElevatedButton(
              onPressed: () {
                print("Trying to change image");
              },
              child: Icon(Icons.camera_alt)),
        ),
      ],
    );
  }
}
