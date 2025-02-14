class ScoreCardDataModel {
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
  String? percentageScore;

  ScoreCardDataModel(
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
      this.percentageScore});

  ScoreCardDataModel.fromJson(Map<String, dynamic> json) {
    resultId = json['result_id'] as int? ?? 0;
    userId = json['user_id'] as int ?? 0;
    examCode = json['exam_code'] as String? ?? "";
    score = json['score'] as int? ?? 0;
    attemptedAt = json['attempted_at'] as String? ?? "";
    timeTaken = json['time_taken'] as int? ?? 0;
    skipAns = json['skip_ans'] as int? ?? 0;
    unskipAns = json['unskip_ans'] as int? ?? 0;
    wrongAns = json['wrong_ans'] as int? ?? 0;
    rightAns = json['right_ans'] as int? ?? 0;
    totalQuestions = json['total_questions'] as int? ?? 0;
    questionAvgTime = json['question_avg_time'] as int? ?? 0;
    difficultyLevel = json['difficulty_level'] as String? ?? "";
    examName = json['exam_name'] as String? ?? "";
    totalMarks = json['total_marks'] as int? ?? 0;
    examType = json['exam_type'] as String? ?? "";
    percentageScore = json['percentage_score'] as String? ?? "";
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
    data['percentage_score'] = this.percentageScore;
    return data;
  }
}
