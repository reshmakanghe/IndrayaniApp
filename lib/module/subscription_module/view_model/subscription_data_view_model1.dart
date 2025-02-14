// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:indrayani/module/home/model/home_data_model.dart';
// import 'package:indrayani/module/subscription_module/model/subscription_data_model.dart';
// import 'package:indrayani/utils/WebService/api_base_model.dart';
// import 'package:indrayani/utils/WebService/api_config.dart';
// import 'package:indrayani/utils/WebService/api_service.dart';
// import 'package:indrayani/utils/WebService/end_points_constant.dart';

// class SubscriptionDataViewModel extends GetxController {
//   Rx<APIBaseModel<List<SubscriptionDataModel?>?>?> examListDataModel =
//       RxNullable<APIBaseModel<List<SubscriptionDataModel?>?>?>().setNull();

//   Rx<APIBaseModel<SubscriptionDataModel?>?>? examDetails =
//       RxNullable<APIBaseModel<SubscriptionDataModel?>?>().setNull();

// // get Subscribed exam list
//   Future<APIBaseModel<List<SubscriptionDataModel?>?>?> getSubscribedExam(
//       {int? userId}) async {
//     examListDataModel.value = await APIService
//         .getDataFromServerWithoutErrorModel<List<SubscriptionDataModel?>?>(
//       endPoint: subscribedExamEndPoint,
//       create: (dynamic json) {
//         try {
//           return (json as List)
//               .map((e) => SubscriptionDataModel.fromJson(e))
//               .toList();
//         } catch (e) {
//           debugPrint(e.toString());
//           return null;
//         }
//       },
//     );
//     //return pingersListDataModel.value;
//   }

// // get Subscribed exam details
//   getSubscribedExamDetails({required int examId}) async {
//     examDetails?.value =
//         (await APIService.getDataFromServer<SubscriptionDataModel?>(
//             endPoint: subscriptionExamDetailsEndPoint(examId: examId),
//             create: (dynamic json) {
//               return SubscriptionDataModel.fromJson(json);
//             }));
//   }
// }
