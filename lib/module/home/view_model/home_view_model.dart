import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/home/model/home_data_model.dart';
import 'package:indrayani/utils/WebService/api_base_model.dart';
import 'package:indrayani/utils/WebService/api_config.dart';
import 'package:indrayani/utils/WebService/api_service.dart';
import 'package:indrayani/utils/WebService/end_points_constant.dart';
import 'package:intl/intl.dart';

class HomeDataViewModel extends GetxController {
  Rx<APIBaseModel<List<TrendigUpcomingExamDataModel?>?>?>
      trendingExamListDataModel =
      RxNullable<APIBaseModel<List<TrendigUpcomingExamDataModel?>?>?>()
          .setNull();

  Rx<APIBaseModel<List<TrendigUpcomingExamDataModel?>?>?>
      upcomingExamListDataModel =
      RxNullable<APIBaseModel<List<TrendigUpcomingExamDataModel?>?>?>()
          .setNull();

  Rx<APIBaseModel<List<TrendigUpcomingExamDataModel?>?>?> examDetails =
      RxNullable<APIBaseModel<List<TrendigUpcomingExamDataModel?>?>?>()
          .setNull();

  List<TrendigUpcomingExamDataModel> trendingExamModels = [];

// get Trending exam list
  Future<APIBaseModel<List<TrendigUpcomingExamDataModel?>?>?>
      getTrendingExamList() async {
    trendingExamListDataModel.value =
        await APIService.getDataFromServerWithoutErrorModel<
            List<TrendigUpcomingExamDataModel?>?>(
      endPoint: trendingExamListEndPoint,
      create: (dynamic json) {
        try {
          return (json as List)
              .map((e) => TrendigUpcomingExamDataModel.fromJson(e))
              .toList();
        } catch (e) {
          debugPrint(e.toString());
          return null;
        }
      },
    );
    // return null;
    return trendingExamListDataModel.value;
  }

// get Upcoming exam list
  Future<APIBaseModel<List<TrendigUpcomingExamDataModel?>?>?>
      getUpcomingExamList({int? userId}) async {
    upcomingExamListDataModel.value =
        await APIService.getDataFromServerWithoutErrorModel<
            List<TrendigUpcomingExamDataModel?>?>(
      endPoint: upcomingExamListEndPoint,
      create: (dynamic json) {
        try {
          return (json as List)
              .map((e) => TrendigUpcomingExamDataModel.fromJson(e))
              .toList();
        } catch (e) {
          debugPrint(e.toString());
          return null;
        }
      },
    );
    return upcomingExamListDataModel.value;
  }

  Future<APIBaseModel<List<TrendigUpcomingExamDataModel?>?>?> getExamDetails(
      {required String examCode}) async {
    examDetails.value = (await APIService.getDataFromServer<
            List<TrendigUpcomingExamDataModel?>?>(
        endPoint: examDetailsEndPoint(examCode: examCode),
        create: (dynamic json) {
          return (json as List)
              .map((e) => TrendigUpcomingExamDataModel.fromJson(e))
              .toList();
        }));
    return examDetails.value;
  }

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "";
    DateTime dateTime = DateTime.parse(dateStr);
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }
}
