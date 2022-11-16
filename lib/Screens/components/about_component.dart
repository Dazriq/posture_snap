import 'package:ergo_snap/Screens/about.dart';
import 'package:flutter/material.dart';
import 'package:ergo_snap/components/rounded_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ergo_snap/components/rounded_button.dart';

class AboutComponent extends StatelessWidget {
  const AboutComponent({
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
                Padding(padding: EdgeInsets.only(top: 30)),
                Container(
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
                    )),
                Text(
                  'What is Ergo Snap?',
                  style: GoogleFonts.pacifico(
                      textStyle: TextStyle(
                    color: Color(0XFFFF3B9D),
                    fontSize: 35,
                  )),
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: RichText(
                    text: TextSpan(
                      text: '',
                      
                      children: <TextSpan>[
                        TextSpan(
                            text: 'A mobile application where ',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Color(0XFF0D6EFD),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                        TextSpan(
                            text: 'YOU ',
                            style: GoogleFonts.pacifico(
                                textStyle: TextStyle(
                                    color: Color(0XFFFF3B9D),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold))),
                        TextSpan(
                            text:
                                'could evaluate your own ergonomics only by snapping picture!',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Color(0XFF0D6EFD),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 30)),
                Text(
                  'How do I Ergo Snap?',
                  style: GoogleFonts.pacifico(
                      textStyle: TextStyle(
                    color: Color(0XFFFF3B9D),
                    fontSize: 35,
                  )),
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: RichText(
                    text: TextSpan(
                      text: '',
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                'You just press the button below, take a posture picture, then you\'re done! ',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Color(0XFF0D6EFD),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 30)),
                InkWell(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
