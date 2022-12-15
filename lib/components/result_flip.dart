import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultFlip extends StatefulWidget {
  const ResultFlip({
    Key? key,
    required this.result,
  }) : super(key: key);

  final String result;
  @override
  State<ResultFlip> createState() => _ResultFlipState();
}

class _ResultFlipState extends State<ResultFlip> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
      direction: FlipDirection.VERTICAL,
      speed: 400,
      // front of the card
      front: overallResultFront(widget.result),

      // back of the card
      back: overallResultBack(widget.result),
    );
  }

  Widget overallResultBack(String result) {
    int colorCode = 0XFF555555;
    int green = 0XFF38E54D;
    int yellow = 0XFFFCE700;
    int orange = 0XFFFF7000;
    int red = 0XFFDC3535;

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 110,
      decoration: BoxDecoration(
        color: Color(colorCode),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          squaredResult('EXCELLENT', green),
          squaredResult('GOOD', yellow),
          squaredResult('FAIR', orange),
          squaredResult('POOR', red),
        ],
      ),
    );
  }

  Widget squaredResult(String result, int color) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9 / 4,
        height: 110,
        color: Color(color),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (result == 'EXCELLENT') ...[
              Icon(
                Icons.sentiment_very_satisfied,
                size: 60,
                color: Colors.white,
              ),
            ] else if (result == 'GOOD') ...[
              Icon(
                Icons.sentiment_satisfied,
                size: 60,
                color: Colors.white,
              ),
            ] else if (result == 'FAIR') ...[
              Icon(
                Icons.sentiment_neutral,
                size: 60,
                color: Colors.white,
              ),
            ] else ...[
              Icon(
                Icons.sentiment_dissatisfied,
                size: 60,
                color: Colors.white,
              ),
            ],
            SizedBox(height: 10,), 
            Text(
              result,
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2)),
            ),
          ],
        ));
  }

  Widget overallResultFront(title) {
    int colorCode = 0XFF555555;
    String message = '';
    switch (title) {
      case 'EXCELLENT':
        colorCode = 0XFF38E54D;
        message = 'You have an excellent posture';

        break;

      case 'GOOD':
        colorCode = 0XFFFCE700;
        message = 'You have a good posture';

        break;

      case 'FAIR':
        colorCode = 0XFFFF7000;
        message = 'You have a fair posture';

        break;

      case 'POOR':
        colorCode = 0XFFDC3535;
        message = 'Please fix your posture';
        break;

      default:
        break;
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 110,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(colorCode),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (title == 'EXCELLENT') ...[
            Icon(
              Icons.sentiment_very_satisfied,
              size: 90,
              color: Colors.white,
            ),
          ] else if (title == 'GOOD') ...[
            Icon(
              Icons.sentiment_satisfied,
              size: 90,
              color: Colors.white,
            ),
          ] else if (title == 'FAIR') ...[
            Icon(
              Icons.sentiment_neutral,
              size: 90,
              color: Colors.white,
            ),
          ] else ...[
            Icon(
              Icons.sentiment_dissatisfied,
              size: 90,
              color: Colors.white,
            ),
          ],
          SizedBox(
            width: 10,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2)),
                ),
                FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    message,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    )),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
