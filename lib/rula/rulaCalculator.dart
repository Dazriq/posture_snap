import 'joinAngleCalculator.dart';
import '../vision_detector_views/pose_detector_view.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

double calculateRula(List<Pose> poses) {
  for (final pose in poses) {}

  List<PoseLandmark>? jointListRula = List<PoseLandmark>.empty(growable: true);
  //shoulder, elbow, wrist, hiplower, hipupper, neck
  for (final pose in poses) {
    
    PoseLandmark leftEar = pose.landmarks[PoseLandmarkType.leftEar]!;
    PoseLandmark rightEar = pose.landmarks[PoseLandmarkType.rightEar]!;
    PoseLandmark leftShoulder = pose.landmarks[PoseLandmarkType.leftShoulder]!;
    PoseLandmark rightShoulder = pose.landmarks[PoseLandmarkType.rightShoulder]!;
    PoseLandmark leftElbow = pose.landmarks[PoseLandmarkType.leftElbow]!;
    PoseLandmark rightElbow = pose.landmarks[PoseLandmarkType.rightElbow]!;
    PoseLandmark leftWrist = pose.landmarks[PoseLandmarkType.leftWrist]!;
    PoseLandmark rightWrist = pose.landmarks[PoseLandmarkType.rightWrist]!;
    PoseLandmark leftIndex = pose.landmarks[PoseLandmarkType.leftIndex]!;
    PoseLandmark rightIndex = pose.landmarks[PoseLandmarkType.leftIndex]!;



    jointListRula.insert(0, leftShoulder);
    jointListRula.insert(1, rightShoulder);
    jointListRula.insert(2, leftWrist);
    jointListRula.insert(3, rightWrist);

    //<PoseLandmark>[leftShoulder, rightShoulder, leftWrist, rightWrist];
      
  }
  for (int i = 0; i < jointListRula.length; i++) {
    var type = jointListRula[i].type;
    var x = jointListRula[i].x;
    var y = jointListRula[i].y;
    var z = jointListRula[i].z;
    print('\ntype: $type, x: $x, y: $y, z: $z \n');

  }


  return 0;
}
