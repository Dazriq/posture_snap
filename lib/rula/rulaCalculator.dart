import 'joinAngleCalculator.dart';
import '../vision_detector_views/pose_detector_view.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

String calculateRula(List<Pose> poses) {


  Joint? UpperArmFront;

  Joint? RightAnkle;
  Joint? LeftAnkle;


  List<Joint>? jointListRula = List<Joint>.empty(growable: true);
  //shoulder, elbow, wrist, hiplower, hipupper, neck
  for (final pose in poses) {
    
    //TODO: DIRECTION : DONE, NOW TARGET VALUE OF ANGLE THAT TO BE DUMMY
    UpperArmFront = Joint(
        pose.landmarks[PoseLandmarkType.rightShoulder]!,
        pose.landmarks[PoseLandmarkType.rightShoulder]!,
        pose.landmarks[PoseLandmarkType.rightElbow]!,
        'front', 'up');

    
    jointListRula.add(UpperArmFront);
    
    //<PoseLandmark>[leftShoulder, rightShoulder, leftWrist, rightWrist];
      
  }

  String returnValue = '';
  for (int i = 0; i < jointListRula.length; i++) {
    returnValue = returnValue + jointListRula[i].toString();
  }
  return returnValue;
}
