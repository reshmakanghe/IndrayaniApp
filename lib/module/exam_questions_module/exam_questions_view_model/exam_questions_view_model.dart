// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:indrayani/module/exam_questions_module/exam_questions_data_model/exam_questions_data_model.dart';
// import 'package:indrayani/utils/WebService/api_base_model.dart';
// import 'package:indrayani/utils/WebService/api_config.dart';
// import 'package:indrayani/utils/WebService/api_service.dart';
// import 'package:indrayani/utils/WebService/end_points_constant.dart';

// class ExamQuestionsViewModel extends GetxController {
//   Rx<APIBaseModel<ExamQuestionsDataModel?>?> examQuestionsDataModel =
//       APIBaseModel<ExamQuestionsDataModel?>().obs;

//   Rx<APIBaseModel<List<ExamQuestionsDataModel?>?>?> examQuestionsListDataModel =
//       RxNullable<APIBaseModel<List<ExamQuestionsDataModel?>?>?>().setNull();

//   Rx<int> currentQuestionIndex = Rx<int>(0);
//   RxInt examTime = 0.obs;
//   var selectedOption = ''.obs;
//   RxInt secondsElapsed = 0.obs; // Start from 0 seconds
//   int currentQuestionStartTime = 0;
//   List<int> timeSpentOnQuestions = [];
//   List<String?> selectedOptions = [];

//   void selectOption(String? option) {
//     selectedOption.value = option ?? '';
//     selectedOptions[currentQuestionIndex.value] = selectedOption.value;
//   }

//   //get exam questions list
//   Future<APIBaseModel<List<ExamQuestionsDataModel?>?>?> getExamQuestionsList(
//       {int? examId}) async {
//     examQuestionsListDataModel.value = await APIService
//         .getDataFromServerWithoutErrorModel<List<ExamQuestionsDataModel?>?>(
//       endPoint: "",
//       create: (dynamic json) {
//         try {
//           return (json as List)
//               .map((e) => ExamQuestionsDataModel.fromJson(e))
//               .toList();
//         } catch (e) {
//           debugPrint(e.toString());
//           return null;
//         }
//       },
//     );
//     return examQuestionsListDataModel.value;
//   }

//   //get exam questions
//   Future<void> fetchExamQuestions() async {
//     try {
//       examQuestionsDataModel.value =
//           await APIService.getDataFromServer<ExamQuestionsDataModel?>(
//         endPoint: '', // Replace with actual endpoint
//         create: (json) {
//           try {
//             return ExamQuestionsDataModel.fromJson(json);
//           } catch (e) {
//             print('Error parsing exam questions data: $e');
//             return null;
//           }
//         },
//       );
//       // Initialize selectedOptions and timeSpentOnQuestions based on questions count
//       selectedOptions = List<String?>.filled(
//           examQuestionsDataModel.value?.responseBody?.questions?.length ?? 0,
//           null);
//       timeSpentOnQuestions = List<int>.filled(
//           examQuestionsDataModel.value?.responseBody?.questions?.length ?? 0,
//           0);
//     } catch (e) {
//       print('Error fetching exam questions: $e');
//     }
//   }

//   //post exam questions with answer
//   Future<APIBaseModel<Map<String, dynamic>?>?> submitExamQustionAnswersList({
//     required int examId,
//   }) async {
//     List<Map<String, dynamic>> dataArray = [];

//     final questions = examQuestionsDataModel.value?.responseBody?.questions ??
//         fallbackQuestions;

//     for (int i = 0; i < questions.length; i++) {
//       dataArray.add({
//         "examId": examId,
//         "questionId": questions[i].questionId,
//         "answer": selectedOptions[i],
//         "timeSpent": timeSpentOnQuestions[i],
//       });
//     }

//     print(dataArray);

//     return (await APIService.postArrayDataToServer<Map<String, dynamic>?>(
//       endPoint: examSubmitEndPoint(examId: examId),
//       body: dataArray,
//       create: (dynamic json) {
//         return json;
//       },
//     ));
//   }
//   // Future<APIBaseModel<Map<String, dynamic>?>?> submitExamQustionAnswersList(
//   //     {required int examId}) async {
//   //   List<Map<String, dynamic>> dataArray = [];

