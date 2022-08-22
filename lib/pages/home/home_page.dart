import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../services/model_inference_service.dart';
import '../../constants/data.dart';
import 'widgets/model_card.dart';
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
          return CameraPage(index: 0);
        },
      ),
    );
  }
}

class _ModelPreview extends StatelessWidget {
  const _ModelPreview({
    Key? key,
    required this.pageController,
    required this.currentPageValue,
  }) : super(key: key);

  final PageController pageController;
  final double currentPageValue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: ScreenUtil().setHeight(450.0),
        child: PageView.builder(
          controller: pageController,
          physics: const BouncingScrollPhysics(),
          itemCount: models.length,
          itemBuilder: (context, index) {
            var scale = (currentPageValue - index).abs();
            return ModelCard(
              index: index,
              scale: scale,
            );
          },
        ),
      ),
    );
  }
}
