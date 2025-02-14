// import 'dart:async';

// class TrendigUpcomingExamDataModel {
//   String? examCode;
//   String? examName;
//   String? examDesc;
//   int? examCat;
//   int? examSubCat;
//   String? examType;
//   int? price;
//   int? examDuration;
//   int? totalMarks;
//   int? passingMarks;
//   int? passingPercent;
//   String? img;
//   int? rightAns;
//   int? wrongAns;
//   int? skipAns;
//   int? totalQuestions;
//   int? isActive;
//   int? isDeleted;
//   String? createdAt;
//   int? createdBy;
//   String? updatedBy;
//   String? updatedAt;
//   String? startDate;
//   String? endDate;
//   String? availableOn;
//   String? difficulty;
//   int? isPurchase;

//   TrendigUpcomingExamDataModel(
//       {this.examCode,
//       this.examName,
//       this.examDesc,
//       this.examCat,
//       this.examSubCat,
//       this.examType,
//       this.price,
//       this.examDuration,
//       this.totalMarks,
//       this.passingMarks,
//       this.passingPercent,
//       this.img,
//       this.rightAns,
//       this.wrongAns,
//       this.skipAns,
//       this.totalQuestions,
//       this.isActive,
//       this.isDeleted,
//       this.createdAt,
//       this.createdBy,
//       this.updatedBy,
//       this.updatedAt,
//       this.startDate,
//       this.endDate,
//       this.availableOn,
//       this.isPurchase,
//       this.difficulty});

//   TrendigUpcomingExamDataModel.fromJson(Map<String, dynamic> json) {
//     // examId = json['examId'];
//     examCode = json['exam_code'];
//     examName = json['exam_name'];
//     examDesc = json['exam_desc'];
//     examCat = json['exam_cat'];
//     examSubCat = json['exam_sub_cat'];
//     examType = json['exam_type'];
//     // examId = json['examId'];
//     examCode = json['exam_code'];
//     examName = json['exam_name'];
//     examDesc = json['exam_desc'];
//     examCat = json['exam_cat'];
//     examSubCat = json['exam_sub_cat'];
//     examType = json['exam_type'];
//     price = json['price'];
//     examDuration = json['exam_duration'] as int?;
//     totalMarks = json['total_marks'] as int?;
//     passingMarks = json['passing_marks'] as int?;
//     passingPercent = json['passing_percent'] as int?;
//     img = json['img'];
//     rightAns = json['right_ans'] as int?;
//     wrongAns = json['wrong_ans'] as int?;
//     skipAns = json['skip_ans'] as int?;
//     totalQuestions = json['total_questions'] as int?;
//     isActive = json['is_active'];
//     isDeleted = json['is_deleted'];
//     createdAt = json['created_at'];
//     createdBy = json['created_by'];
//     updatedBy = json['updated_by'];
//     updatedAt = json['updated_at'];
//     startDate = json['start_date'];
//     endDate = json['end_date'];
//     availableOn = json['launch_date'];
//     isPurchase = json['is_purchase'];
//     difficulty = json['difficulty_level'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['exam_code'] = this.examCode;
//     data['exam_name'] = this.examName;
//     data['exam_desc'] = this.examDesc;
//     data['exam_cat'] = this.examCat;
//     data['exam_sub_cat'] = this.examSubCat;
//     data['exam_type'] = this.examType;
//     data['exam_code'] = this.examCode;
//     data['exam_name'] = this.examName;
//     data['exam_desc'] = this.examDesc;
//     data['exam_cat'] = this.examCat;
//     data['exam_sub_cat'] = this.examSubCat;
//     data['exam_type'] = this.examType;
//     data['price'] = this.price;
//     data['exam_duration'] = this.examDuration;
//     data['total_marks'] = this.totalMarks;
//     data['passing_marks'] = this.passingMarks;
//     data['passing_percent'] = this.passingPercent;
//     data['img'] = this.img;
//     data['right_ans'] = this.rightAns;
//     data['wrong_ans'] = this.wrongAns;
//     data['skip_ans'] = this.skipAns;
//     data['total_questions'] = this.totalQuestions;
//     data['is_active'] = this.isActive;
//     data['is_deleted'] = this.isDeleted;
//     data['created_at'] = this.createdAt;
//     data['created_by'] = this.createdBy;
//     data['updated_by'] = this.updatedBy;
//     data['updated_at'] = this.updatedAt;
//     data['start_date'] = this.startDate;
//     data['end_date'] = this.endDate;
//     data['available_on'] = this.availableOn;
//     data['difficulty_level'] = this.difficulty;
//     data['exam_duration'] = this.examDuration;
//     data['total_marks'] = this.totalMarks;
//     data['passing_marks'] = this.passingMarks;
//     data['passing_percent'] = this.passingPercent;
//     data['img'] = this.img;
//     data['right_ans'] = this.rightAns;
//     data['wrong_ans'] = this.wrongAns;
//     data['skip_ans'] = this.skipAns;
//     data['total_questions'] = this.totalQuestions;
//     data['is_active'] = this.isActive;
//     data['is_deleted'] = this.isDeleted;
//     data['created_at'] = this.createdAt;
//     data['created_by'] = this.createdBy;
//     data['updated_by'] = this.updatedBy;
//     data['updated_at'] = this.updatedAt;
//     data['start_date'] = this.startDate;
//     data['end_date'] = this.endDate;
//     data['launch_date'] = this.availableOn;
//     data['is_purchase'] = this.isPurchase;
//     data['difficulty_level'] = this.difficulty;
//     return data;
//   }
// }
class TrendigUpcomingExamDataModel {
  String? examCode;
  String? examName;
  String? examDesc;
  String? examType;
  int? price;
  int? examDuration;
  int? totalQuestions;
  int? totalMarks;
  int? passingMarks;
  int? passingPercent;
  String? difficultyLevel;
  String? img;
  int? rightAns;
  int? wrongAns;
  int? skipAns;
  int? isActive;
  String? createdAt;
  String? createdBy;
  String? updatedBy;
  String? updatedAt;
  String? startDate;
  String? endDate;
  int? isPurchase;
  List<ExamCat>? examCat;
  int? questions;
  int? mapQuestions;
  String? availableOn;
  String? type;
  TrendigUpcomingExamDataModel(
      {this.examCode,
      this.examName,
      this.examDesc,
      this.examType,
      this.price,
      this.examDuration,
      this.totalQuestions,
      this.totalMarks,
      this.passingMarks,
      this.passingPercent,
      this.difficultyLevel,
      this.img,
      this.rightAns,
      this.wrongAns,
      this.skipAns,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.updatedBy,
      this.updatedAt,
      this.startDate,
      this.endDate,
      this.isPurchase,
      this.examCat,
      this.questions,
      this.mapQuestions,
      this.availableOn});

