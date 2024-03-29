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
  late Point3d pointA;
  late Point3d pointB;
  late Point3d pointC;
  late String view;
  late String direction;
  late double angle;

  Joint(PoseLandmark a, PoseLandmark b, PoseLandmark c, String view,
      String direction) {
    this.a = a;
    this.b = b;
    this.c = c;
    this.view = view;
    this.direction = direction;
    this.pointA = new Point3d(this.a.x, this.a.y, this.a.z);
    this.pointB = new Point3d(this.b.x, this.b.y, this.b.z);
    this.pointC = new Point3d(this.c.x, this.c.y, this.c.z);
    this.angle = calculateAngle2d(
        this.pointA, this.pointB, this.pointC, this.view, this.direction);
  }

  @override
  String toString() {
    String returnValue = '';

    Point3d a = this.pointA;
    Point3d b = this.pointB;
    Point3d c = this.pointC;
    double angle = this.angle;

    returnValue =
        returnValue + 'x: ' + a.x.toString() + '\ny: ' + a.y.toString() + '\nz:' + c.z.toString() + '\n';
    returnValue =
        returnValue + 'x: ' + b.x.toString() + '\ny: ' + b.y.toString() + '\nz:' + c.z.toString() + '\n';
    returnValue =
        returnValue + 'x: ' + c.x.toString() + '\ny: ' + c.y.toString() + '\nz:' + c.z.toString() + '\n';
    returnValue = returnValue + '\n $angle \n\n';

    //returnValue = returnValue + '\a: $a \nb: $b \nc: $c \nangle: $angle \n';
    // TODO: implement toString
    return returnValue;
  }
}

double calculateAngle2d(Point3d pointA, Point3d pointB, Point3d pointC,
    String view, String direction) {
  // pointA.setX = 0;
  // pointA.setY = 4;
  // pointA.setZ = 0;
  // pointB.setX = 0;
  // pointB.setY = 0;
  // pointB.setZ = 0;
  // pointC.setX = 4;
  // pointC.setY = 8;
  // pointC.setZ = 0;

  if (direction != 'none') {
    Point3d newPoint = getDummyPoint(direction, view, pointB);
    pointA.setX = newPoint.x;
    pointA.setY = newPoint.y;
    pointA.setZ = newPoint.z;
  }

  double radians;
  if (view == 'front') {
    radians = atan2(pointC.y - pointB.y, pointC.x - pointB.x) -
        atan2(pointA.y - pointB.y, pointA.x - pointB.x);
  } else if (view == 'above') {
    radians = atan2(pointC.z - pointB.z, pointC.x - pointB.x) -
        atan2(pointA.z - pointB.z, pointA.x - pointB.x);
  } else {
    radians = atan2(pointC.z - pointB.z, pointC.x - pointB.x) -
        atan2(pointA.z - pointB.z, pointA.x - pointB.x);
  }
  double angle;

  if (direction == 'none') {
    angle = (radians * 180.0 / pi).abs();
    if (angle > 180.0) {
      angle = 360 - angle;
    }
    return angle;
  }

  angle = (radians * 180.0 / pi);
  angle = 180 - angle;

  return angle;
  // } else if (view == 'side') {
  //   double radians = atan2(pointC.y - pointB.y, pointC.z - pointB.z) -
  //       atan2(pointA.y - pointB.y, pointA.z - pointB.z);
  //   double angle = (radians * 180.0 / pi).abs();
  //   if (angle > 180.0) {
  //     angle = 360 - angle;
  //   }
  //   return angle;
  // }
}

Point3d getDummyPoint(String direction, String view, Point3d oldPoint) {
  Point3d newPoint = new Point3d(0, 0, 0);
  double x, y, z;

  if (view == 'front') {
    if (direction == 'up') {
      newPoint.setX = oldPoint.x;
      newPoint.setY = oldPoint.y + 10;
    } else if (direction == 'down') {
      newPoint.setX = oldPoint.x;
      newPoint.setY = oldPoint.y - 10;
    } else if (direction == 'left') {
      newPoint.setX = oldPoint.x - 10;
      newPoint.setY = oldPoint.y;
    } else {
      newPoint.setX = oldPoint.x + 10;
      newPoint.setY = oldPoint.y;
    }
  }

  if (view == 'above') {
    if (direction == 'up') {
      newPoint.setZ = oldPoint.z;
      newPoint.setX = oldPoint.x + 10;
    } else if (direction == 'down') {
      newPoint.setZ = oldPoint.z;
      newPoint.setX = oldPoint.x - 10;
    } else if (direction == 'left') {
      newPoint.setZ = oldPoint.z - 10;
      newPoint.setX = oldPoint.x;
    } else {
      newPoint.setZ = oldPoint.z + 10;
      newPoint.setX = oldPoint.x;
    }
  }

  return newPoint;
}
