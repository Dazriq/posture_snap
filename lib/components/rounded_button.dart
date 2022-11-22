import 'package:ergo_snap/vision_detector_views/pose_detector_view.dart';
import 'package:flutter/material.dart';
import 'package:ergo_snap/Screens/home.dart';
import 'package:ergo_snap/Screens/about.dart';
import 'package:ergo_snap/vision_detector_views/camera_view.dart';

import 'package:camera/camera.dart';
import 'package:ergo_snap/Screens/home.dart';
import 'package:ergo_snap/Screens/learn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({Key? key, required this.title, required this.colorCode})
      : super(key: key);

  final String title;
  final int colorCode;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        if (title == "ASSESS") {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => PoseDetectorView(),
          //       //TODO:
          //     ));
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => PoseDetectorView(),
              transitionDuration: Duration(milliseconds: 400),
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c),
            ),
          );
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
                builder: (context) => LearnScreen(),
                //TODO: login g
              ));
        }
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Color(colorCode), width: 2),
            color: Color(colorCode).withOpacity(1)),
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (title == 'ASSESS') ...[
              Icon(
                Icons.straighten,
                size: 30,
                color: Colors.white,
              ),
            ] else if (title == 'LEARN') ...[
              Icon(
                Icons.school_outlined,
                size: 30,
                color: Colors.white,
              ),
            ] else ...[
              Icon(
                Icons.article_outlined,
                size: 30,
                color: Colors.white,
              ),
            ],
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              )),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        // child: RichText(
        //   text: TextSpan(
        //     children: <InlineSpan>[
        //       TextSpan(
        //         text: title,
        //         style: GoogleFonts.cairo(
        //           textStyle: TextStyle(
        //             color: Color(colorCode),
        //             fontSize: 22,
        //             fontWeight: FontWeight.bold,
        //           )
        //         ),
        //       //   style: TextStyle(
        //       // color: Color(colorCode),
        //       // fontSize: 23,
        //       // fontWeight: FontWeight.bold),
        //       ),
        //       //                 TextSpan(
        //       //   text: '  ',
        //       //   style: TextStyle(
        //       // color: Color(colorCode),
        //       // fontSize: 23,
        //       // fontWeight: FontWeight.bold),
        //       // ),
        //       WidgetSpan(
        //         alignment: PlaceholderAlignment.middle,
        //         child: Icon(Icons.school, size: 30, color: Color(0XFFFF3B9D),),
        //       ),
        //     ],
        //   ),
        // )
        // Text(
        //   title,
        //   style: TextStyle(
        //       color: Color(colorCode),
        //       fontSize: 23,
        //       fontWeight: FontWeight.bold),
        // ),
      ),
    );
  }
}
