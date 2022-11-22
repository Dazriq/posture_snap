import 'package:ergo_snap/Screens/components/learn_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LearnScreen extends StatefulWidget {
  @override
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> with SingleTickerProviderStateMixin {
  
  bool isLogin = true;
  late Animation<double> containerSize;
  AnimationController? animationController;
  Duration animationDuration = Duration(milliseconds: 270);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: animationDuration);
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

          // Login Form
          LearnComponent(size: size, defaultLoginSize: defaultLoginSize),
        ],
      ),
    );
  }
}
