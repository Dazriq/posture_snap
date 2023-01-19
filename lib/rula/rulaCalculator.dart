import 'package:flutter/material.dart';

import 'joinAngleCalculator.dart';
import '../vision_detector_views/pose_detector_view.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import '../rula/result.dart';

String calculateRula(Result result, List<Pose> poses) {
  Joint? neckFrontUp;
  Joint? trunkFrontDown;
  Joint? kneeFront;
  Joint? upperArmFrontUp;
  Joint? lowerArmFront;
  Joint? wristFrontUp;

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

    lowerArmFront = Joint(
        pose.landmarks[PoseLandmarkType.leftShoulder]!,
        pose.landmarks[PoseLandmarkType.leftElbow]!,
        pose.landmarks[PoseLandmarkType.leftWrist]!,
        'front',
        'none'); //done
    //TODO: change the right wrist to left
    wristFrontUp = Joint(
        pose.landmarks[PoseLandmarkType.leftWrist]!,
        pose.landmarks[PoseLandmarkType.rightWrist]!,
        pose.landmarks[PoseLandmarkType.rightIndex]!,
        'front',
        'up');

    jointListRula.add(neckFrontUp); //correct
    jointListRula.add(trunkFrontDown); //correct
    jointListRula.add(kneeFront);
    jointListRula.add(upperArmFrontUp); //correct
    jointListRula.add(lowerArmFront); //correct
    jointListRula.add(wristFrontUp);

    //jointListRula.add(UpperArmFrontDown);

    //<PoseLandmark>[leftShoulder, rightShoulder, leftWrist, rightWrist];

  }

  checkRula(result, jointListRula);

  String returnValue = '';
  for (int i = 0; i < jointListRula.length; i++) {
    returnValue = returnValue + jointListRula[i].toString();
  }
  return returnValue;
}

