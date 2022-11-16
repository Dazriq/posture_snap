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
                Padding(padding: EdgeInsets.only(top: 90)
                ), 
                Text(
                  'Ergo Snap',
                  style: GoogleFonts.pacifico(
                    textStyle: TextStyle(
                      color: Color(0XFFFF3B9D),
                      fontSize: 70, 
                    )
                  ),
                ),
                
                SizedBox(height: 30),

                SvgPicture.asset('assets/images/login.svg'),

                SizedBox(height: 30),

                RoundedButton(title: 'ASSESS'),
                
                SizedBox(height: 30),

                RoundedButton(title: 'ABOUT'),

                SizedBox(height: 30),

                RoundedButton(title: 'DONATE'),

                SizedBox(height: 30),

              ],
            ),
          ),
        ),
      ),
    );
  }
}