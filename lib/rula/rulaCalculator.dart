import 'package:flutter/material.dart';

import 'joinAngleCalculator.dart';
import '../vision_detector_views/pose_detector_view.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

String calculateRula(List<Pose> poses) {
  Joint? neckFrontUp;
  Joint? upperArmFrontUp;
  Joint? kneeFront;
  Joint? trunkFront;

  Joint? upperArmFront;
  Joint? trunkFrontDown;
  Joint? upperArmAboveDown;

  List<Joint>? jointListRula = List<Joint>.empty(growable: true);
  //shoulder, elbow, wrist, hiplower, hipupper, neck
  for (final pose in poses) {
    //TODO: DIRECTION : DONE, NOW TARGET VALUE OF ANGLE THAT TO BE DUMMY
    neckFrontUp = Joint(
        pose.landmarks[PoseLandmarkType.leftShoulder]!,
        pose.landmarks[PoseLandmarkType.leftEar]!,
        pose.landmarks[PoseLandmarkType.leftShoulder]!,
        'front',
        'up'); //done
    trunkFrontDown = Joint(
        pose.landmarks[PoseLandmarkType.leftHip]!,
        pose.landmarks[PoseLandmarkType.leftHip]!,
        pose.landmarks[PoseLandmarkType.leftShoulder]!,
        'front',
        'down'); //done
    kneeFront = Joint(
        pose.landmarks[PoseLandmarkType.leftAnkle]!,
        pose.landmarks[PoseLandmarkType.leftKnee]!,
        pose.landmarks[PoseLandmarkType.leftHip]!,
        'front',
        'none');

    upperArmFrontUp = Joint(
        pose.landmarks[PoseLandmarkType.leftShoulder]!,
        pose.landmarks[PoseLandmarkType.leftShoulder]!,
        pose.landmarks[PoseLandmarkType.leftElbow]!,
        'front',
        'up'); //done
    upperArmFront = Joint(
        pose.landmarks[PoseLandmarkType.leftShoulder]!,
        pose.landmarks[PoseLandmarkType.leftElbow]!,
        pose.landmarks[PoseLandmarkType.leftWrist]!,
        'front',
        'up'); //done
    upperArmAboveDown = Joint(
        pose.landmarks[PoseLandmarkType.leftShoulder]!,
        pose.landmarks[PoseLandmarkType.leftElbow]!,
        pose.landmarks[PoseLandmarkType.leftShoulder]!,
        'above',
        'up');

    jointListRula.add(neckFrontUp); //correct
    jointListRula.add(trunkFrontDown); //correct
    jointListRula.add(kneeFront);
    jointListRula.add(upperArmFrontUp); //correct

    jointListRula.add(upperArmFront); //correct
    jointListRula.add(upperArmAboveDown); //correct
    //jointListRula.add(UpperArmFrontDown);

    //<PoseLandmark>[leftShoulder, rightShoulder, leftWrist, rightWrist];

  }

  checkRula(jointListRula);

  String returnValue = '';
  for (int i = 0; i < jointListRula.length; i++) {
    returnValue = returnValue + jointListRula[i].toString();
  }
  return returnValue;
}

int checkRula(List<Joint>? jointListRula) {
  int neckScore = 0;
  int trunkScore = 0;
  int kneeScore = 0;

  int postureScoreA = 0;

  //check neck
  double neckAngle = jointListRula![0].angle;
  if (neckAngle > 200)
    neckScore = neckScore + 2;
  else if (neckAngle < 200 && neckAngle > 180)
    neckScore = neckScore + 1;
  else if (neckAngle < 200) neckScore = neckScore + 2;
  //TODO: check whether the neck is twisted or not
  //assume neck is twisted but not side bending
  neckScore = neckScore + 1;
  print(
      '-----------------------------------------------------------------------------------------------------------');
  print('Neck Angle $neckAngle Score: $neckScore');


  //check trunk
  double trunkAngle = jointListRula[1].angle;
  print(
      '-----------------------------------------------------------------------------------------------------------');
  if (trunkAngle > 180 && trunkAngle < 200) trunkScore = trunkScore + 2;
  if (trunkAngle < 180 && trunkAngle > 160)
    trunkScore = trunkScore + 2;
  else if (trunkScore == 180)
    trunkScore = trunkScore + 1;
  else if (trunkScore > 200 && trunkScore < 240)
    trunkScore = trunkScore + 3;
  else if (trunkScore > 200)
    trunkScore = trunkScore + 3;
  else if (trunkScore < 120) trunkScore = trunkScore + 4;
  //assume trunk is side bending but not twisted
  trunkScore = trunkScore + 1;
  print('trunk Angle $trunkAngle Score: $trunkScore');

  //TODO: check whether the trunk is twisted or not

  //check legs

  //we assume all legs are down
  kneeScore += 1;

  double kneeAngle = jointListRula[2].angle;
  if (kneeScore > 120 && kneeScore < 180)
    kneeScore = kneeScore + 2;
  else if (kneeScore > 90 && kneeScore < 120) kneeScore = kneeScore + 1;
  print(
      '-----------------------------------------------------------------------------------------------------------');
  print('knee Angle $kneeAngle Score: $kneeScore');

  int scoreA = getScoreA(neckScore, trunkScore, kneeScore);
  print(scoreA);

  //assume force/load score = 0 
  int loadScore = 0;

  scoreA = scoreA + loadScore;

  //scoreB ------------------------------------------------------------------------------------------------------------
  double upperArmAngle = jointListRula[3].angle;
  int upperArmScore = 0;
  if (upperArmAngle < 90) {
    upperArmScore += 4;
  }
  else if (upperArmAngle > 90 && upperArmAngle < 135) {
    upperArmScore += 3;
  }
  else if (upperArmAngle > 135 && upperArmAngle < 150) {
    upperArmScore += 2;
  }
  else if (upperArmAngle > 150 && upperArmAngle < 190) {
    upperArmScore += 1;
  }
  else if (upperArmAngle > 170) {
    upperArmScore += 2;
  }
  print(
      '-----------------------------------------------------------------------------------------------------------');
  print('upperArm Angle $upperArmAngle Score: $upperArmScore');



  return 0;
}

