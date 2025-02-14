import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:indrayani/module/exam_questions_module/exam_questions_data_model/exam_questions_data_model.dart';
import 'package:indrayani/module/review_questions_module/model/review_question_data_model.dart';
import 'package:indrayani/utils/WebService/api_base_model.dart';
import 'package:indrayani/utils/WebService/api_config.dart';
import 'package:indrayani/utils/WebService/api_service.dart';
import 'package:indrayani/utils/WebService/end_points_constant.dart';

class ReviewQuestionViewModel extends GetxController {
  Rx<APIBaseModel<List<ReviewQuestionDataModel?>?>?> reviewQuestionsDataModel =
      RxNullable<APIBaseModel<List<ReviewQuestionDataModel?>?>?>().setNull();

  //get exam questions list
  Future<APIBaseModel<List<ReviewQuestionDataModel?>?>?> getReviewQuestionList(
      {String? examCode, int? resultId}) async {
    reviewQuestionsDataModel.value =
        await APIService.getDataFromServer<List<ReviewQuestionDataModel?>?>(
      endPoint:
          reviewQuestionListEndPoint(examCode: examCode, resultId: resultId),
      create: (dynamic json) {
        try {
          return (json as List)
              .map((e) => ReviewQuestionDataModel.fromJson(e))
              .toList();
        } catch (e) {
          debugPrint(e.toString());
          return null;
        }
      },
    );
    return reviewQuestionsDataModel.value;
  }

  //get exam questions

  //post exam questions with answer

  static List<ReviewQuestionDataModel> fallbackQuestions = [
    ReviewQuestionDataModel(
        //   queId: 1,
        //   question:
        //       "What is the capital of France?\nWhat is the capital of FranceWhat is the capital of FranceWhat is the capital of FranceWhat is the capital of France",
        //   option1: "Paris",
        //   option2: "London",
        //   option3: "Berlin",
        //   option4: "Madrid",
        //   rightOption: 1,
        //   userAnswer: 1,
        //   userScore: null,
        // ),
        // ReviewQuestionDataModel(
        //   queId: 2,
        //   question: "What is the chemical symbol for water?",
        //   option1: "H2O",
        //   option2: "O2",
        //   option3: "CO2",
        //   option4: "H2",
        //   rightOption: 2,
        //   userAnswer: 2,
        //   userScore: null,
        // ),
        // ReviewQuestionDataModel(
        //   queId: 3,
        //   question: "Who wrote 'To Kill a Mockingbird'?",
        //   option1: "Harper Lee",
        //   option2: "Mark Twain",
        //   option3: "Ernest Hemingway",
        //   option4: "F. Scott Fitzgerald",
        //   rightOption: 2,
        //   userAnswer: 1,
        //   userScore: null,
        // ),
        // ReviewQuestionDataModel(
        //   queId: 4,
        //   question:
        //       "Who wrote 'To Kill a Mockingbird2 Who wrote 'To Kill a Mockingbird2'Who wrote 'To Kill a Mockingbird2''?",
        //   option1: "Harper Lee",
        //   option2: "Mark Twain",
        //   option3:
        //       "Ernest HemingwayErnest HemingwayErnest HemingwayErnest HemingwayErnest HemingwayErnest HemingwayErnest HemingwayErnest Hemingway",
        //   option4: "F. Scott Fitzgerald",
        //   rightOption: 1,
        //   userAnswer: 2,
        //   userScore: null,
        ),
  ];
}
