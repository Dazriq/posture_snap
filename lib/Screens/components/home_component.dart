import 'package:flutter/material.dart';
import 'package:ergo_snap/components/rounded_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart'; 

class HomeComponent extends StatelessWidget {
  const HomeComponent({
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
                SizedBox(height: 90),
                Text(
                  'POSTURE\nSNAP',
                  style: GoogleFonts.atma(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    )
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: 10),

                //SvgPicture.asset('assets/images/home.svg'),
                Image.asset('assets/images/imgHomeEdited.png'),

                SizedBox(height: 40),

                RoundedButton(title: 'ASSESS', colorCode: 0XFF5BA3F8),
                
                SizedBox(height: 20),

                RoundedButton(title: 'LEARN', colorCode: 0XFF5BA3F8),

                SizedBox(height: 20),

                RoundedButton(title: 'ABOUT', colorCode: 0XFF5BA3F8),

                SizedBox(height: 20),

              ],
            ),
          ),
        ),
      ),
    );
  }
}