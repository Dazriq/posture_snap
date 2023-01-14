import '../vision_detector_views/pose_detector_view.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import 'dart:math';


class Joint {
  late PoseLandmark a;
  late PoseLandmark b;
  late PoseLandmark c;

  late double angle;

  Joint(PoseLandmark a, PoseLandmark b, PoseLandmark c) {
    this.a = a;
    this.b = b;
    this.c = c;
  }
}


double calculateAngle2d(PoseLandmark jointA, PoseLandmark jointB, PoseLandmark jointC, String view) {
  Point pointA = new Point(jointA.x, jointA.y);
  Point pointB = new Point(jointB.x, jointB.y);
  Point pointC = new Point(jointC.x, jointC.y);
  
  if (view == 'front') {
    double radians = atan2(pointC.y - pointB.y, pointC.x - pointB.x) - atan2(pointA.y - pointB.y, pointA.x - pointB.x);
    double angle = (radians * 180.0/pi).abs();    
  }
  else if (view == 'above') {
    
  }
  else if (view == 'side') {
    
  }
  else {
    return 0;
  }

  double radians = atan2(pointC.y - pointB.y, pointC.x - pointB.x) - atan2(pointA.y - pointB.y, pointA.x - pointB.x);
  double angle = (radians * 180.0/pi).abs();

  if (angle > 180.0) {
    angle =  360 - angle;
  }

  return angle; 
}

void getAngles(List<PoseLandmark> joints) {}
//TODO: list all the joints 
//TODO: calculate the angles between the joints

//print all joints
// void printJoints(List<PoseLandmark> joints) {
//   for (var i = 0; i < PoseLandmarkType.values.length; i++) {
//     PoseLandmark joint = joints[i];
//     var type = joint.type;
//     var x = joint.x;
//     var y = joint.y;
//     var z = joint.z;
//     var likelihood = joint.likelihood;
//     print('\ntype: $type, x: $x, y: $y, z: $z, likelehood: $likelihood \n');
//   }
// }