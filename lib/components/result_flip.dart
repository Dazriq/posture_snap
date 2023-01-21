import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../rula/result.dart';

class ResultFlip extends StatefulWidget {
  ResultFlip({
    Key? key,
    required this.result,
  }) : super(key: key);

  Result? result;
  @override
  State<ResultFlip> createState() => _ResultFlipState();
}

class _ResultFlipState extends State<ResultFlip> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int colorCode = 0XFF38E54D;
    int? rebaScore = widget.result!.rebaScore;

    if (rebaScore != null) {
      if (rebaScore >= 1 && rebaScore <= 3) {
        colorCode = 0XFFFCE700;
      } else if (rebaScore >= 4 && rebaScore <= 7) {
        colorCode = 0XFFFCE700;
      } else if (rebaScore >= 8 && rebaScore <= 10) {
        colorCode = 0XFFFF7000;
      } else if (rebaScore >= 11) {
        colorCode = 0XFFDC3535;
      }
    }
    //return card(colorCode, path);
    // returning MaterialApp
    return FlipCard(
      direction: FlipDirection.VERTICAL,
      speed: 400,
      // front of the card
      front: overallResultFront(widget.result!.rebaScore),

      // back of the card
      back: overallResultBack(),
    );
  }

  Widget overallResultBack() {
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
                Icons.sentiment_very_satisfied_outlined,
                size: 60,
                color: Colors.white,
              ),
            ] else if (result == 'GOOD') ...[
              Icon(
                Icons.sentiment_very_satisfied,
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
                Icons.sentiment_very_dissatisfied_outlined,
                size: 60,
                color: Colors.white,
              ),
            ],
            SizedBox(
              height: 10,
            ),
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

  Widget overallResultFront(int? rebaScore) {
    int colorCode = 0XFF555555;
    String message = '';
    int score = 0;
    String title = '';

    if (rebaScore != null) {
      if (rebaScore >= 1 && rebaScore <= 3) {
        colorCode = 0XFF38E54D;
        score = 1;
        message = 'You have an excellent posture';
        title = 'EXCELLENT';
      } else if (rebaScore >= 4 && rebaScore <= 7) {
        colorCode = 0XFFFCE700;
        score = 2;
        message = 'You have a good posture';
        title = 'GOOD';
      } else if (rebaScore >= 8 && rebaScore <= 10) {
        colorCode = 0XFFFF7000;
        score = 3;
        message = 'You have a fair posture';
        title = 'FAIR';
      } else if (rebaScore >= 11) {
        colorCode = 0XFFDC3535;
        score = 4;
        message = 'Please fix your posture';
        title = 'POOR';
      }
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
          if (score == 1) ...[
            Icon(
              Icons.sentiment_very_satisfied_outlined,
              size: 90,
              color: Colors.white,
            ),
          ] else if (score == 2) ...[
            Icon(
              Icons.sentiment_very_satisfied,
              size: 90,
              color: Colors.white,
            ),
          ] else if (score == 3) ...[
            Icon(
              Icons.sentiment_neutral,
              size: 90,
              color: Colors.white,
            ),
          ] else ...[
            Icon(
              Icons.sentiment_very_dissatisfied_outlined,
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
