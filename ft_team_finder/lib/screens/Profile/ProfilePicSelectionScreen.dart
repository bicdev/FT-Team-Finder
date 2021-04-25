import 'package:flutter/material.dart';
import 'package:ft_team_finder/baseWidgets/ImagePicker.dart';
import 'package:ft_team_finder/baseWidgets/baseLayout.dart';

class ProfilePicSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Container(
        height: 400,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(8),
          children: [
            ClipOval(
              child: Container(
                height: 300,
                child: ImagePicker(),
              ),
            ),
          ],
        ),
      ),
      // forward: () => { Get.to()},
    );
  }
}
