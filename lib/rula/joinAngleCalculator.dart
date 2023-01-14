import '../vision_detector_views/pose_detector_view.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import 'dart:math';

class Point3d {
  late double x;
  late double y;
  late double z;

  Point3d(double x, double y, double z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }

 
  // Creating the setter method
  // to set the input in Field/Property
  set setX(double x) {
    this.x = x;
  }
  set setY(double y) {
    this.y = y;
  }
  set setZ(double z) {
    this.z = z;
  }
}

class Joint {
  late PoseLandmark a;
  late PoseLandmark b;
  late PoseLandmark c;
  late String view;
  late double angle;

  Joint(PoseLandmark a, PoseLandmark b, PoseLandmark c, String view) {
    this.a = a;
    this.b = b;
    this.c = c;
    this.view = view;
    this.angle = calculateAngle2d(this.a, this.b, this.c, this.view);
  }

  @override
  String toString() {
    String returnValue = '';

    PoseLandmarkType a = this.a.type;
    PoseLandmarkType b = this.b.type;
    PoseLandmarkType c = this.c.type;

    returnValue = returnValue + '\a: $a \nb: $b \nc: $c \nangle: $angle \n';
    // TODO: implement toString
    return returnValue;
  }
}

double calculateAngle2d(PoseLandmark jointA, PoseLandmark jointB,
    PoseLandmark jointC, String view) {
  Point3d pointA = new Point3d(jointA.x, jointA.y, jointA.z);
  Point3d pointB = new Point3d(jointB.x, jointB.y, jointB.z);
  Point3d pointC = new Point3d(jointC.x, jointC.y, jointC.z);

  if (view == 'front') {
    double radians = atan2(pointC.y - pointB.y, pointC.x - pointB.x) -
        atan2(pointA.y - pointB.y, pointA.x - pointB.x);
    double angle = (radians * 180.0 / pi).abs();
    if (angle > 180.0) {
      angle = 360 - angle;
    }
    return angle;
  } else if (view == 'above') {
    double radians = atan2(pointC.z - pointB.z, pointC.x - pointB.x) -
        atan2(pointA.z - pointB.z, pointA.x - pointB.x);
    double angle = (radians * 180.0 / pi).abs();
    if (angle > 180.0) {
      angle = 360 - angle;
    }
    return angle;
  } else if (view == 'side') {
    double radians = atan2(pointC.y - pointB.y, pointC.z - pointB.z) -
        atan2(pointA.y - pointB.y, pointA.z - pointB.z);
    double angle = (radians * 180.0 / pi).abs();
    if (angle > 180.0) {
      angle = 360 - angle;
    }
    return angle;
  }

  return 0;
}

