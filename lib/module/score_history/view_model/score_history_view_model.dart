import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/score_history/model/score_history_data_model.dart';
import 'package:indrayani/utils/WebService/api_base_model.dart';
import 'package:indrayani/utils/WebService/api_service.dart';
import 'package:indrayani/utils/WebService/end_points_constant.dart';

class ScoreHistoryViewModel extends GetxController {
  Rx<APIBaseModel<List<ScoreHistoryDataModel?>?>?> scorehistoryDataModel =
      Rx<APIBaseModel<List<ScoreHistoryDataModel?>?>?>(null);

  Rx<List<ScoreHistoryDataModel>?> scoreHistoryExamModels =
      Rx<List<ScoreHistoryDataModel>?>(null);

  Rx<List<ScoreHistoryDataModel>?> filteredScoreExamModels =
      Rx<List<ScoreHistoryDataModel>?>(null);

  List<ScoreHistoryDataModel> scoreHistoryExamModel = [];

  Future<APIBaseModel<List<ScoreHistoryDataModel?>?>?>
      fetchScoreHistoryList() async {
    scorehistoryDataModel.value = await APIService
        .getDataFromServerWithoutErrorModel<List<ScoreHistoryDataModel?>?>(
      endPoint: scorehistoryExamEndPoint,
      create: (dynamic json) {
        try {
          return (json as List)
              .map((e) => ScoreHistoryDataModel.fromJson(e))
              .toList();
        } catch (e) {
          debugPrint(e.toString());
          return null;
        }
      },
    );
    // Assign the fetched data to scoreHistoryExamModels
    scoreHistoryExamModels.value = scorehistoryDataModel.value?.responseBody!
        .cast<ScoreHistoryDataModel>();
    // Initialize filteredScoreExamModels with the fetched data
    filteredScoreExamModels.value = scoreHistoryExamModels.value;

    return scorehistoryDataModel.value;
  }

  void searchExams(String query) {
    if (query.isEmpty) {
      filteredScoreExamModels.value = scoreHistoryExamModels.value;
    } else {
      filteredScoreExamModels.value =
          scoreHistoryExamModels.value?.where((exam) {
        final examName = exam.examName?.toLowerCase() ?? '';
        final examCode = exam.examCode?.toLowerCase() ?? '';
        final lowerCaseQuery = query.toLowerCase();

        return examName.contains(lowerCaseQuery) ||
            examCode.contains(lowerCaseQuery);
      }).toList();
      print("Filtered List: ${filteredScoreExamModels.value}");
    }
  }

  void clearSearch() {
    filteredScoreExamModels.value = scoreHistoryExamModels.value;
  }
}
