import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:indrayani/module/exam_questions_module/exam_questions_data_model/exam_questions_data_model.dart';
import 'package:indrayani/module/score_module/model/score_card_data_model.dart';
import 'package:indrayani/utils/WebService/api_base_model.dart';
import 'package:indrayani/utils/WebService/api_config.dart';
import 'package:indrayani/utils/WebService/api_service.dart';
import 'package:indrayani/utils/WebService/end_points_constant.dart';

// class ScoreCardViewModel extends GetxController {
//   Rx<APIBaseModel<List<ScoreCardDataModel?>?>?> scoreCardDataModel =
//       APIBaseModel<List<ScoreCardDataModel?>?>().obs;
//   var dataMap = <String, double>{}.obs;
//   //get exam questions list
//   Future<APIBaseModel<List<ScoreCardDataModel?>?>?> getScoreCard(
//       {required String examCode, required int resultId}) async {
//     scoreCardDataModel.value =
//         await APIService.getDataFromServer<List<ScoreCardDataModel?>?>(
//       endPoint: scoreCardEndPoint(
//           examCode: examCode,
//           resultId: resultId), // Replace with actual endpoint
//       create: (json) {
//         try {
//           return (json as List)
//               .map((e) => ScoreCardDataModel.fromJson(e))
//               .toList();
//         } catch (e) {
//           print('Error parsing exam questions data: $e');
//           return null;
//         }
//       },
//     );
//     updateDataMap();
//     return scoreCardDataModel.value;
//   }

//   void updateDataMap() {
//     if (scoreCardDataModel.value?.responseBody?.isNotEmpty ?? false) {
//       var response = scoreCardDataModel.value!.responseBody!.first;
//       dataMap.value = {
//         "${response?.skipAns ?? 0}/${response?.totalQuestions ?? 0}  -  Un-Attempted Question":
//             double.parse("${response?.skipAns ?? 0}"),
//         "${response?.unskipAns ?? 0}/${response?.totalQuestions ?? 0}  -  Attempted Question":
//             double.parse("${response?.unskipAns ?? 0}"),
//         "${response?.rightAns ?? 0}/${response?.totalQuestions ?? 0}   -  Correct Question":
//             double.parse("${response?.rightAns ?? 0}"),
//         "${response?.wrongAns ?? 0}/${response?.totalQuestions ?? 0}   -  Incorrect Question":
//             double.parse("${response?.wrongAns ?? 0}"),
//       };
//     }
//   }
// }

// List<Color> colorList = [
//   Color.fromARGB(255, 181, 238, 0),
//   Color.fromARGB(255, 0, 182, 138),
//   Color.fromARGB(255, 0, 196, 197),
//   Color.fromARGB(255, 254, 171, 0),
// ];
// List<String> imagePaths = [
//   "assets/Score/icon1.png",
//   "assets/Score/icon2.png",
//   "assets/Score/icon3.png",
//   "assets/Score/icon4.png",
// ];
// class ScoreCardViewModel extends GetxController {
//   Rx<APIBaseModel<List<ScoreCardDataModel?>?>?> scoreCardDataModel =
//       APIBaseModel<List<ScoreCardDataModel?>?>().obs;
//   var dataMap = <String, double>{}.obs;

//   Future<APIBaseModel<List<ScoreCardDataModel?>?>?> getScoreCard({
//     required String examCode,
//     required int resultId,
//   }) async {
//     scoreCardDataModel.value =
//         await APIService.getDataFromServer<List<ScoreCardDataModel?>?>(
//       endPoint: scoreCardEndPoint(
//         examCode: examCode,
//         resultId: resultId,
//       ),
//       create: (json) {
//         try {
//           return (json as List)
//               .map((e) => ScoreCardDataModel.fromJson(e))
//               .toList();
//         } catch (e) {
//           print('Error parsing exam questions data: $e');
//           return null;
//         }
//       },
//     );
//     updateDataMap();
//     return scoreCardDataModel.value;
//   }

