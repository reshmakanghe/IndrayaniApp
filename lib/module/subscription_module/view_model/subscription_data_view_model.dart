import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:indrayani/module/home/model/home_data_model.dart';
import 'package:indrayani/module/subscription_module/model/subscription_data_model.dart';
import 'package:indrayani/utils/WebService/api_base_model.dart';
import 'package:indrayani/utils/WebService/api_config.dart';
import 'package:indrayani/utils/WebService/api_service.dart';
import 'package:indrayani/utils/WebService/end_points_constant.dart';
import 'package:indrayani/utils/constants/StringConstants/string_constants.dart';
import 'package:indrayani/utils/initialization_services/singleton_service.dart';

class SubscriptionDataViewModel extends GetxController {
  Rx<APIBaseModel<List<SubscriptionDataModel?>?>?> subscribeListExamDataModel =
      RxNullable<APIBaseModel<List<SubscriptionDataModel?>?>?>().setNull();

  Rx<APIBaseModel<List<SubscriptionDataModel?>?>?>
      subscribeExamDetailsDataModel =
      RxNullable<APIBaseModel<List<SubscriptionDataModel?>?>?>().setNull();

  Rx<APIBaseModel<SubscriptionDataModel?>?>? subscribeExamDataModel =
      RxNullable<APIBaseModel<SubscriptionDataModel?>?>().setNull();

  List<SubscriptionDataModel> subscriptionExamsModels = [];
// get Subscribed exam list
  Future<APIBaseModel<List<SubscriptionDataModel?>?>?> getSubscribedExam(
      {int? userId}) async {
    subscribeListExamDataModel.value = await APIService
        .getDataFromServerWithoutErrorModel<List<SubscriptionDataModel?>?>(
      endPoint: subscribedExamEndPoint,
      create: (dynamic json) {
        try {
          return (json as List)
              .map((e) => SubscriptionDataModel.fromJson(e))
              .toList();
        } catch (e) {
          debugPrint(e.toString());
          return null;
        }
      },
    );
    return subscribeListExamDataModel.value;
  }

// get Subscribed exam details
  Future<APIBaseModel<List<SubscriptionDataModel?>?>?> getSubscribeExamDetails(
      {required String examCode}) async {
    subscribeExamDetailsDataModel.value =
        (await APIService.getDataFromServer<List<SubscriptionDataModel?>?>(
            endPoint: subscribeExamDetailsEndPoint(examCode: examCode),
            create: (dynamic json) {
              return (json as List)
                  .map((e) => SubscriptionDataModel.fromJson(e))
                  .toList();
            }));
    return subscribeListExamDataModel.value;
  }

//POST Subscribed exam

  Future<APIBaseModel<SubscriptionDataModel?>?> subscribeExams({
    required List<String> examCodes,
    // int? userId,
    double? price,
  }) async {
    final List exams = [];

    print(exams);

    final response = await APIService.postDataToServer<SubscriptionDataModel?>(
      endPoint: postTransactionExamsEndPoint,
      body: {
        "exam_code": examCodes,
        "price": price,
        "transaction_id": Random().nextInt(1000000),
        "order_id": Random().nextInt(1000000),
        "banktrans_id": Random().nextInt(1000000),
        "transaction_date": DateTime.now().toIso8601String(),
        "transaction_status": "success",
        "created_by": IndrayaniAppGLobal.instance.loginViewModel.loginDataModel
                ?.value?.responseBody?.userId ??
            0,
      },
      create: (dynamic json) {
        if (json != null && json is Map<String, dynamic>) {
          return SubscriptionDataModel.fromJson(json);
        }
        return null;
      },
    );

    subscribeExamDataModel?.value = response;
    return subscribeExamDataModel?.value;
  }
}
