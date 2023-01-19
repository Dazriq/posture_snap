class Result {
  int? rebaScore;
  int? neckScore;
  int? neckAngle;
  int? trunkScore;
  double? trunkAngle;
  int? kneeScore;
  double? kneeAngle;
  int? upperArmScore;
  double? upperArmAngle;
  int? lowerArmScore;
  double? lowerArmAngle;
  int? wristScore;
  double? wristAngle;

  String toString() {
    String returnValue = "";
    returnValue += 'Neck Angle $neckAngle Score: $neckScore\n';
    returnValue += 'trunk Angle $trunkAngle Score: $trunkScore\n';
    returnValue += 'knee Angle $kneeAngle Score: $kneeScore\n';
    returnValue += 'upperArm Angle $upperArmAngle Score: $upperArmScore\n';
    returnValue += 'lowerArm Angle $lowerArmAngle Score: $lowerArmScore\n';
    returnValue += 'wrist Angle $wristAngle Score: $wristScore\n';
    returnValue += 'wrist Angle $wristAngle Score: $wristScore';

    return returnValue;
  }

  Result(
      {this.neckScore,
      required this.neckAngle,
      this.rebaScore,
      required this.trunkScore,
      required this.trunkAngle,
      required this.kneeScore,
      required this.kneeAngle,
      required this.upperArmScore,
      required this.upperArmAngle,
      required this.lowerArmScore,
      required this.lowerArmAngle,
      required this.wristScore,
      required this.wristAngle});

  // constructor
  Result.fromJson(Map<String, dynamic> json) {
    trunkScore = json['trunkScore'];
    trunkAngle = json['trunkAngle'];
    kneeScore = json['kneeScore'];
    kneeAngle = json['kneeAngle'];
    upperArmScore = json['upperArmScore'];
    upperArmAngle = json['upperArmAngle'];
    lowerArmScore = json['lowerArmScore'];
    lowerArmAngle = json['lowerArmAngle'];
    wristScore = json['wristScore'];
    wristAngle = json['wristAngle'];
  }
  // setters
  set setTrunkScore(int trunkScore) {
    this.trunkScore = trunkScore;
  }

  set setTrunkAngle(double trunkAngle) {
    this.trunkAngle = trunkAngle;
  }

  set setKneeScore(int kneeScore) {
    this.kneeScore = kneeScore;
  }

  set setKneeAngle(double kneeAngle) {
    this.kneeAngle = kneeAngle;
  }

  set setUpperArmScore(int upperArmScore) {
    this.upperArmScore = upperArmScore;
  }

  set setUpperArmAngle(double upperArmAngle) {
    this.upperArmAngle = upperArmAngle;
  }

  set setLowerArmScore(int lowerArmScore) {
    this.lowerArmScore = lowerArmScore;
  }

  set setLowerArmAngle(double lowerArmAngle) {
    this.lowerArmAngle = lowerArmAngle;
  }

  set setWristScore(int wristScore) {
    this.wristScore = wristScore;
  }

  set setWristAngle(double wristAngle) {
    this.wristAngle = wristAngle;
  }
}
