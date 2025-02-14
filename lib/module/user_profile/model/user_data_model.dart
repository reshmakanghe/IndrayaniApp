// class UserDataModel {
//   int? userId;
//   String? name;
//   String? lastName;
//   String? mobileNumber;
//   String? emailId;
//   String? education;
//   String? city;
//   String? district;
//   String? state;
//   String? pinCode;

//   UserDataModel(
//       {this.userId,
//       this.name,
//       this.lastName,
//       this.mobileNumber,
//       this.emailId,
//       this.education,
//       this.city,
//       this.district,
//       this.state,
//       this.pinCode});

//   UserDataModel.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     name = json['name'];
//     lastName = json['lastName'];
//     mobileNumber = json['mobileNumber'];
//     emailId = json['emailId'];
//     education = json['education'];
//     city = json['city'];
//     district = json['district'];
//     state = json['state'];
//     pinCode = json['pinCode'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['userId'] = this.userId;
//     data['name'] = this.name;
//     data['lastName'] = this.lastName;
//     data['mobileNumber'] = this.mobileNumber;
//     data['emailId'] = this.emailId;
//     data['education'] = this.education;
//     data['city'] = this.city;
//     data['district'] = this.district;
//     data['state'] = this.state;
//     data['pinCode'] = this.pinCode;
//     return data;
//   }
// }
class UserDataModel {
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;
  String? city;
  String? district;
  String? state;
  int? pinCode;
  String? education;

  UserDataModel(
      {this.firstName,
      this.lastName,
      this.mobile,
      this.email,
      this.city,
      this.district,
      this.state,
      this.pinCode,
      this.education});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    email = json['email'];
    city = json['city'];
    district = json['district'];
    state =
        json['state'] != null && json['state'].isNotEmpty ? json['state'] : "-";
    pinCode = json['pin_code'] as int?;
    education = json['education'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['city'] = this.city;
    data['district'] = this.district;
    data['state'] = this.state;
    data['pin_code'] = this.pinCode;
    data['education'] = this.education;
    return data;
  }
}