int checkRula(Result result, List<Joint>? jointListRula) {
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
  print('Score A: $scoreA');

  //assume force/load score = 0
  int loadScore = 0;

  scoreA = scoreA + loadScore;

  //SCOREB ------------------------------------------------------------------------------------------------------------

  //check upper arm
  double upperArmAngle = jointListRula[3].angle;
  int upperArmScore = 0;
  if (upperArmAngle < 90) {
    upperArmScore += 4;
  } else if (upperArmAngle > 90 && upperArmAngle < 135) {
    upperArmScore += 3;
  } else if (upperArmAngle > 135 && upperArmAngle < 150) {
    upperArmScore += 2;
  } else if (upperArmAngle > 150 && upperArmAngle < 190) {
    upperArmScore += 1;
  } else if (upperArmAngle > 190) {
    upperArmScore += 2;
  }
  print(
      '-----------------------------------------------------------------------------------------------------------');
  print('upperArm Angle $upperArmAngle Score: $upperArmScore');

  //if shoulder raised
  //if upper arm is abducted
  //if arm is supported or person leaning

  //check lower arm
  double lowerArmAngle = jointListRula[4].angle;
  int lowerArmScore = 0;

  if (lowerArmAngle > 120)
    lowerArmScore += 2;
  else if (lowerArmAngle > 80 && lowerArmAngle < 120)
    lowerArmScore += 1;
  else if (lowerArmAngle < 80) lowerArmScore += 2;

  print(
      '-----------------------------------------------------------------------------------------------------------');
  print('lowerArm Angle $lowerArmAngle Score: $lowerArmScore');
  //DONE

  //check wrist
  double wristAngle = jointListRula[5].angle;
  int wristScore = 0;
  if (wristAngle > 75 && wristAngle < 105)
    wristScore += 1;
  else if (wristAngle < 75)
    wristScore += 2;
  else if (wristAngle > 105) wristScore += 2;
  //DONE
  print(
      '-----------------------------------------------------------------------------------------------------------');
  print('wrist Angle $wristAngle Score: $wristScore');

  int scoreB = getScoreB(upperArmScore, lowerArmScore, wristScore);
  print('Score B: $scoreB');

  //we assume the coupling score is 0
  scoreB = scoreB + 0;

  //calculate the scorec
  int scoreC = getScoreC(scoreA, scoreB);
  print('Score C: $scoreC');

  //we assume that the body parts are repeated in small range actions
  int rebaScore = scoreC + 1;
  print('Reba Score: $rebaScore');

  //RESET THE Reba
  result.setTrunkScore = trunkScore;
  result.setTrunkAngle = trunkAngle;
  result.setKneeScore = kneeScore;
  result.setKneeAngle = kneeAngle;
  result.setUpperArmScore = upperArmScore;
  result.setUpperArmAngle = upperArmAngle;
  result.setLowerArmScore = lowerArmScore;
  result.setLowerArmAngle = lowerArmAngle;
  result.setWristScore = wristScore;
  result.setWristAngle = wristAngle;


  return rebaScore;
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

int getScoreB(int upperArmScore, int lowerArmScore, int wristScore) {
  int scoreB = 0;
  switch (lowerArmScore) {
    case 1:
      switch (wristScore) {
        case 1:
          switch (upperArmScore) {
            case 1:
              scoreB += 1;
              break;
            case 2:
              scoreB += 1;
              break;
            case 3:
              scoreB += 3;
              break;
            case 4:
              scoreB += 4;
              break;
            case 5:
              scoreB += 6;
              break;
            case 6:
              scoreB += 7;
              break;
          }
          break;
        case 2:
          switch (upperArmScore) {
            case 1:
              scoreB += 2;
              break;
            case 2:
              scoreB += 2;
              break;
            case 3:
              scoreB += 4;
              break;
            case 4:
              scoreB += 5;
              break;
            case 5:
              scoreB += 7;
              break;
            case 6:
              scoreB += 8;
              break;
          }
          break;
        case 3:
          switch (upperArmScore) {
            case 1:
              scoreB += 2;
              break;
            case 2:
              scoreB += 3;
              break;
            case 3:
              scoreB += 5;
              break;
            case 4:
              scoreB += 5;
              break;
            case 5:
              scoreB += 8;
              break;
            case 6:
              scoreB += 8;
              break;
          }
          break;
      }
      break;
    case 2:
      switch (wristScore) {
        case 1:
          switch (upperArmScore) {
            case 1:
              scoreB += 1;
              break;
            case 2:
              scoreB += 2;
              break;
            case 3:
              scoreB += 4;
              break;
            case 4:
              scoreB += 5;
              break;
            case 5:
              scoreB += 7;
              break;
            case 6:
              scoreB += 8;
              break;
          }
          break;
        case 2:
          switch (upperArmScore) {
            case 1:
              scoreB += 2;
              break;
            case 2:
              scoreB += 3;
              break;
            case 3:
              scoreB += 5;
              break;
            case 4:
              scoreB += 6;
              break;
            case 5:
              scoreB += 8;
              break;
            case 6:
              scoreB += 9;
              break;
          }
          break;
        case 3:
          switch (upperArmScore) {
            case 1:
              scoreB += 3;
              break;
            case 2:
              scoreB += 4;
              break;
            case 3:
              scoreB += 5;
              break;
            case 4:
              scoreB += 7;
              break;
            case 5:
              scoreB += 8;
              break;
            case 6:
              scoreB += 9;
              break;
          }
          break;
      }
      break;
  }
  return scoreB;
}

int getScoreC(int scoreA, int scoreB) {
  int scoreC = 0;

  switch (scoreB) {
    case 1:
      switch (scoreA) {
        case 1:
          scoreC += 1;
          break;
        case 2:
          scoreC += 1;
          break;
        case 3:
          scoreC += 2;
          break;
        case 4:
          scoreC += 3;
          break;
        case 5:
          scoreC += 4;
          break;
        case 6:
          scoreC += 6;
          break;
        case 7:
          scoreC += 7;
          break;
        case 8:
          scoreC += 8;
          break;
        case 9:
          scoreC += 9;
          break;
        case 10:
          scoreC += 10;
          break;
        case 11:
          scoreC += 11;
          break;
        case 12:
          scoreC += 12;
          break;
      }
      break;
    case 2:
      switch (scoreA) {
        case 1:
          scoreC += 1;
          break;
        case 2:
          scoreC += 2;
          break;
        case 3:
          scoreC += 3;
          break;
        case 4:
          scoreC += 4;
          break;
        case 5:
          scoreC += 4;
          break;
        case 6:
          scoreC += 6;
          break;
        case 7:
          scoreC += 7;
          break;
        case 8:
          scoreC += 8;
          break;
        case 9:
          scoreC += 9;
          break;
        case 10:
          scoreC += 10;
          break;
        case 11:
          scoreC += 11;
          break;
        case 12:
          scoreC += 12;
          break;
      }
      break;
    case 3:
      switch (scoreA) {
        case 1:
          scoreC += 1;
          break;
        case 2:
          scoreC += 2;
          break;
        case 3:
          scoreC += 3;
          break;
        case 4:
          scoreC += 4;
          break;
        case 5:
          scoreC += 4;
          break;
        case 6:
          scoreC += 6;
          break;
        case 7:
          scoreC += 7;
          break;
        case 8:
          scoreC += 8;
          break;
        case 9:
          scoreC += 9;
          break;
        case 10:
          scoreC += 10;
          break;
        case 11:
          scoreC += 11;
          break;
        case 12:
          scoreC += 12;
          break;
      }
      break;
    case 4:
      switch (scoreA) {
        case 1:
          scoreC += 2;
          break;
        case 2:
          scoreC += 3;
          break;
        case 3:
          scoreC += 3;
          break;
        case 4:
          scoreC += 4;
          break;
        case 5:
          scoreC += 5;
          break;
        case 6:
          scoreC += 7;
          break;
        case 7:
          scoreC += 8;
          break;
        case 8:
          scoreC += 9;
          break;
        case 9:
          scoreC += 10;
          break;
        case 10:
          scoreC += 11;
          break;
        case 11:
          scoreC += 11;
          break;
        case 12:
          scoreC += 12;
          break;
      }
      break;
    case 5:
      switch (scoreA) {
        case 1:
          scoreC += 3;
          break;
        case 2:
          scoreC += 4;
          break;
        case 3:
          scoreC += 4;
          break;
        case 4:
          scoreC += 5;
          break;
        case 5:
          scoreC += 6;
          break;
        case 6:
          scoreC += 8;
          break;
        case 7:
          scoreC += 9;
          break;
        case 8:
          scoreC += 10;
          break;
        case 9:
          scoreC += 10;
          break;
        case 10:
          scoreC += 11;
          break;
        case 11:
          scoreC += 12;
          break;
        case 12:
          scoreC += 12;
          break;
      }
      break;
    case 6:
      switch (scoreA) {
        case 1:
          scoreC += 3;
          break;
        case 2:
          scoreC += 4;
          break;
        case 3:
          scoreC += 5;
          break;
        case 4:
          scoreC += 6;
          break;
        case 5:
          scoreC += 7;
          break;
        case 6:
          scoreC += 8;
          break;
        case 7:
          scoreC += 9;
          break;
        case 8:
          scoreC += 10;
          break;
        case 9:
          scoreC += 10;
          break;
        case 10:
          scoreC += 11;
          break;
        case 11:
          scoreC += 12;
          break;
        case 12:
          scoreC += 12;
          break;
      }
      break;
    case 7:
      switch (scoreA) {
        case 1:
          scoreC += 4;
          break;
        case 2:
          scoreC += 5;
          break;
        case 3:
          scoreC += 6;
          break;
        case 4:
          scoreC += 7;
          break;
        case 5:
          scoreC += 8;
          break;
        case 6:
          scoreC += 9;
          break;
        case 7:
          scoreC += 9;
          break;
        case 8:
          scoreC += 10;
          break;
        case 9:
          scoreC += 11;
          break;
        case 10:
          scoreC += 11;
          break;
        case 11:
          scoreC += 12;
          break;
        case 12:
          scoreC += 12;
          break;
      }
      break;
    case 8:
      switch (scoreA) {
        case 1:
          scoreC += 5;
          break;
        case 2:
          scoreC += 6;
          break;
        case 3:
          scoreC += 7;
          break;
        case 4:
          scoreC += 8;
          break;
        case 5:
          scoreC += 8;
          break;
        case 6:
          scoreC += 9;
          break;
        case 7:
          scoreC += 10;
          break;
        case 8:
          scoreC += 10;
          break;
        case 9:
          scoreC += 11;
          break;
        case 10:
          scoreC += 12;
          break;
        case 11:
          scoreC += 12;
          break;
        case 12:
          scoreC += 12;
          break;
      }
      break;
    case 9:
      switch (scoreA) {
        case 1:
          scoreC += 6;
          break;
        case 2:
          scoreC += 6;
          break;
        case 3:
          scoreC += 7;
          break;
        case 4:
          scoreC += 8;
          break;
        case 5:
          scoreC += 9;
          break;
        case 6:
          scoreC += 10;
          break;
        case 7:
          scoreC += 10;
          break;
        case 8:
          scoreC += 10;
          break;
        case 9:
          scoreC += 11;
          break;
        case 10:
          scoreC += 12;
          break;
        case 11:
          scoreC += 12;
          break;
        case 12:
          scoreC += 12;
          break;
      }
      break;
    case 10:
      switch (scoreA) {
        case 1:
          scoreC += 7;
          break;
        case 2:
          scoreC += 7;
          break;
        case 3:
          scoreC += 8;
          break;
        case 4:
          scoreC += 9;
          break;
        case 5:
          scoreC += 9;
          break;
        case 6:
          scoreC += 10;
          break;
        case 7:
          scoreC += 11;
          break;
        case 8:
          scoreC += 11;
          break;
        case 9:
          scoreC += 12;
          break;
        case 10:
          scoreC += 12;
          break;
        case 11:
          scoreC += 12;
          break;
        case 12:
          scoreC += 12;
          break;
      }
      break;
    case 11:
      switch (scoreA) {
        case 1:
          scoreC += 7;
          break;
        case 2:
          scoreC += 7;
          break;
        case 3:
          scoreC += 8;
          break;
        case 4:
          scoreC += 9;
          break;
        case 5:
          scoreC += 9;
          break;
        case 6:
          scoreC += 10;
          break;
        case 7:
          scoreC += 11;
          break;
        case 8:
          scoreC += 11;
          break;
        case 9:
          scoreC += 12;
          break;
        case 10:
          scoreC += 12;
          break;
        case 11:
          scoreC += 12;
          break;
        case 12:
          scoreC += 12;
          break;
      }
      break;
    case 12:
      switch (scoreA) {
        case 1:
          scoreC += 7;
          break;
        case 2:
          scoreC += 8;
          break;
        case 3:
          scoreC += 8;
          break;
        case 4:
          scoreC += 9;
          break;
        case 5:
          scoreC += 9;
          break;
        case 6:
          scoreC += 10;
          break;
        case 7:
          scoreC += 11;
          break;
        case 8:
          scoreC += 11;
          break;
        case 9:
          scoreC += 12;
          break;
        case 10:
          scoreC += 12;
          break;
        case 11:
          scoreC += 12;
          break;
        case 12:
          scoreC += 12;
          break;
      }
      break;
  }

  return scoreC;
}
