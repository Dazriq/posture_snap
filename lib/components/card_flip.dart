import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardFlip extends StatelessWidget {
  const CardFlip(
      {Key? key, required this.icon, required this.title, required this.result})
      : super(key: key);

  final String icon;
  final String title;
  final String result;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String path = 'assets/icons/' + icon;
    double widthContainer = 100, heightContainer = 125;
    int colorCode = 0XFF38E54D;
    switch (result) {
      case 'EXCELLENT':
        colorCode = 0XFF38E54D;
        break;

      case 'GOOD':
        colorCode = 0XFFFCE700;
        break;

      case 'FAIR':
        colorCode = 0XFFFF7000;
        break;

      case 'POOR':
        colorCode = 0XFFDC3535;
        break;

      default:
        break;
    }
    return Container(
        width: widthContainer,
        height: heightContainer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(colorCode),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child: Container(
                  padding: EdgeInsets.all(15),
                  child: Image.asset(
                    path,
                    color: Colors.white,
                  )),
              onTap: () {},
            ),
            Text(
              title,
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2)),
            ),
          ],
        ));
  }
}
