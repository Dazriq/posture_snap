import 'joinAngleCalculator.dart';
import '../vision_detector_views/pose_detector_view.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

String calculateRula(List<Pose> poses) {

  Joint? UpperArmSide;
  Joint? UpperArmFront;
  Joint? UpperArmAbove;

  Joint? RightAnkle;
  Joint? LeftAnkle;


  List<Joint>? jointListRula = List<Joint>.empty(growable: true);
  //shoulder, elbow, wrist, hiplower, hipupper, neck
  for (final pose in poses) {
    

    UpperArmSide = Joint(
        pose.landmarks[PoseLandmarkType.rightShoulder]!,
        pose.landmarks[PoseLandmarkType.rightElbow]!,
        pose.landmarks[PoseLandmarkType.rightWrist]!,
        'side',);
    UpperArmFront = Joint(
        pose.landmarks[PoseLandmarkType.rightShoulder]!,
        pose.landmarks[PoseLandmarkType.rightElbow]!,
        pose.landmarks[PoseLandmarkType.rightWrist]!,
        'front',);
    UpperArmAbove = Joint(
        pose.landmarks[PoseLandmarkType.rightShoulder]!,
        pose.landmarks[PoseLandmarkType.rightElbow]!,
        pose.landmarks[PoseLandmarkType.rightWrist]!,
        'above',);

    RightAnkle = Joint(
        pose.landmarks[PoseLandmarkType.rightHip]!,
        pose.landmarks[PoseLandmarkType.rightKnee]!,
        pose.landmarks[PoseLandmarkType.rightAnkle]!,
        'front',);
    LeftAnkle = Joint(
        pose.landmarks[PoseLandmarkType.leftHip]!,
        pose.landmarks[PoseLandmarkType.leftKnee]!,
        pose.landmarks[PoseLandmarkType.leftAnkle]!,
        'front',);
    
    

    jointListRula.insert(0, UpperArmSide);
    jointListRula.insert(1, UpperArmFront);
    jointListRula.insert(2, UpperArmAbove);
    jointListRula.insert(3, RightAnkle);
    jointListRula.insert(3, LeftAnkle);
    
    //<PoseLandmark>[leftShoulder, rightShoulder, leftWrist, rightWrist];
      
  }

  String returnValue = '';
  for (int i = 0; i < jointListRula.length; i++) {
    returnValue = returnValue + jointListRula[i].toString();
  }
  return returnValue;
}
