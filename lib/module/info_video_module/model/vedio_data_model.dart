class VideoDataModel {
  int? id;
  String? title;
  String? imageUrl;
  String? externalUrl;
  int? isActive;
  int? isDeleted;
  String? type;

  VideoDataModel(
      {this.id,
      this.title,
      this.imageUrl,
      this.externalUrl,
      this.isActive,
      this.isDeleted,
      this.type});

  VideoDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageUrl = json['image'];
    externalUrl = json['external_url'];
    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.imageUrl;
    data['external_url'] = this.externalUrl;
    data['isActive'] = this.isActive;
    data['isDeleted'] = this.isDeleted;
    data['type'] = this.type;
    return data;
  }
}
