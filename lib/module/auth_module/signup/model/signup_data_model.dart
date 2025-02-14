class SignUpDataModel {
  String? firstName;
  String? lastName;
  String? emailId;
  String? mobileNumber;
  String? education;
  String? city;
  String? district;
  String? state;
  String? pinCode;
  String? fcmToken;
  String? mobileSignature;
  String? token;
  int? userId;
  int? otp;

  SignUpDataModel(
      {this.firstName,
      this.lastName,
      this.emailId,
      this.mobileNumber,
      this.education,
      this.city,
      this.district,
      this.state,
      this.pinCode,
      this.fcmToken,
      this.mobileSignature,
      this.userId,
      this.otp,
      this.token});

  SignUpDataModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    emailId = json['email'];
    mobileNumber = json['mobile'];
    education = json['education'];
    city = json['city'];
    district = json['district'];
    state = json['state'];
    pinCode = json['pin_code'];
    fcmToken = json['fcm_token'];
    mobileSignature = json['mobile_signature'];
    token = json['token'];
    otp = json['otp'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    // final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.emailId;
    data['mobile'] = this.mobileNumber;
    data['education'] = this.education;
    data['city'] = this.city;
    data['district'] = this.district;
    data['state'] = this.state;
    data['pin_code'] = this.pinCode;
    data['fcm_token'] = this.fcmToken;
    data['mobile_signature'] = this.mobileSignature;
    data['token'] = this.token;
    data['user_id'] = this.userId;
    data['otp'] = this.otp;
    return data;
  }
}