//   //   final questions = examQuestionsDataModel.value?.responseBody?.questions ??
//   //       fallbackQuestions;
//   //   for (int i = 0; i < questions.length; i++) {
//   //     dataArray.add({
//   //       "examId": examId,
//   //       "questionId": questions[i].questionId,
//   //       "answer": selectedOptions[i],
//   //       "timeSpent": currentQuestionStartTime,
//   //       // "timeSpent": timeSpentOnQuestions[i],
//   //     });
//   //   }
//   //   print(dataArray);
//   //   return (await APIService.postArrayDataToServer<Map<String, dynamic>?>(
//   //     endPoint: examSubmitEndPoint(examId: examId),
//   //     body: dataArray,
//   //     create: (dynamic json) {
//   //       return json;
//   //     },
//   //   ));
//   // }

//   void incrementSecondsElapsed() {
//     secondsElapsed.value++; // Increment the secondsElapsed variable
//   }

//   static List<Questions> fallbackQuestions = [
//     Questions(
//       question: "What is the capital of France?",
//       option1: "Paris",
//       option2: "London",
//       option3: "Berlin",
//       option4: "Madrid",
//     ),
//     Questions(
//       question: "What is the chemical symbol for water?",
//       option1: "H2O",
//       option2: "O2",
//       option3: "CO2",
//       option4: "H2",
//     ),
//     Questions(
//       question: "Who wrote 'To Kill a Mockingbird'?",
//       option1: "Harper Lee",
//       option2: "Mark Twain",
//       option3: "Ernest Hemingway",
//       option4: "F. Scott Fitzgerald",
//     ),
//     // Questions(
//     //   question: "Who wrote 'To Kill a Mockingbird2'?",
//     //   option1: "Harper Lee",
//     //   option2: "Mark Twain",
//     //   option3: "Ernest Hemingway",
//     //   option4: "F. Scott Fitzgerald",
//     // ),
//   ];
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:indrayani/module/exam_questions_module/exam_questions_data_model/exam_questions_data_model.dart';
import 'package:indrayani/module/score_module/screen/score_card_screen.dart';
import 'package:indrayani/utils/WebService/api_base_model.dart';
import 'package:indrayani/utils/WebService/api_config.dart';
import 'package:indrayani/utils/WebService/api_service.dart';
import 'package:indrayani/utils/WebService/end_points_constant.dart';
import 'package:indrayani/utils/initialization_services/singleton_service.dart';
import 'package:indrayani/utils/loader.dart';

class ExamQuestionsViewModel extends GetxController {
  // Rx<APIBaseModel<ExamQuestionsDataModel?>?> examQuestionsDataModel =
  //     APIBaseModel<ExamQuestionsDataModel?>().obs;
  Rx<APIBaseModel<ExamQuestionsDataModel?>?> examQuestionsDataModel =
      Rx<APIBaseModel<ExamQuestionsDataModel?>?>(
          APIBaseModel<ExamQuestionsDataModel?>());

  Rx<APIBaseModel<List<ExamQuestionsDataModel?>?>?> examQuestionsListDataModel =
      RxNullable<APIBaseModel<List<ExamQuestionsDataModel?>?>?>().setNull();

  // var isExamScreen = false.obs;
  var examCode = ''.obs;

  Rx<int> currentQuestionIndex = Rx<int>(0);
  RxInt examTime = 0.obs;
  var selectedOption = ''.obs;
  RxInt secondsElapsed = 0.obs; // Start from 0 seconds
  int currentQuestionStartTime = 0;
  List<int> timeSpentOnQuestions = [];
  // List<String?> selectedOptions = [];
  var selectedOptions = <int?>[].obs;
  var isExamSubmitted = false.obs;

  Rx<Timer?> timer = Rx<Timer?>(null);

  void selectOption(String? option) {
    selectedOption.value = option ?? '';
    selectedOptions[currentQuestionIndex.value] = selectedOption.value as int?;
  }

  // get exam questions list
  Future<APIBaseModel<ExamQuestionsDataModel?>?> getExamQuestionsList(
      {required String examCode, int? userId, int? resultId}) async {
    examQuestionsDataModel.value =
        await APIService.getDataFromServer<ExamQuestionsDataModel?>(
      endPoint: startExamEndPoint(examCode: examCode, resultId: resultId),
      create: (dynamic json) {
        try {
          return ExamQuestionsDataModel.fromJson(json);
        } catch (e) {
          debugPrint(e.toString());
          return null;
        }
      },
    );
    return examQuestionsDataModel.value;
  }

