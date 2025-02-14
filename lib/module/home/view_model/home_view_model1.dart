// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:indrayani/module/home/model/home_data_model.dart';
// import 'package:indrayani/utils/WebService/api_base_model.dart';
// import 'package:indrayani/utils/WebService/api_config.dart';
// import 'package:indrayani/utils/WebService/api_service.dart';
// import 'package:indrayani/utils/WebService/end_points_constant.dart';

// class HomeDataViewModel extends GetxController {
//   Rx<APIBaseModel<List<TrendigUpcomingExamDataModel?>?>?>
//       trendingExamListDataModel =
//       RxNullable<APIBaseModel<List<TrendigUpcomingExamDataModel?>?>?>()
//           .setNull();

//   Rx<APIBaseModel<List<TrendigUpcomingExamDataModel?>?>?>
//       upcomingExamListDataModel =
//       RxNullable<APIBaseModel<List<TrendigUpcomingExamDataModel?>?>?>()
//           .setNull();

//   Rx<APIBaseModel<TrendigUpcomingExamDataModel?>?> examDetails =
//       RxNullable<APIBaseModel<TrendigUpcomingExamDataModel?>?>().setNull();

// // get Trending exam list
//   Future<APIBaseModel<List<TrendigUpcomingExamDataModel?>?>?>
//       getTrendingExamList({int? userId}) async {
//     trendingExamListDataModel.value =
//         await APIService.getDataFromServerWithoutErrorModel<
//             List<TrendigUpcomingExamDataModel?>?>(
//       endPoint: trendingExamListEndPoint,
//       create: (dynamic json) {
//         try {
//           return (json as List)
//               .map((e) => TrendigUpcomingExamDataModel.fromJson(e))
//               .toList();
//         } catch (e) {
//           debugPrint(e.toString());
//           return null;
//         }
//       },
//     );
//     // return null;
//     return trendingExamListDataModel.value;
//   }

// // get Upcoming exam list
//   Future<APIBaseModel<List<TrendigUpcomingExamDataModel?>?>?>
//       getUpcomingExamList({int? userId}) async {
//     upcomingExamListDataModel.value =
//         await APIService.getDataFromServerWithoutErrorModel<
//             List<TrendigUpcomingExamDataModel?>?>(
//       endPoint: upcomingExamListEndPoint,
//       create: (dynamic json) {
//         try {
//           return (json as List)
//               .map((e) => TrendigUpcomingExamDataModel.fromJson(e))
//               .toList();
//         } catch (e) {
//           debugPrint(e.toString());
//           return null;
//         }
//       },
//     );
//     return upcomingExamListDataModel.value;
//   }

//   getTrendingExamDetails({required String examId}) async {
//     examDetails?.value =
//         (await APIService.getDataFromServer<TrendigUpcomingExamDataModel?>(
//             endPoint: trendingExamDetailsEndPoint(examId: examId),
//             create: (dynamic json) {
//               return TrendigUpcomingExamDataModel.fromJson(json);
//             }));
//   }

//   getUpcomingExamDetails({required int examId}) async {
//     examDetails?.value =
//         (await APIService.getDataFromServer<TrendigUpcomingExamDataModel?>(
//             endPoint: upcomingExamDetailsEndPoint(examId: examId),
//             create: (dynamic json) {
//               return TrendigUpcomingExamDataModel.fromJson(json);
//             }));
//   }
// }
