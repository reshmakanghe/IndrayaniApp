class LoginDataModel {
  int? userId;
  int? otp;
  String? token;
  String? mobile;
  String? email;

  LoginDataModel({this.userId, this.token, this.email, this.mobile, this.otp});

  LoginDataModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    token = json['token'];
    mobile = json['mobile'];
    email = json["email"];

    otp = json["otp"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['token'] = token;
    data['mobile'] = mobile;
    data['email'] = email;
    data['otp'] = otp;
    return data;
  }

  String? _formatDate(String? dobString) {
    if (dobString != null) {
      DateTime dobDateTime = DateTime.parse(dobString);
      return "${dobDateTime.day.toString().padLeft(2, '0')}-${dobDateTime.month.toString().padLeft(2, '0')}-${dobDateTime.year}";
    }
    return null;
  }
}
