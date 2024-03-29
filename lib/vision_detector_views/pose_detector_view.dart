import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'camera_view.dart';
import 'painters/pose_painter.dart';
import 'package:image_picker/image_picker.dart';
import '../rula/rulaCalculator.dart';
import '../rula/result.dart';

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
  Result? _result;

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
      result: _result,
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
      File image = new File(
          inputImage.filePath!); // Or any other way to get a File instance.
      var decodedImage = await decodeImageFromList(image.readAsBytesSync());
      Size imgSize =
          Size(decodedImage.width.toDouble(), decodedImage.height.toDouble());
      //_text = 'file path: ${decodedImage.width} X ${decodedImage.height} ';

      final painter =
          PosePainter(poses, imgSize, InputImageRotation.rotation0deg);
      _customPaint = CustomPaint(painter: painter);

      if (checkNull(poses) == true) {
        Result result = new Result(
            neckAngle: 0,
            neckScore: 0,
            rebaScore: 0,
            trunkScore: 0,
            trunkAngle: 0,
            kneeScore: 0,
            kneeAngle: 0,
            upperArmScore: 0,
            upperArmAngle: 0,
            lowerArmScore: 0,
            lowerArmAngle: 0,
            wristScore: 0,
            wristAngle: 0);
        _text =
            'Poses found \n${calculateRula(result, poses)} \n ${inputImage}';
        _result = result;
        print(result);
      }
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}

bool checkNull(List<Pose> poses) {
  bool returnValue = true;
  double totalLikelihood = 0;

  for (final pose in poses) {
    double? leftShoulder =
        pose.landmarks[PoseLandmarkType.leftShoulder]!.likelihood;
    double? leftEar = pose.landmarks[PoseLandmarkType.leftEar]!.likelihood;
    double? leftHip = pose.landmarks[PoseLandmarkType.leftHip]!.likelihood;
    double? leftAnkle = pose.landmarks[PoseLandmarkType.leftAnkle]!.likelihood;
    double? leftKnee = pose.landmarks[PoseLandmarkType.leftKnee]!.likelihood;
    double? leftElbow = pose.landmarks[PoseLandmarkType.leftElbow]!.likelihood;
    double? leftWrist = pose.landmarks[PoseLandmarkType.leftWrist]!.likelihood;
    double? leftIndex = pose.landmarks[PoseLandmarkType.leftIndex]!.likelihood;

    print(
        '$leftShoulder, $leftEar, $leftHip, $leftAnkle, $leftKnee, $leftElbow, $leftWrist, $leftIndex');

    if (leftShoulder < 0.7) {
      returnValue = false;
    }
    if (leftEar < 0.7) {
      returnValue = false;
    }
    if (leftHip < 0.7) {
      returnValue = false;
    }
    if (leftAnkle < 0.7) {
      returnValue = false;
    }
    if (leftKnee < 0.7) {
      returnValue = false;
    }
    if (leftElbow < 0.7) {
      returnValue = false;
    }
    if (leftWrist < 0.7) {
      returnValue = false;
    }
    if (leftIndex < 0.7) {
      returnValue = false;
    }

    // totalLikelihood = leftShoulder +
    //     leftEar +
    //     leftHip +
    //     leftAnkle +
    //     leftKnee +
    //     leftElbow +
    //     leftWrist +
    //     leftIndex;

    // totalLikelihood = totalLikelihood / 8;
    // print(totalLikelihood);
    // if (totalLikelihood < 0.7) {
    //   returnValue = false;
    // }
  }
  print(totalLikelihood);
  print(returnValue);
  return returnValue;
}
