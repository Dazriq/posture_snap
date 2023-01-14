import 'package:ergo_snap/Screens/about.dart';
import 'package:ergo_snap/vision_detector_views/camera_view.dart';
import 'package:ergo_snap/vision_detector_views/pose_detector_view.dart';
import 'package:flutter/material.dart';
import 'package:ergo_snap/components/rounded_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ergo_snap/components/rounded_button.dart';

class LearnComponent extends StatelessWidget {
  const LearnComponent({
    Key? key,
    required this.size,
    required this.defaultLoginSize,
  }) : super(key: key);

  final Size size;
  final double defaultLoginSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: size.width,
          height: defaultLoginSize,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                backButton(context),
                h1(context, 'What is Posture?'),
                SizedBox(
                  width: 10,
                ),
                h2(context,
                    'The position of your body that you hold while sitting, standing, or being active.'),
                SizedBox(height: 20),
                h1(context, 'Why Does Posture Matter?'),
                SizedBox(height: 10),
                h2(context,
                    'Bad posture could lead to:\nBack pain, Spinal dysfunction, Joint degeneration and Poor circulation'),
                SizedBox(height: 20),
                h1(context, 'How to Assess my own Posture?'),
                SizedBox(height: 10),
                h2(context,
                    'You just press the button below, take a posture picture, then you\'re done!'),
                SizedBox(
                  height: 30,
                ),
                RoundedButton(title: 'ASSESS', colorCode: 0XFFFF3B9D),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget h1(context, String title) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                  color: Color(0XFFFF3B9D),
                  fontSize: 33,
                  height: 1.5,
                  fontWeight: FontWeight.bold)),
        ));
  }

  Widget h2(context, String title) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                  color: Color(0XFF0D6EFD),
                  height: 1.8,
                  fontSize: 20,
                  )),
        ));
  }

  Widget roundedButton(context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PoseDetectorView(),
              //TODO: login g
            ));
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: size.width * 0.85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Color(0XFFFF3B9D), Color(0XFFa25ce0)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.3, 0.7],
          ),
        ),
        // decoration: BoxDecoration(
        //     //borderRadius: BorderRadius.circular(30),
        //     border: Border.all(color: Color(0XFFFF3B9D), width: 2),
        //     color: Color(0xFF0E3311).withOpacity(0)),
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        child: Text(
          'ASSESS',
          style: GoogleFonts.cairo(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget backButton(context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ));
  }
}
