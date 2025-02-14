class SubscriptionDataModel {
  int? examId;
  String? examCode;
  String? examName;
  String? examType;
  String? difficultyLevel;
  String? optedOn;
  String? endDate;
  String? attemptDate;

  SubscriptionDataModel(
      {this.examId,
      this.examCode,
      this.examName,
      this.examType,
      this.difficultyLevel,
      this.optedOn,
      this.endDate,
      this.attemptDate});

  SubscriptionDataModel.fromJson(Map<String, dynamic> json) {
    examId = json['examId'];
    examCode = json['examCode'];
    examName = json['examName'];
    examType = json['examType'];
    difficultyLevel = json['difficultyLevel'];
    optedOn = json['optedOn'];
    endDate = json['endDate'];
    attemptDate = json['attemptDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['examId'] = this.examId;
    data['examCode'] = this.examCode;
    data['examName'] = this.examName;
    data['examType'] = this.examType;
    data['difficultyLevel'] = this.difficultyLevel;
    data['optedOn'] = this.optedOn;
    data['endDate'] = this.endDate;
    data['attemptDate'] = this.attemptDate;
    return data;
  }
}
