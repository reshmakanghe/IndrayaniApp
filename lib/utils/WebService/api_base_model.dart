// class APIBaseModel<T> {
//   final int? errorCode;
//   final bool? status;
//   final String? message;
//   final T? responseBody;

//   APIBaseModel({this.status, this.message, this.responseBody, this.errorCode});

//   factory APIBaseModel.fromJson(Map<String, dynamic> json, bool status,
//       [T? Function(dynamic)? create]) {
//     return APIBaseModel<T>(
//       errorCode: json["errorCode"] as int?,
//       status: status,
//       message: json["message"] as String?,
//       responseBody: create != null ? create(json["data"]) : null,
//       // responseBody: create != null
//       //     ? create(
//       //         json["data"],
//       //       )
//       //     : null,
//     );
//   }

//   Map<String, dynamic> toJson(dynamic convert) {
//     final Map<String, dynamic> data = {};
//     data['errorCode'] = errorCode;
//     data['status'] = status;
//     data['message'] = message;
//     data['data'] = convert;
//     return data;
//   }
// }

// class ErrorModel {
//   final String? message;
//   final int? statusCode;

//   ErrorModel({this.message, this.statusCode});

//   factory ErrorModel.fromJson(Map<String, dynamic> json) {
//     return ErrorModel(message: json["message"], statusCode: json["errorCode"]);
//   }
// }
class APIBaseModel<T> {
  final int? errorCode;
  final bool? status;
  final String? message;
  final T? responseBody;

  APIBaseModel({this.status, this.message, this.responseBody, this.errorCode});

  factory APIBaseModel.fromJson(Map<String, dynamic> json, bool status,
      [T? Function(dynamic)? create]) {
    return APIBaseModel<T>(
      errorCode: json["errorCode"] as int?,
      status: status,
      message: json["message"] as String?,
      responseBody: json["data"] != null
          ? (create != null ? create(json["data"]) : null)
          : null,
    );
  }

  Map<String, dynamic> toJson(dynamic convert) {
    final Map<String, dynamic> data = {};
    data['errorCode'] = errorCode;
    data['status'] = status;
    data['message'] = message;
    data['data'] = convert;
    return data;
  }
}

class ErrorModel {
  final String? message;
  final int? statusCode;

  ErrorModel({this.message, this.statusCode});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(message: json["message"], statusCode: json["errorCode"]);
  }
}
