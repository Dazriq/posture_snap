class Result {
  int? rebaScore;
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

  Result({required this.rebaScore, required this.trunkScore, required this.trunkAngle, required this.kneeScore, required this.kneeAngle, required this.upperArmScore, required this.upperArmAngle, required this.lowerArmScore, required this.lowerArmAngle, required this.wristScore, required this.wristAngle});

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

  // getters
  int getTrunkScore() {
    return this.trunkScore!;
  }

  double getTrunkAngle() {
    return this.trunkAngle!;
  }

  int getKneeScore() {
    return this.kneeScore!;
  }

  double getKneeAngle() {
    return this.kneeAngle!;
  }

  int getUpperArmScore() {
    return this.upperArmScore!;
  }

  double getUpperArmAngle() {
    return this.upperArmAngle!;
  }

  int getLowerArmScore() {
    return this.lowerArmScore!;
  }

  double getLowerArmAngle() {
    return this.lowerArmAngle!;
  }

  int getWristScore() {
    return this.wristScore!;
  }

  double getWristAngle() {
    return this.wristAngle!;
  }

  // setters
  void setTrunkScore(int score) {
    this.trunkScore = score;
  }

  void setTrunkAngle(double angle) {
    this.trunkAngle = angle;
  }

  void setKneeScore(int score) {
    this.kneeScore = score;
  }

  void setKneeAngle(double angle) {
    this.kneeAngle = angle;
  }

  void setUpperArmScore(int score) {
    this.upperArmScore = score;
  }

  void setUpperArmAngle(double angle) {
    this.upperArmAngle = angle;
  }

  void setLowerArmScore(int score) {
    this.lowerArmScore = score;
  }

  void setLowerArmAngle(double angle) {
    this.lowerArmAngle = angle;
  }

  void setWristScore(int score) {
    this.wristScore = score;
  }

  void setWristAngle(double angle) {
    this.wristAngle;
  }
}