  Future<void> fetchExamQuestions() async {
    try {
      final result =
          await APIService.getDataFromServer<ExamQuestionsDataModel?>(
        endPoint: '', // Replace with actual endpoint
        create: (json) {
          try {
            return ExamQuestionsDataModel.fromJson(json);
          } catch (e) {
            print('Error parsing exam questions data: $e');
            return null;
          }
        },
      );

      if (result != null && result.responseBody != null) {
        examQuestionsDataModel.value = result;
        final questionsLength = result.responseBody?.questions?.length ?? 0;
        selectedOptions = RxList<int?>.filled(questionsLength, null);
        timeSpentOnQuestions = List<int>.filled(questionsLength, 0);
      } else {
        print('Fetched result or responseBody is null');
        examQuestionsDataModel.value =
            APIBaseModel<ExamQuestionsDataModel?>(); // Set a default value
      }
    } catch (e) {
      print('Error fetching exam questions: $e');
    }
  }

  Future<APIBaseModel<Map<String, dynamic>?>?> submitExamQustionAnswersList(
      {int? examId,
      int? resultId,
      String? examCode,
      String? attemptId,
      String? attemptDate,
      int? totalQuestions}) async {
    try {
      timer.value?.cancel();
      List<Map<String, dynamic>> answerSet = [];

      final questions = examQuestionsDataModel.value?.responseBody?.questions ??
          fallbackQuestions;
      final totalTimeTaken = timeSpentOnQuestions.isNotEmpty
          ? timeSpentOnQuestions.reduce((a, b) => a + b)
          : 0;

      for (int i = 0; i < questions.length; i++) {
        final timeInSeconds =
            (i < timeSpentOnQuestions.length) ? timeSpentOnQuestions[i] : 0;
        answerSet.add({
          "question_id": questions[i]?.questionId ?? 0,
          "time_taken": timeInSeconds,
          "seloption": (i < selectedOptions.length) ? selectedOptions[i] : null,
        });
      }

      Map<String, dynamic> requestBody = {
        "exam_code": examCode,
        "user_id": IndrayaniAppGLobal.instance.loginViewModel.loginDataModel
                ?.value?.responseBody?.userId ??
            0,
        "result_id": resultId,
        "time_taken": totalTimeTaken,
        "attemptDate": attemptDate,
        "total_questions": totalQuestions,
        "answerSet": answerSet,
      };

      return await APIService.postDataToServer<Map<String, dynamic>?>(
        endPoint: examSubmitEndPoint(),
        body: requestBody,
        create: (dynamic json) {
          return json;
        },
      );
    } catch (e) {
      print('Error submitting exam answers: $e');
      return null;
    }
  }

  Future<APIBaseModel<Map<String, dynamic>?>?> handleExamSubmission() async {
    if (isExamSubmitted.value) {
      return null; // Prevent duplicate submissions
    }

    isExamSubmitted.value = true; // Set the flag to true when submission starts

    try {
      final response = await submitExamQustionAnswersList(
        examCode: examQuestionsDataModel.value?.responseBody?.examCode,
        resultId: examQuestionsDataModel.value?.responseBody?.resultId,
        totalQuestions:
            examQuestionsDataModel.value?.responseBody?.totalQuestions,
      );

      if (response != null && response.status == true) {
        Get.off(ScoreCardScreen(
          examCode: examQuestionsDataModel.value?.responseBody?.examCode ?? "",
          resultId: examQuestionsDataModel.value?.responseBody?.resultId ?? 0,
        ));
      } else {
        Get.snackbar('Time is up', "Exam submitted successfully" ?? "");
        Get.off(ScoreCardScreen(
          examCode: examQuestionsDataModel.value?.responseBody?.examCode ?? "",
          resultId: examQuestionsDataModel.value?.responseBody?.resultId ?? 0,
        ));
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while submitting the exam.');
    }

    return null;
  }

  void resetExam() {
    currentQuestionIndex.value = 0;
    secondsElapsed.value = 0;
    currentQuestionStartTime = 0;
    timeSpentOnQuestions = List<int>.filled(
        examQuestionsDataModel.value?.responseBody?.questions?.length ?? 0,
        //fallbackQuestions.length,
        0);
    selectedOptions = RxList<int?>.filled(
        examQuestionsDataModel.value?.responseBody?.questions?.length ?? 0,
        // fallbackQuestions.length,
        null);
    isExamSubmitted.value = false;
  }

  void incrementSecondsElapsed() {
    secondsElapsed.value++; // Increment the secondsElapsed variable
  }

  static List<Questions> fallbackQuestions = [];
}
