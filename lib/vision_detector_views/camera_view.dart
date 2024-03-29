import 'dart:io';
import 'dart:ui' as ui;
import 'package:ergo_snap/vision_detector_views/pose_detector_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ergo_snap/components/rounded_button.dart';
import 'package:ergo_snap/components/card_flip.dart';
import 'package:ergo_snap/components/result_flip.dart';

import 'package:google_fonts/google_fonts.dart';
import '../Screens/components/camera_carousel.dart';
import '../main.dart';
import '../rula/result.dart';

enum ScreenMode { liveFeed, gallery }

class CameraView extends StatefulWidget {
  CameraView(
      {Key? key,
      required this.title,
      required this.customPaint,
      this.text,
      required this.result,
      required this.onImage,
      this.onScreenModeChanged,
      this.initialDirection = CameraLensDirection.back})
      : super(key: key);

  final String title;
  final CustomPaint? customPaint;
  final String? text;
  Result? result;
  final Function(InputImage inputImage) onImage;
  final Function(ScreenMode mode)? onScreenModeChanged;
  final CameraLensDirection initialDirection;

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  ScreenMode _mode = ScreenMode.gallery;
  CameraController? _controller;
  File? _image;
  String? _path;
  Size? _imgSize;
  bool isFabVisible = false;
  ImagePicker? _imagePicker;
  int _cameraIndex = 0;
  double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;

