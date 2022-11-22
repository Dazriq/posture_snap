import 'package:ergo_snap/Screens/about.dart';
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
                h1('What is Posture?'),
                SizedBox(
                  width: 10,
                ),
                h2(context,
                    'The way that you hold your body at any given moment, whether sitting, standing, or being active.'),
                SizedBox(height: 30),
                h1('What is Ergonomic'),
                SizedBox(height: 20),
                h2(context,
                    'A science dedicated to studying human posture and the ways that we sit and move around that are the most healthy for our bodies'),
                Padding(padding: EdgeInsets.only(top: 30)),
                roundedButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget h1(String title) {
    return Text(
      title,
      style: GoogleFonts.atma(
          textStyle: TextStyle(
              color: Color(0XFFFF3B9D),
              fontSize: 35,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget h2(context, String title) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Text(
          title,
          style: GoogleFonts.cairo(
              textStyle: TextStyle(
                  color: Color(0XFF0D6EFD),
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ));
  }

  Widget roundedButton(context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AboutScreen(),
              //TODO: login g
            ));
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Color(0XFFFF3B9D), width: 2),
            color: Color(0xFF0E3311).withOpacity(0)),
        padding: EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        child: Text(
          'CAPTURE',
          style: TextStyle(
              color: Color(0XFFFF3B9D),
              fontSize: 30,
              fontWeight: FontWeight.bold),
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
