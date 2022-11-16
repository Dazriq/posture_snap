import 'package:ergo_snap/vision_detector_views/pose_detector_view.dart';
import 'package:flutter/material.dart';
import 'package:ergo_snap/Screens/home.dart';
import 'package:ergo_snap/Screens/about.dart';
import 'package:ergo_snap/vision_detector_views/camera_view.dart';

import 'package:camera/camera.dart';
import 'package:ergo_snap/Screens/home.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        if (title == "ASSESS") {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PoseDetectorView(),
                //TODO:
              ));
        } else if (title == "ABOUT") {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AboutScreen(),
                //TODO:
              ));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
                //TODO: login g
              ));
        }
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Color(0XFF0D6EFD), width: 2),
            color: Color(0xFF0E3311).withOpacity(0)),
        padding: EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
              color: Color(0XFF0D6EFD),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
