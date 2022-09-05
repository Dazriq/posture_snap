import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../services/model_inference_service.dart';
import '../../constants/data.dart';
 import '../camera/camera_page.dart';
import '../../../services/service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Select Your Model',
            style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(28),
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () => _onTapCamera(context),
            child: Text('Pose Estimation'),
          ),
        ));
  }

  void _onTapCamera(BuildContext context) {
    locator<ModelInferenceService>().setModelConfig();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CameraPage();
        },
      ),
    );
  }
}


