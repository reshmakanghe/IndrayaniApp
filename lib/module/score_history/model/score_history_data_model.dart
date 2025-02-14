class ScoreHistoryDataModel {
  int? resultId;
  int? userId;
  String? examCode;
  int? score;
  String? attemptedAt;
  int? timeTaken;
  int? skipAns;
  int? unskipAns;
  int? wrongAns;
  int? rightAns;
  int? totalQuestions;
  int? questionAvgTime;
  String? difficultyLevel;
  String? examName;
  int? totalMarks;
  String? examType;
  int? passingMarks;
  int? passingPercent;
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? percentageScore;

  ScoreHistoryDataModel(
      {this.resultId,
      this.userId,
      this.examCode,
      this.score,
      this.attemptedAt,
      this.timeTaken,
      this.skipAns,
      this.unskipAns,
      this.wrongAns,
      this.rightAns,
      this.totalQuestions,
      this.questionAvgTime,
      this.difficultyLevel,
      this.examName,
      this.totalMarks,
      this.examType,
      this.passingMarks,
      this.passingPercent,
      this.userName,
      this.firstName,
      this.lastName,
      this.email,
      this.mobile,
      this.percentageScore});

  ScoreHistoryDataModel.fromJson(Map<String, dynamic> json) {
    resultId = json['result_id'];
    userId = json['user_id'];
    examCode = json['exam_code'];
    score = json['score'];
    attemptedAt = json['attempted_at'];
    timeTaken = json['time_taken'];
    skipAns = json['skip_ans'];
    unskipAns = json['unskip_ans'];
    wrongAns = json['wrong_ans'];
    rightAns = json['right_ans'];
    totalQuestions = json['total_questions'];
    questionAvgTime = json['question_avg_time'];
    difficultyLevel = json['difficulty_level'];
    examName = json['exam_name'];
    totalMarks = json['total_marks'];
    examType = json['exam_type'];
    passingMarks = json['passing_marks'];
    passingPercent = json['passing_percent'];
    userName = json['user_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    percentageScore = json['percentage_score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result_id'] = this.resultId;
    data['user_id'] = this.userId;
    data['exam_code'] = this.examCode;
    data['score'] = this.score;
    data['attempted_at'] = this.attemptedAt;
    data['time_taken'] = this.timeTaken;
    data['skip_ans'] = this.skipAns;
    data['unskip_ans'] = this.unskipAns;
    data['wrong_ans'] = this.wrongAns;
    data['right_ans'] = this.rightAns;
    data['total_questions'] = this.totalQuestions;
    data['question_avg_time'] = this.questionAvgTime;
    data['difficulty_level'] = this.difficultyLevel;
    data['exam_name'] = this.examName;
    data['total_marks'] = this.totalMarks;
    data['exam_type'] = this.examType;
    data['passing_marks'] = this.passingMarks;
    data['passing_percent'] = this.passingPercent;
    data['user_name'] = this.userName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['percentage_score'] = this.percentageScore;
    return data;
  }
}
