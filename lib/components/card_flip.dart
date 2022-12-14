import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardFlip extends StatefulWidget {
  const CardFlip(
      {Key? key, required this.icon, required this.title, required this.result, required this.angle})
      : super(key: key);

  final String icon;
  final String title;
  final String result;
  final double angle;
  @override
  State<CardFlip> createState() => _CardFlipState();
}

class _CardFlipState extends State<CardFlip> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String path = 'assets/icons/' + widget.icon;
    //convert angle to 2 decimal places and string
    num angleRoundOff = num.parse(widget.angle.toStringAsFixed(1));
    String angleRoundOffString = ' ' + angleRoundOff.toString() + '°';

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
    //return card(colorCode, path);
    // returning MaterialApp
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      speed: 400,
      // front of the card
      front: cardFront(colorCode, path),

      // back of the card
      back: cardBack(colorCode, angleRoundOffString),
    );
  }

  //TODO: enable click to flip the card
  Widget cardFront(int colorCode, String path) {
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
            Container(
              child: Container(
                  padding: EdgeInsets.all(15),
                  child: Image.asset(
                    path,
                    color: Colors.white,
                  )),
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

  Widget cardBack(int colorCode, String angle) {
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
            Container(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  angle,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )),
                ),
              ),
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