  @override
  void initState() {
    super.initState();

    _imagePicker = ImagePicker();

    if (cameras.any(
      (element) =>
          element.lensDirection == widget.initialDirection &&
          element.sensorOrientation == 90,
    )) {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere((element) =>
            element.lensDirection == widget.initialDirection &&
            element.sensorOrientation == 90),
      );
    } else {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere(
          (element) => element.lensDirection == widget.initialDirection,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      floatingActionButton: isFabVisible
          ? FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => PoseDetectorView()));
              },
              label: Text(
                'Re-Assess',
                style: GoogleFonts.cairo(
                    textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
                textAlign: TextAlign.center,
              ),
              icon: Icon(
                Icons.replay,
              ),
              backgroundColor: Color(0XFFFF3B9D))
          : null,
    );
  }

  Widget _body() {
    Widget body;
    body = cameraViewBody();
    return body;
  }

  Widget cameraViewBody() {
    final Shader _linearGradient = const LinearGradient(
      colors: [Color(0XFFFF3B9D), Color(0XFFa25ce0)],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      stops: [0.3, 0.7],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 320.0, 80.0));
    return Container(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      _image != null
                          ? Container(
                              child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.45,
                              child: const DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0XFFFF3B9D),
                                      Color(0XFFa25ce0)
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    stops: [0.3, 0.7],
                                  ),
                                ),
                                //const BoxDecoration(color: Color(0XFFFF3B9D))
                              ),
                            ))
                          : SizedBox(
                              height: 0,
                            ),
                      Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 1,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 30),
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Stack(
                                        alignment: Alignment.topLeft,
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.arrow_back),
                                            color: Colors.white,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      )),
                                  _image == null
                                      ? Text(
                                          'POSTURE\nSNAP',
                                          style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                            fontSize: 60,
                                            fontWeight: FontWeight.bold,
                                            height: 1.1,
                                            letterSpacing: 3,
                                            foreground: Paint()
                                              ..shader = _linearGradient,
                                          )),
                                          textAlign: TextAlign.center,
                                        )
                                      : Text(
                                          'RESULT',
                                          style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                            fontSize: 60,
                                            fontWeight: FontWeight.bold,
                                            height: 1.1,
                                            letterSpacing: 3,
                                            color: Colors.white,
                                          )),
                                          textAlign: TextAlign.center,
                                        ),
                                  SizedBox(height: 10),
                                  resultImg(),
                                  //resultImg(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _image != null
                                      ? SizedBox(height: 10)
                                      : Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: 100,
                                          color: Colors.red.withOpacity(0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              squareIconButton('camera'),
                                              squareIconButton('gallery')
                                            ],
                                          ),
                                        ),
                                  _image != null
                                      ? SizedBox(height: 0)
                                      : SizedBox(
                                          height: 50,
                                        ),
                                  _image != null
                                      ? SizedBox(height: 0)
                                      : Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: Text(
                                            'Make sure that you take picture from the angle as the illustration above\nDisclaimer : This application is not connected to a server, hence your privacy is protected.',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                              color: Color(0XFF0D6EFD),
                                              height: 1,
                                              fontSize: 15,
                                            )),
                                          )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //TODO: DO THE JOINTS ANALYSIS

                _image != null && widget.result != null
                    ? ResultFlip(result: widget.result)
                    : SizedBox(
                        height: 0,
                      ),
                SizedBox(
                  height: 20,
                ),
                _image != null && widget.result != null
                    ? resultIconsSquared(widget.result!)
                    : SizedBox(
                        height: 0,
                      ),
                _image != null && widget.result == null
                    ? failedResult()
                    : SizedBox(
                        height: 0,
                      ),
                SizedBox(
                  height: 90,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget failedResult() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 110,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0XFFDC3535),
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
          Icon(
            Icons.sentiment_very_dissatisfied_outlined,
            size: 90,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'NO RESULT',
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
                    'No pose found',
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

  Widget resultIconsSquared(Result result) {
    double neckAngle = widget.result!.neckAngle!;
    double upperArmAngle = widget.result!.upperArmAngle!;
    double lowerArmAngle = widget.result!.lowerArmAngle!;
    double wristAngle = widget.result!.wristAngle!;
    double trunkAngle = widget.result!.trunkAngle!;
    double kneeAngle = widget.result!.kneeAngle!;

    int neckScore = widget.result!.neckScore!;
    int upperArmScore = widget.result!.upperArmScore!;
    int lowerArmScore = widget.result!.lowerArmScore!;
    int wristScore = widget.result!.wristScore!;
    int trunkScore = widget.result!.trunkScore!;
    int kneeScore = widget.result!.kneeScore!;

    String neckResult = 'P0OR';
    String trunkResult = 'P0OR';
    String upperArmResult = 'POOR';
    String lowerArmResult = 'POOR';
    String wristResult = 'POOR';
    String kneeResult = 'POOR';

    if (neckScore >= 4)
      neckResult = 'POOR';
    else if (neckScore == 1)
      neckResult = 'EXCELLENT';
    else if (neckScore == 2)
      neckResult = 'GOOD';
    else if (neckScore == 3) neckResult = 'FAIR';

    if (trunkScore >= 1 && trunkScore <= 2)
      trunkResult = 'EXCELLENT';
    else if (trunkScore == 3)
      trunkResult = 'GOOD';
    else if (trunkScore == 4)
      trunkResult = 'FAIR';
    else if (trunkScore >= 5) trunkResult = 'POOR';

    if (kneeScore == 2 || kneeScore == 1)
      kneeResult = 'GOOD';
    else if (kneeScore == 3)
      kneeResult = 'FAIR';
    else if (kneeScore >= 4) kneeResult = 'POOR';

    if (upperArmScore >= 1 && upperArmScore <= 2)
      upperArmResult = 'EXCELLENT';
    else if (upperArmScore == 3)
      upperArmResult = 'GOOD';
    else if (upperArmScore >= 4 && upperArmScore <= 5)
      upperArmResult = 'FAIR';
    else if (upperArmScore >= 6) upperArmResult = 'POOR';

    if (lowerArmScore == 1)
      lowerArmResult = 'GOOD';
    else if (lowerArmScore == 2) lowerArmResult = 'FAIR';

    if (wristScore == 1)
      wristResult = 'GOOD';
    else if (wristScore == 2)
      wristResult = 'FAIR';
    else if (wristScore == 3) wristResult = 'POOR';

    return Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              CardFlip(
                  icon: 'neck.png',
                  title: 'NECK',
                  result: neckResult,
                  angle: double.parse((neckAngle).toStringAsFixed(2))),
              CardFlip(
                  icon: 'shoulder.png',
                  title: 'SHOULDER',
                  result: upperArmResult,
                  angle: double.parse((upperArmAngle).toStringAsFixed(2))),
              CardFlip(
                  icon: 'arm.png',
                  title: 'ARM',
                  result: lowerArmResult,
                  angle: double.parse((lowerArmAngle).toStringAsFixed(2))),
            ]),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              CardFlip(
                  icon: 'wrist.png',
                  title: 'WRIST',
                  result: wristResult,
                  angle: double.parse((wristAngle).toStringAsFixed(2))),
              CardFlip(
                  icon: 'trunk.png',
                  title: 'TRUNK',
                  result: trunkResult,
                  angle: double.parse((trunkAngle).toStringAsFixed(2))),
              CardFlip(
                  icon: 'leg.png',
                  title: 'LEG',
                  result: kneeResult,
                  angle: double.parse((kneeAngle).toStringAsFixed(2))),
            ]),
          ],
        ));
  }

  void getImgSize() async {
    File image = _image!; // Or any other way to get a File instance.
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    _imgSize =
        Size(decodedImage.width.toDouble(), decodedImage.height.toDouble());
  }

  Widget resultImg() {
    //TODO: get image width and height to align the image
    if (_image != null) {
      //getImgSize()
      return Container(
          height: 420,
          width: 320,
          // padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                    child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //const BoxDecoration(color: Color(0XFFFF3B9D))
                )),
                Container(
                  padding: EdgeInsets.all(20),
                  // padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.file(_image!),
                      if (widget.customPaint != null) widget.customPaint!,
                    ],
                  ),
                ),
              ],
            ),
          ));
    } else {
      return CameraCarousel();
    }
  }

  Widget squareIconButton(String title) {
    if (title == 'camera') {
      return InkWell(
          onTap: () => {
                {_getImage(ImageSource.camera)}
              },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.35,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                //border: Border.all(color: Color(0XFFFF3B9D), width: 2),
                color: Color(0XFFFF3B9D).withOpacity(1)),
            child: Icon(
              Icons.photo_camera_outlined,
              size: 60,
              color: Colors.white,
            ),
          ));
    } else {
      return InkWell(
          onTap: () => {
                {_getImage(ImageSource.gallery)}
              },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.35,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0XFFFF3B9D), width: 2),
                color: Color(0xFF0E3311).withOpacity(0)),
            child: Icon(
              Icons.photo_outlined,
              size: 60,
              color: Color(0XFFFF3B9D),
            ),
          ));
    }
  }

  Widget poseAssessment() {
    return SizedBox();
  }

  Future _getImage(ImageSource source) async {
    setState(() {
      _image = null;
      _path = null;
    });
    final pickedFile = await _imagePicker?.pickImage(source: source);
    if (pickedFile != null) {
      _processPickedFile(pickedFile);
    }
    setState(() {});
  }

  Future _processPickedFile(XFile? pickedFile) async {
    final path = pickedFile?.path;
    if (path == null) {
      return;
    }
    setState(() {
      _image = File(path);
      isFabVisible = true;
    });
    _path = path;

    final inputImage = InputImage.fromFilePath(path);
    getImgSize();
    setState(() {});
    widget.onImage(inputImage);
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[_cameraIndex];
    final imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation);
    if (imageRotation == null) return;

    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw);
    if (inputImageFormat == null) return;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    setState(() {
      isFabVisible = true;
    });
    widget.onImage(inputImage);
  }
}
