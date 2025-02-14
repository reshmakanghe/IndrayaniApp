class ReviewQuestionDataModel {
  int? queId;
  String? question;
  String? difficultyLevel;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  int? rightOption;
  int? userAnswer;
  String? userScore;
  String? notes;

  ReviewQuestionDataModel(
      {this.queId,
      this.question,
      this.difficultyLevel,
      this.option1,
      this.option2,
      this.option3,
      this.option4,
      this.rightOption,
      this.userAnswer,
      this.userScore,
      this.notes});

  ReviewQuestionDataModel.fromJson(Map<String, dynamic> json) {
    queId = json['queId'];
    question = json['question'];
    difficultyLevel = json['difficultyLevel'];
    option1 = json['option1'];
    option2 = json['option2'];
    option3 = json['option3'];
    option4 = json['option4'];
    rightOption = json['right_option'];
    userAnswer = json['user_option'];
    userScore = json['user_score'];
    notes = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['queId'] = this.queId;
    data['question'] = this.question;
    data['difficultyLevel'] = this.difficultyLevel;
    data['option1'] = this.option1;
    data['option2'] = this.option2;
    data['option3'] = this.option3;
    data['option4'] = this.option4;
    data['right_option'] = this.rightOption;
    data['user_option'] = this.userAnswer;
    data['user_score'] = this.userScore;
    data['note'] = this.notes;
    return data;
  }
}
