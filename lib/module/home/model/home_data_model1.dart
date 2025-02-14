class TrendigUpcomingExamDataModel {
  String? examId;
  int? examCode;
  String? examName;
  String? examImage;
  String? examType;
  String? type;
  String? dificultyLevel;
  String? discription;
  int? price;
  String? optedOn;
  String? endDate;
  String? duration;
  String? totalMarks;
  int? totalQuestion;
  int? marksForCorrectAnswer;
  int? negativeMarkingForIncorrectAnswer;
  int? negativeMarkingForUnattemptedQuestion;
  String? passingPercentage;

  TrendigUpcomingExamDataModel(
      {this.examId,
      this.examCode,
      this.examName,
      this.examImage,
      this.examType,
      this.type,
      this.dificultyLevel,
      this.discription,
      this.price,
      this.optedOn,
      this.endDate,
      this.duration,
      this.totalMarks,
      this.totalQuestion,
      this.marksForCorrectAnswer,
      this.negativeMarkingForIncorrectAnswer,
      this.negativeMarkingForUnattemptedQuestion,
      this.passingPercentage});

  TrendigUpcomingExamDataModel.fromJson(Map<String, dynamic> json) {
    examId = json['examId'];
    examCode = json['examCode'];
    examName = json['examName'];
    examImage = json['examImage'];
    examType = json['examType'];
    type = json['type'];
    dificultyLevel = json['dificultyLevel'];
    discription = json['discription'];
    price = json['price'];
    optedOn = json['optedOn'];
    endDate = json['endDate'];
    duration = json['duration'];
    totalMarks = json['totalMarks'];
    totalQuestion = json['totalQuestion'];
    marksForCorrectAnswer = json['marksForCorrectAnswer'];
    negativeMarkingForIncorrectAnswer =
        json['negativeMarkingForIncorrectAnswer'];
    negativeMarkingForUnattemptedQuestion =
        json['negativeMarkingForUnattemptedQuestion'];
    passingPercentage = json['passingPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['examId'] = this.examId;
    data['examCode'] = this.examCode;
    data['examName'] = this.examName;
    data['examImage'] = this.examImage;
    data['examType'] = this.examType;
    data['type'] = this.type;
    data['dificultyLevel'] = this.dificultyLevel;
    data['discription'] = this.discription;
    data['price'] = this.price;
    data['optedOn'] = this.optedOn;
    data['endDate'] = this.endDate;
    data['duration'] = this.duration;
    data['totalMarks'] = this.totalMarks;
    data['totalQuestion'] = this.totalQuestion;
    data['marksForCorrectAnswer'] = this.marksForCorrectAnswer;
    data['negativeMarkingForIncorrectAnswer'] =
        this.negativeMarkingForIncorrectAnswer;
    data['negativeMarkingForUnattemptedQuestion'] =
        this.negativeMarkingForUnattemptedQuestion;
    data['passingPercentage'] = this.passingPercentage;
    return data;
  }
}
