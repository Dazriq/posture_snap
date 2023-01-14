import 'joinAngleCalculator.dart';
import '../vision_detector_views/pose_detector_view.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

String calculateRula(List<Pose> poses) {

  Joint? UpperArmSide;
  List<Joint>? jointListRula = List<Joint>.empty(growable: true);
  //shoulder, elbow, wrist, hiplower, hipupper, neck
  for (final pose in poses) {
    

    UpperArmSide = Joint(
        pose.landmarks[PoseLandmarkType.rightShoulder]!,
        pose.landmarks[PoseLandmarkType.rightShoulder]!,
        pose.landmarks[PoseLandmarkType.rightElbow]!,
        'side',);

    jointListRula.insert(0, UpperArmSide);

    //<PoseLandmark>[leftShoulder, rightShoulder, leftWrist, rightWrist];
      
  }
  
  String returnValue = '';
  for (int i = 0; i < jointListRula.length; i++) {
    returnValue = returnValue + jointListRula[i].toString();
  }
  return returnValue;
}
