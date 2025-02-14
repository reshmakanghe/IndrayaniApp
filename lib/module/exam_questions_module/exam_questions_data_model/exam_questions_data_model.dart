// class ExamQuestionsDataModel {
//   String? examName;
//   int? examId;
//   int? examDuration;
//   List<Questions>? questions;

//   ExamQuestionsDataModel(
//       {this.examName, this.examId, this.examDuration, this.questions});

//   ExamQuestionsDataModel.fromJson(Map<String, dynamic> json) {
//     examName = json['examName'];
//     examId = json['examId'];
//     examDuration = json['examDuration'];
//     if (json['questions'] != null) {
//       questions = <Questions>[];
//       json['questions'].forEach((v) {
//         questions!.add(new Questions.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['examName'] = this.examName;
//     data['examId'] = this.examId;
//     data['examDuration'] = this.examDuration;
//     if (this.questions != null) {
//       data['questions'] = this.questions!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Questions {
//   int? questionId;
//   String? question;
//   String? option1;
//   String? option2;
//   String? option3;
//   String? option4;
//   int? isMultiSelect;
//   String? note;
//   String? image;

//   Questions(
//       {this.questionId,
//       this.question,
//       this.option1,
//       this.option2,
//       this.option3,
//       this.option4,
//       this.isMultiSelect,
//       this.note,
//       this.image});

//   Questions.fromJson(Map<String, dynamic> json) {
//     questionId = json['questionId'];
//     question = json['question'];
//     option1 = json['option1'];
//     option2 = json['option2'];
//     option3 = json['option3'];
//     option4 = json['option4'];
//     isMultiSelect = json['isMultiSelect'];
//     note = json['note'];
//     image = json['image'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['questionId'] = this.questionId;
//     data['question'] = this.question;
//     data['option1'] = this.option1;
//     data['option2'] = this.option2;
//     data['option3'] = this.option3;
//     data['option4'] = this.option4;
//     data['isMultiSelect'] = this.isMultiSelect;
//     data['note'] = this.note;
//     data['image'] = this.image;
//     return data;
//   }
// }
// class ExamQuestionsDataModel {
//   String? userId;
//   int? resultId;
//   int? totalQuestions;
//   int? examDuration;
//   String? examCode;
//   List<Questions>? questions;

//   ExamQuestionsDataModel(
//       {this.userId,
//       this.resultId,
//       this.totalQuestions,
//       this.examDuration,
//       this.examCode,
//       this.questions});

//   ExamQuestionsDataModel.fromJson(Map<String, dynamic> json) {
//     userId = json['user_id'];
//     resultId = json['result_id'];
//     totalQuestions = json['total_questions'];
//     examDuration = json['exam_duration'];
//     examCode = json['exam_code'];
//     if (json['questions'] != null) {
//       questions = <Questions>[];
//       json['questions'].forEach((v) {
//         questions!.add(new Questions.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['user_id'] = this.userId;
//     data['result_id'] = this.resultId;
//     data['total_questions'] = this.totalQuestions;
//     data['exam_duration'] = this.examDuration;
//     data['exam_code'] = this.examCode;
//     if (this.questions != null) {
//       data['questions'] = this.questions!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Questions {
//   int? questionId;
//   String? question;
//   String? option1;
//   String? option2;
//   String? option3;
//   String? option4;
//   int? rightOption;
//   String? difficultyLevel;
//   String? description;
//   String? note;
//   String? createdAt;
//   int? createdBy;
//   String? updatedBy;
//   String? updatedAt;
//   int? isActive;
//   int? id;
//   String? examCode;

//   Questions(
//       {this.questionId,
//       this.question,
//       this.option1,
//       this.option2,
//       this.option3,
//       this.option4,
//       this.rightOption,
//       this.difficultyLevel,
//       this.description,
//       this.note,
//       this.createdAt,
//       this.createdBy,
//       this.updatedBy,
//       this.updatedAt,
//       this.isActive,
//       this.id,
//       this.examCode});

//   Questions.fromJson(Map<String, dynamic> json) {
//     questionId = json['question_id'];
//     question = json['question'];
//     option1 = json['option1'];
//     option2 = json['option2'];
//     option3 = json['option3'];
//     option4 = json['option4'];
//     rightOption = json['right_option'];
//     difficultyLevel = json['difficulty_level'];
//     description = json['description'];
//     note = json['note'];
//     createdAt = json['created_at'];
//     createdBy = json['created_by'];
//     updatedBy = json['updated_by'];
//     updatedAt = json['updated_at'];
//     isActive = json['isActive'];
//     id = json['id'];
//     examCode = json['exam_code'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['question_id'] = this.questionId;
//     data['question'] = this.question;
//     data['option1'] = this.option1;
//     data['option2'] = this.option2;
//     data['option3'] = this.option3;
//     data['option4'] = this.option4;
//     data['right_option'] = this.rightOption;
//     data['difficulty_level'] = this.difficultyLevel;
//     data['description'] = this.description;
//     data['note'] = this.note;
//     data['created_at'] = this.createdAt;
//     data['created_by'] = this.createdBy;
//     data['updated_by'] = this.updatedBy;
//     data['updated_at'] = this.updatedAt;
//     data['isActive'] = this.isActive;
//     data['id'] = this.id;
//     data['exam_code'] = this.examCode;
//     return data;
//   }
// }
class ExamQuestionsDataModel {
  String? userId;
  int? resultId;
  int? totalQuestions;
  int? examDuration;
  String? examCode;
  List<Questions>? questions;

  ExamQuestionsDataModel({
    this.userId,
    this.resultId,
    this.totalQuestions,
    this.examDuration,
    this.examCode,
    this.questions,
  });

  factory ExamQuestionsDataModel.fromJson(Map<String, dynamic> json) {
    return ExamQuestionsDataModel(
      userId: json['user_id'] as String?,
      resultId: json['result_id'] as int?,
      totalQuestions: json['total_questions'] as int?,
      examDuration: json['exam_duration'] as int?,
      examCode: json['exam_code'] as String?,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((item) => Questions.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'result_id': resultId,
      'total_questions': totalQuestions,
      'exam_duration': examDuration,
      'exam_code': examCode,
      'questions': questions?.map((item) => item.toJson()).toList(),
    };
  }
}

class Questions {
  int? questionId;
  String? question;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  int? rightOption;
  String? difficultyLevel;
  String? description;
  String? note;

  int? isActive;
  int? id;
  String? examCode;

  Questions({
    this.questionId,
    this.question,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.rightOption,
    this.difficultyLevel,
    this.description,
    this.note,
    this.isActive,
    this.id,
    this.examCode,
  });

  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(
      questionId: json['question_id'] as int?,
      question: json['question'] as String?,
      option1: json['option1'] as String?,
      option2: json['option2'] as String?,
      option3: json['option3'] as String?,
      option4: json['option4'] as String?,
      rightOption: json['right_option'] as int?,
      difficultyLevel: json['difficulty_level'] as String?,
      description: json['description'] as String?,
      note: json['note'] as String?,
      isActive: json['isActive'] as int?,
      id: json['id'] as int?,
      examCode: json['exam_code'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'question': question,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'option4': option4,
      'right_option': rightOption,
      'difficulty_level': difficultyLevel,
      'description': description,
      'note': note,
      'isActive': isActive,
      'id': id,
      'exam_code': examCode,
    };
  }
}
