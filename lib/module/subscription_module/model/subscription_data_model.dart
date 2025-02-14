class SubscriptionDataModel {
  dynamic? examCode;
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

  String? updatedAt;
  String? startDate;
  String? endDate;
  int? isPurchase;
  List<MapCat>? mapCat;
  int? questions;
  int? mapQuestions;
  String? launchDate;
  String? type;

  SubscriptionDataModel(
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
      this.updatedAt,
      this.startDate,
      this.endDate,
      this.isPurchase,
      this.mapCat,
      this.questions,
      this.mapQuestions,
      this.launchDate,
      this.type});

  SubscriptionDataModel.fromJson(Map<String, dynamic> json) {
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

    updatedAt = json['updated_at'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    isPurchase = json['is_purchase'];
    if (json['map_cat'] != null) {
      mapCat = <MapCat>[];
      json['map_cat'].forEach((v) {
        mapCat!.add(new MapCat.fromJson(v));
      });
    }
    questions = json['questions'];
    mapQuestions = json['map_questions'];
    launchDate = json['launch_date'];
    type = json['type'];
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

    data['updated_at'] = this.updatedAt;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['is_purchase'] = this.isPurchase;
    if (this.mapCat != null) {
      data['map_cat'] = this.mapCat!.map((v) => v.toJson()).toList();
    }
    data['questions'] = this.questions;
    data['map_questions'] = this.mapQuestions;
    data['launch_date'] = this.launchDate;
    data['type'] = this.type;
    return data;
  }
}

class MapCat {
  int? categoryId;
  String? categoryName;

  MapCat({this.categoryId, this.categoryName});

  MapCat.fromJson(Map<String, dynamic> json) {
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