int getScoreA(int neckScore, int trunkScore, int kneeScore) {
  int scoreA = 0;
  switch (neckScore) {
    case 1:
      switch (kneeScore) {
        case 1:
          switch (trunkScore) {
            case 1:
              scoreA += 1;
              break;
            case 2:
              scoreA += 2;
              break;
            case 3:
              scoreA += 2;
              break;
            case 4:
              scoreA += 3;
              break;
            case 5:
              scoreA += 4;
              break;
          }
          break;
        case 2:
          switch (trunkScore) {
            case 1:
              scoreA += 2;
              break;
            case 2:
              scoreA += 3;
              break;
            case 3:
              scoreA += 4;
              break;
            case 4:
              scoreA += 5;
              break;
            case 5:
              scoreA += 6;
              break;
          }
          break;
        case 3:
          switch (trunkScore) {
            case 1:
              scoreA += 3;
              break;
            case 2:
              scoreA += 4;
              break;
            case 3:
              scoreA += 5;
              break;
            case 4:
              scoreA += 6;
              break;
            case 5:
              scoreA += 7;
              break;
          }
          break;
        case 4:
          switch (trunkScore) {
            case 1:
              scoreA += 4;
              break;
            case 2:
              scoreA += 5;
              break;
            case 3:
              scoreA += 6;
              break;
            case 4:
              scoreA += 7;
              break;
            case 5:
              scoreA += 8;
              break;
          }
          break;
      }
      break;
    case 2:
      switch (kneeScore) {
        case 1:
          switch (trunkScore) {
            case 1:
              scoreA += 1;
              break;
            case 2:
              scoreA += 3;
              break;
            case 3:
              scoreA += 4;
              break;
            case 4:
              scoreA += 5;
              break;
            case 5:
              scoreA += 6;
              break;
          }
          break;
        case 2:
          switch (trunkScore) {
            case 1:
              scoreA += 2;
              break;
            case 2:
              scoreA += 4;
              break;
            case 3:
              scoreA += 5;
              break;
            case 4:
              scoreA += 6;
              break;
            case 5:
              scoreA += 7;
              break;
          }
          break;
        case 3:
          switch (trunkScore) {
            case 1:
              scoreA += 3;
              break;
            case 2:
              scoreA += 5;
              break;
            case 3:
              scoreA += 6;
              break;
            case 4:
              scoreA += 7;
              break;
            case 5:
              scoreA += 8;
              break;
          }
          break;
        case 4:
          switch (trunkScore) {
            case 1:
              scoreA += 4;
              break;
            case 2:
              scoreA += 6;
              break;
            case 3:
              scoreA += 7;
              break;
            case 4:
              scoreA += 8;
              break;
            case 5:
              scoreA += 9;
              break;
          }
          break;
      }
      break;
    case 3:
      switch (kneeScore) {
        case 1:
          switch (trunkScore) {
            case 1:
              scoreA += 3;
              break;
            case 2:
              scoreA += 4;
              break;
            case 3:
              scoreA += 5;
              break;
            case 4:
              scoreA += 6;
              break;
            case 5:
              scoreA += 7;
              break;
          }
          break;
        case 2:
          switch (trunkScore) {
            case 1:
              scoreA += 3;
              break;
            case 2:
              scoreA += 5;
              break;
            case 3:
              scoreA += 6;
              break;
            case 4:
              scoreA += 7;
              break;
            case 5:
              scoreA += 8;
              break;
          }
          break;
        case 3:
          switch (trunkScore) {
            case 1:
              scoreA += 5;
              break;
            case 2:
              scoreA += 6;
              break;
            case 3:
              scoreA += 7;
              break;
            case 4:
              scoreA += 8;
              break;
            case 5:
              scoreA += 9;
              break;
          }
          break;
        case 4:
          switch (trunkScore) {
            case 1:
              scoreA += 6;
              break;
            case 2:
              scoreA += 7;
              break;
            case 3:
              scoreA += 8;
              break;
            case 4:
              scoreA += 9;
              break;
            case 5:
              scoreA += 9;
              break;
          }
          break;
      }
      break;
  }

  return scoreA;
}