  TrendigUpcomingExamDataModel.fromJson(Map<String, dynamic> json) {
    examCode = json['exam_code'];
    examName = json['exam_name'];
    examDesc = json['exam_desc'];
    examType = json['exam_type'];
    price = json['price'];
    examDuration = json['exam_duration'];
    totalQuestions = json['total_questions'];
    totalMarks = json['total_marks'];
    passingMarks = json['passing_marks'];
    passingPercent = json['passing_percent'];
    difficultyLevel = json['difficulty_level'];
    img = json['img'];
    rightAns = json['right_ans'];
    wrongAns = json['wrong_ans'];
    skipAns = json['skip_ans'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    isPurchase = json['is_purchase'];
    availableOn = json['launch_date'];
    if (json['exam_cat'] != null) {
      examCat = <ExamCat>[];
      json['exam_cat'].forEach((v) {
        examCat!.add(new ExamCat.fromJson(v));
      });
    }
    questions = json['questions'];
    mapQuestions = json['map_questions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exam_code'] = this.examCode;
    data['exam_name'] = this.examName;
    data['exam_desc'] = this.examDesc;
    data['exam_type'] = this.examType;
    data['price'] = this.price;
    data['exam_duration'] = this.examDuration;
    data['total_questions'] = this.totalQuestions;
    data['total_marks'] = this.totalMarks;
    data['passing_marks'] = this.passingMarks;
    data['passing_percent'] = this.passingPercent;
    data['difficulty_level'] = this.difficultyLevel;
    data['img'] = this.img;
    data['right_ans'] = this.rightAns;
    data['wrong_ans'] = this.wrongAns;
    data['skip_ans'] = this.skipAns;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['updated_at'] = this.updatedAt;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['is_purchase'] = this.isPurchase;
    data['launch_date'] = this.availableOn;
    if (this.examCat != null) {
      data['exam_cat'] = this.examCat!.map((v) => v.toJson()).toList();
    }
    data['questions'] = this.questions;
    data['map_questions'] = this.mapQuestions;
    return data;
  }
}

class ExamCat {
  String? categoryId;
  String? categoryName;

  ExamCat({this.categoryId, this.categoryName});

  ExamCat.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    return data;
  }
}
