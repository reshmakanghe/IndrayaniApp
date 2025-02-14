class ArticleDataModel {
  int? id;
  String? imageUrl;
  String? title;
  String? content;
  String? externalUrl;
  String? createdAt;
  String? createdBy;
  int? isActive;
  int? isDeleted;
  String? type;
  ArticleDataModel(
      {this.id,
      this.title,
      this.imageUrl,
      this.content,
      this.externalUrl,
      this.createdAt,
      this.createdBy,
      this.isActive,
      this.isDeleted,
      this.type});

  ArticleDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    imageUrl = json['image'];
    externalUrl = json['external_url'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['image'] = this.imageUrl;
    data['external_url'] = this.externalUrl;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['type'] = this.type;
    return data;
  }
}
