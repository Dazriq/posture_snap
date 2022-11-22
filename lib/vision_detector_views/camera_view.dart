import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ergo_snap/components/rounded_button.dart';

import 'package:google_fonts/google_fonts.dart';
import '../Screens/components/camera_carousel.dart';
import '../main.dart';

enum ScreenMode { liveFeed, gallery }

class CameraView extends StatefulWidget {
  CameraView(
      {Key? key,
      required this.title,
      required this.customPaint,
      this.text,
      required this.onImage,
      this.onScreenModeChanged,
      this.initialDirection = CameraLensDirection.back})
      : super(key: key);

  final String title;
  final CustomPaint? customPaint;
  final String? text;
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _body() {
    Widget body;
    body = _galleryBody();
    return body;
  }

  Widget _galleryBody() {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
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
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    )),
                SizedBox(height: 10),
                Text(
                  'POSTURE\nSNAP',
                  style: GoogleFonts.atma(
                    textStyle: TextStyle(
                      color: Color(0XFFFF3B9D),
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    )
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                _image != null
                    ? SizedBox(
                        height: 400,
                        width: 400,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Image.file(_image!),
                            if (widget.customPaint != null) widget.customPaint!,
                          ],
                        ),
                      )
                    : CameraCarousel(),
                SizedBox(height: 10),
                //  _image != null
                //      ? SizedBox(height: 0)
                //      : roundedButtonFull('TAKE A PICTURE'),
                // SizedBox(height: 20),
                //  _image != null
                //      ? SizedBox(height: 0)
                //      : roundedButtonFull('FROM GALLERY'),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 100,
                  color: Colors.red.withOpacity(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      squareIconButton('camera'), 
                      squareIconButton('gallery')
                    ],
                  ),
                ),
                if (_image != null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        '${_path == null ? '' : 'Working...'}\n\n${widget.text ?? ''}'),
                    //path of image = _path
                  ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
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

  Widget roundedIconButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 100,
      color: Colors.red.withOpacity(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
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
              )),
          InkWell(
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
              )),
        ],
      ),
    );
  }

  Widget roundedButtonFull(String title) {
    return InkWell(
      onTap: () => {
        if (title == 'TAKE A PICTURE')
          {_getImage(ImageSource.camera)}
        else
          {_getImage(ImageSource.gallery)}
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Color(0XFFFF3B9D), width: 2),
            color: Color(0XFFFF3B9D).withOpacity(0)),
        padding: EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
              color: Color(0XFFFF3B9D),
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
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
    });
    _path = path;
    final inputImage = InputImage.fromFilePath(path);
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

    widget.onImage(inputImage);
  }
}
