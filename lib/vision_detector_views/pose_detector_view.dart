import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'camera_view.dart';
import 'painters/pose_painter.dart';
import 'package:image_picker/image_picker.dart';
import '../rula/rulaCalculator.dart';


class PoseDetectorView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PoseDetectorViewState();
}

class _PoseDetectorViewState extends State<PoseDetectorView> {
  final PoseDetector _poseDetector =
      PoseDetector(options: PoseDetectorOptions());
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;

  @override
  void dispose() async {
    _canProcess = false;
    _poseDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      title: 'Pose Detector',
      customPaint: _customPaint,
      text: _text,
      onImage: (inputImage) {
        processImage(inputImage);
      },
    );
  }

  Future<Size> _calculateImageDimension(String imgPath) {
  Completer<Size> completer = Completer();
  Image image = Image.file(File(imgPath));
  image.image.resolve(ImageConfiguration()).addListener(
    ImageStreamListener(
      (ImageInfo image, bool synchronousCall) {
        var myImage = image.image;
        Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
        completer.complete(size);
      },
    ),
  );
  return completer.future;
  }


  Future<void> processImage(InputImage inputImage) async {

    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final poses = await _poseDetector.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = PosePainter(poses, inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      _customPaint = CustomPaint(painter: painter);
    } else {
      //File image = new File(inputImage.filePath);
      //File image2 = new File(fileBits, fileName)
      File image = new File(inputImage.filePath!); // Or any other way to get a File instance.
      var decodedImage = await decodeImageFromList(image.readAsBytesSync());
      Size imgSize = Size(decodedImage.width.toDouble(), decodedImage.height.toDouble());
      //_text = 'file path: ${decodedImage.width} X ${decodedImage.height} ';

      final painter = PosePainter(poses, imgSize,
      InputImageRotation.rotation0deg);
      _customPaint = CustomPaint(painter: painter);
      _text = 'Poses found \n${calculateRula(poses)} \n ${inputImage}';
      // TODO: set _customPaint to draw landmarks on top of image
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}

