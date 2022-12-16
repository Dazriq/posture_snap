import 'joinAngleCalculator.dart';
import '../vision_detector_views/pose_detector_view.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

String calculateRula(List<Pose> poses) {
  Joint? shoulderSide;
  Joint? neckSide;
  Joint? armSide;
  Joint? armAbove;
  Joint? wristSide;
  Joint? wristAbove;
  Joint? trunkSide;

  List<Joint>? jointListRula = List<Joint>.empty(growable: true);
  //shoulder, elbow, wrist, hiplower, hipupper, neck
  for (final pose in poses) {
    neckSide = Joint(
        pose.landmarks[PoseLandmarkType.rightShoulder]!,
        pose.landmarks[PoseLandmarkType.rightElbow]!,
        pose.landmarks[PoseLandmarkType.leftIndex]!,
        'front');
    shoulderSide = Joint(
        pose.landmarks[PoseLandmarkType.rightShoulder]!,
        pose.landmarks[PoseLandmarkType.rightElbow]!,
        pose.landmarks[PoseLandmarkType.leftIndex]!,
        'front');
    armSide = Joint(
        pose.landmarks[PoseLandmarkType.rightShoulder]!,
        pose.landmarks[PoseLandmarkType.rightElbow]!,
        pose.landmarks[PoseLandmarkType.leftIndex]!,
        'front');
    armAbove = Joint(
        pose.landmarks[PoseLandmarkType.rightShoulder]!,
        pose.landmarks[PoseLandmarkType.rightElbow]!,
        pose.landmarks[PoseLandmarkType.leftIndex]!,
        'front');
    wristSide = Joint(
        pose.landmarks[PoseLandmarkType.rightShoulder]!,
        pose.landmarks[PoseLandmarkType.rightElbow]!,
        pose.landmarks[PoseLandmarkType.leftIndex]!,
        'front');
    wristAbove = Joint(
        pose.landmarks[PoseLandmarkType.rightShoulder]!,
        pose.landmarks[PoseLandmarkType.rightElbow]!,
        pose.landmarks[PoseLandmarkType.leftIndex]!,
        'front');
    trunkSide = Joint(
        pose.landmarks[PoseLandmarkType.rightShoulder]!,
        pose.landmarks[PoseLandmarkType.rightElbow]!,
        pose.landmarks[PoseLandmarkType.leftIndex]!, //done
        'front');

    jointListRula.insert(0, neckSide);
    jointListRula.insert(1, shoulderSide);
    jointListRula.insert(2, armSide);
    jointListRula.insert(3, armAbove);
    jointListRula.insert(4, wristSide);
    jointListRula.insert(5, wristAbove);
    jointListRula.insert(6, trunkSide);
    
  }

  String returnValue = '';
  for (int i = 0; i < jointListRula.length; i++) {
    returnValue = returnValue + jointListRula[i].toString();
  }
  return returnValue;
}