//   void updateDataMap() {
//     if (scoreCardDataModel.value?.responseBody?.isNotEmpty ?? false) {
//       var response = scoreCardDataModel.value!.responseBody!.first;
//       dataMap.value = {
//         "${response?.skipAns ?? 0}/${response?.totalQuestions ?? 0}  -  Un-Attempted Question":
//             double.parse("${response?.skipAns ?? 0}"),
//         "${response?.unskipAns ?? 0}/${response?.totalQuestions ?? 0}  -  Attempted Question":
//             double.parse("${response?.unskipAns ?? 0}"),
//         "${response?.rightAns ?? 0}/${response?.totalQuestions ?? 0}   -  Correct Question":
//             double.parse("${response?.rightAns ?? 0}"),
//         "${response?.wrongAns ?? 0}/${response?.totalQuestions ?? 0}   -  Incorrect Question":
//             double.parse("${response?.wrongAns ?? 0}"),
//       };
//     } else {
//       dataMap.value = {
//         "0/0  -  Un-Attempted Question": 0,
//         "0/0  -  Attempted Question": 0,
//         "0/0  -  Correct Question": 0,
//         "0/0  -  Incorrect Question": 0,
//       };
//     }
//   }
// }

// List<Color> colorList = [
//   Color.fromARGB(255, 181, 238, 0),
//   Color.fromARGB(255, 0, 182, 138),
//   Color.fromARGB(255, 0, 196, 197),
//   Color.fromARGB(255, 254, 171, 0),
// ];
// List<String> imagePaths = [
//   "assets/Score/icon1.png",
//   "assets/Score/icon2.png",
//   "assets/Score/icon3.png",
//   "assets/Score/icon4.png",
// ];
class ScoreCardViewModel extends GetxController {
  Rx<APIBaseModel<List<ScoreCardDataModel?>?>?> scoreCardDataModel =
      APIBaseModel<List<ScoreCardDataModel?>?>().obs;
  var dataMap = <String, double>{}.obs;
  var legendData = <String, String>{}.obs;

  Future<APIBaseModel<List<ScoreCardDataModel?>?>?> getScoreCard({
    required String examCode,
    required int resultId,
  }) async {
    scoreCardDataModel.value =
        await APIService.getDataFromServer<List<ScoreCardDataModel?>?>(
      endPoint: scoreCardEndPoint(
        examCode: examCode,
        resultId: resultId,
      ),
      create: (json) {
        try {
          return (json as List)
              .map((e) => ScoreCardDataModel.fromJson(e))
              .toList();
        } catch (e) {
          print('Error parsing exam questions data: $e');
          return null;
        }
      },
    );
    updateLegendData();
    dataMap.value = calculateDataMap(legendData);
    return scoreCardDataModel.value;
  }

  void updateLegendData() {
    if (scoreCardDataModel.value?.responseBody?.isNotEmpty ?? false) {
      var response = scoreCardDataModel.value!.responseBody!.first;
      legendData.value = {
        "Un-Attempted Question  -  ${response?.skipAns ?? 0}/${response?.totalQuestions ?? 0}":
            "${response?.skipAns ?? 0}/${response?.totalQuestions ?? 0}",
        "Attempted Question        -  ${response?.unskipAns ?? 0}/${response?.totalQuestions ?? 0}  ":
            "${response?.unskipAns ?? 0}/${response?.totalQuestions ?? 0}",
        "Correct Question             -  ${response?.rightAns ?? 0}/${response?.totalQuestions ?? 0}":
            "${response?.rightAns ?? 0}/${response?.totalQuestions ?? 0}",
        "Incorrect Question          -  ${response?.wrongAns ?? 0}/${response?.totalQuestions ?? 0}":
            "${response?.wrongAns ?? 0}/${response?.totalQuestions ?? 0}",
      };
    } else {
      legendData.value = {
        "0/0  -  Un-Attempted Question": "0/0",
        "0/0  -  Attempted Question": "0/0",
        "0/0  -  Correct Question": "0/0",
        "0/0  -  Incorrect Question": "0/0",
      };
    }
  }

  Map<String, double> calculateDataMap(Map<String, String> legendData) {
    Map<String, double> dataMap = {};

    legendData.forEach((label, value) {
      // Split the legend value (e.g., "2/50")
      List<String> splitValue = value.split('/');
      double numerator = double.parse(splitValue[0]);
      double denominator = double.parse(splitValue[1]);

      // Calculate the percentage
      double percentage = (numerator / denominator) * 100;

      // Add the percentage to the dataMap with the original label
      dataMap[label] = percentage;
    });

    return dataMap;
  }

  List<Color> colorList = [
    Color.fromARGB(255, 181, 238, 0),
    Color.fromARGB(255, 0, 182, 138),
    Color.fromARGB(255, 0, 196, 197),
    Color.fromARGB(255, 254, 171, 0),
  ];
  List<String> imagePaths = [
    "assets/Score/icon1.png",
    "assets/Score/icon2.png",
    "assets/Score/icon3.png",
    "assets/Score/icon4.png",
  ];
}
