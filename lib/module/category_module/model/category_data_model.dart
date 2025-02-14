class CategoryDataModel {
  List<Categories>? categories;

  CategoryDataModel({this.categories});

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? categoryId;
  String? categoryName;
  List<Subcats>? subcats;

  Categories({this.categoryId, this.categoryName, this.subcats});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    if (json['subcats'] != null) {
      subcats = <Subcats>[];
      json['subcats'].forEach((v) {
        subcats!.add(new Subcats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    if (this.subcats != null) {
      data['subcats'] = this.subcats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcats {
  int? categoryId;
  String? categoryName;
  List<Exams>? exams;

  Subcats({this.categoryId, this.categoryName, this.exams});

  Subcats.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    if (json['exams'] != null) {
      exams = <Exams>[];
      json['exams'].forEach((v) {
        exams!.add(new Exams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    if (this.exams != null) {
      data['exams'] = this.exams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Exams {
  int? categoryId;
  String? categoryName;
  int? parentCategory;
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
  int? createdBy;
  String? updatedBy;
  String? updatedAt;
  int? isPurchase;

  Exams(
      {this.categoryId,
      this.categoryName,
      this.parentCategory,
      this.examCode,
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
      this.isPurchase});

  Exams.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    parentCategory = json['parent_category'];
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
    isPurchase = json['is_purchase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['parent_category'] = this.parentCategory;
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
    data['is_purchase'] = this.isPurchase;
    return data;
  }
}

CategoryDataModel createCategoryDataModel(dynamic data) {
  return CategoryDataModel.fromJson(data);
}
