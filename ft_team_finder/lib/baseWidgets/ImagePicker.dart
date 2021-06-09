import 'package:flutter/material.dart';

class ImagePicker extends StatefulWidget {
// NOT USING ACTUAL IMPLEMENTATION
  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  Image img;

  static Widget getImage() {
    final String picPath = "assets/peepoCute.png";
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
          child: img,
        ),
        ClipOval(
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  this.img = getImage();
                });
              },
              child: Icon(Icons.camera_alt)),
        ),
      ],
    );
  }
}
