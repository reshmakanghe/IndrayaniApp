import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/exam_list_module/model/exam_list_data_model.dart';
import 'package:indrayani/utils/WebService/api_base_model.dart';
import 'package:indrayani/utils/WebService/api_config.dart';
import 'package:indrayani/utils/WebService/api_service.dart';

class ExamViewModel extends GetxController {
  Rx<APIBaseModel<ExamDataModel?>?>? examDataModel =
      RxNullable<APIBaseModel<ExamDataModel?>?>().setNull();

  Rx<APIBaseModel<List<ExamDataModel?>?>?>? examListDataModel =
      RxNullable<APIBaseModel<List<ExamDataModel?>?>?>().setNull();

  TextEditingController examCodeController = TextEditingController();
  TextEditingController examNameController = TextEditingController();
  TextEditingController examImageController = TextEditingController();
  TextEditingController examTypeController = TextEditingController();
  TextEditingController difficultyLevelController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController optedOnController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController totalMarksController = TextEditingController();
  TextEditingController totalQuestionController = TextEditingController();
  TextEditingController marksForCorrectAnswerController =
      TextEditingController();
  TextEditingController negativeMarkingForIncorrectAnswerController =
      TextEditingController();
  TextEditingController negativeMarkingForUnattemptedQuestionController =
      TextEditingController();
  TextEditingController passingPercentageController = TextEditingController();

  Future<APIBaseModel<ExamDataModel?>?> getExamDetails(int? examId) async {
    examDataModel?.value = await APIService.getDataFromServer<ExamDataModel?>(
      endPoint: '', // Exam details endpoint (replace with actual endpoint)
      create: (dynamic json) {
        try {
          return ExamDataModel.fromJson(json);
        } catch (e) {
          debugPrint(e.toString());
          return null;
        }
      },
    );
    return examDataModel?.value;
  }

  Future<APIBaseModel<List<ExamDataModel?>?>?> getExamList() async {
    examListDataModel?.value = await APIService
        .getDataFromServerWithoutErrorModel<List<ExamDataModel?>?>(
      endPoint: '', // Exam list endpoint (replace with actual endpoint)
      create: (dynamic json) {
        try {
          List<ExamDataModel?> dataList = (json as List).map((element) {
            return ExamDataModel.fromJson(element);
          }).toList();
          return dataList;
        } catch (e) {
          debugPrint(e.toString());
          return null;
        }
      },
    );
    return examListDataModel?.value;
  }

  Future<APIBaseModel<Map<String, dynamic>?>?> updateExamDetails() async {
    return await APIService.patchDataToServer<Map<String, dynamic>>(
      endPoint:
          '', // Update exam details endpoint (replace with actual endpoint)
      body: {
        "exam_id": examDataModel?.value?.responseBody?.examId ?? 0,
        "exam_code": examCodeController.text,
        "exam_name": examNameController.text,
        "exam_image": examImageController.text,
        "exam_type": examTypeController.text,
        "difficulty_level": difficultyLevelController.text,
        "description": descriptionController.text,
        "price": int.tryParse(priceController.text) ?? 0,
        "opted_on": optedOnController.text,
        "end_date": endDateController.text,
        "duration": durationController.text,
        "total_marks": totalMarksController.text,
        "total_questions": int.tryParse(totalQuestionController.text) ?? 0,
        "marks_for_correct_answer":
            int.tryParse(marksForCorrectAnswerController.text) ?? 0,
        "negative_marking_for_incorrect_answer":
            int.tryParse(negativeMarkingForIncorrectAnswerController.text) ?? 0,
        "negative_marking_for_unattempted_question": int.tryParse(
                negativeMarkingForUnattemptedQuestionController.text) ??
            0,
        "passing_percentage": passingPercentageController.text,
      },
      create: (dynamic json) {
        return json;
      },
    );
  }
}
