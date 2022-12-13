import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardFlip extends StatefulWidget {
  const CardFlip(
      {Key? key, required this.icon, required this.title, required this.result})
      : super(key: key);

  final String icon;
  final String title;
  final String result;
  @override
  State<CardFlip> createState() => _CardFlipState();
}

class _CardFlipState extends State<CardFlip> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String path = 'assets/icons/' + widget.icon;
    int colorCode = 0XFF38E54D;
    switch (widget.result) {
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
    return card(colorCode, path);
  }
  //TODO: enable click to flip the card
  Widget card(int colorCode, String path) {
    double widthContainer = 100, heightContainer = 125;
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
              widget.title,
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
