import 'package:ergo_snap/Screens/components/home_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool isLogin = true;
  late Animation<double> containerSize;
  AnimationController? animationController;
  Duration animationDuration = Duration(milliseconds: 270);

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: animationDuration);
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double defaultLoginSize = size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.45,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0XFFFF3B9D), Color(0XFFa25ce0)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [0.3, 0.7],
                    ),
              ),
              //const BoxDecoration(color: Color(0XFFFF3B9D))
            ),
          )),
          HomeComponent(size: size, defaultLoginSize: defaultLoginSize),
        ],
      ),
    );
  }
}
