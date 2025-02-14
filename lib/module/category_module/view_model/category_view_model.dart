import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/category_module/model/category_data_model.dart';
import 'package:indrayani/utils/WebService/api_base_model.dart';
import 'package:indrayani/utils/WebService/api_service.dart';
import 'package:indrayani/utils/WebService/end_points_constant.dart';

class CategoryViewModel extends GetxController {
  Rx<APIBaseModel<List<CategoryDataModel>>> categoryDataModel =
      Rx<APIBaseModel<List<CategoryDataModel>>>(
          APIBaseModel(status: true, message: '', responseBody: []));
  Rx<List<CategoryDataModel>?> categoryExamModels =
      Rx<List<CategoryDataModel>?>(null);
  Rx<List<CategoryDataModel>?> filteredCategoryExamModels =
      Rx<List<CategoryDataModel>?>(null);
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryExams();
  }

  Future<void> fetchCategoryExams() async {
    try {
      final response = await APIService.getDataFromServerWithoutErrorModel<
          List<CategoryDataModel>>(
        endPoint: categoryExamEndPoint,
        create: (dynamic json) {
          try {
            // Wrap the `json` in a list if it's not already in one
            final List<dynamic> jsonData = json is List ? json : [json];
            return jsonData.map((e) => CategoryDataModel.fromJson(e)).toList();
          } catch (e) {
            return [];
          }
        },
      );

      categoryDataModel.value = response!;
      categoryExamModels.value = response.responseBody;
      filteredCategoryExamModels.value = categoryExamModels.value;
    } catch (e) {
      // Handle error and assign static data if needed
      categoryExamModels.value = _getStaticData();
      filteredCategoryExamModels.value = categoryExamModels.value;
    } finally {
      isLoading.value = false;
    }
  }

  void searchCategories(String query) {
    if (query.isEmpty) {
      filteredCategoryExamModels.value = categoryExamModels.value;
    } else {
      filteredCategoryExamModels.value =
          categoryExamModels.value?.map((dataModel) {
        var filteredCategories = dataModel.categories?.where((category) {
          return category.categoryName!
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              category.subcats!.any((subcat) {
                return subcat.categoryName!
                        .toLowerCase()
                        .contains(query.toLowerCase()) ||
                    subcat.exams!.any((exam) {
                      return exam.examName!
                          .toLowerCase()
                          .contains(query.toLowerCase());
                    });
              });
        }).toList();
        return CategoryDataModel(categories: filteredCategories);
      }).toList();
    }
  }

  void clearSearch() {
    filteredCategoryExamModels.value = categoryExamModels.value;
  }

  List<CategoryDataModel> _getStaticData() {
    final jsonResponse = {
      "categories": [
        {
          "category_id": 1,
          "category_name": "MPSC",
          "subcats": [
            {
              "category_id": 2,
              "category_name": "Assc P C",
              "exams": [
                {
                  "exam_code": "CE001",
                  "exam_name": "JEE",
                  "exam_image": "assets/images/jee.jpg"
                },
                {
                  "exam_code": "SW002",
                  "exam_name": "NEET",
                  "exam_image": "assets/exams/MPSC_PSI_Exam.png"
                }
              ]
            },
            {
              "category_id": 3,
              "category_name": "PSI",
              "exams": [
                {
                  "exam_code": "CE002",
                  "exam_name": "MHCET",
                  "exam_image": "assets/exams/MPSC_PSI_Exam.png"
                },
                {
                  "exam_code": "SW004",
                  "exam_name": "PSI",
                  "exam_image": "assets/exams/MPSC_PSI_Exam.png"
                }
              ]
            }
          ]
        },
        {
          "category_id": 4,
          "category_name": "UPSC",
          "subcats": [
            {
              "category_id": 5,
              "category_name": "Collector",
              "exams": [
                {
                  "exam_code": "CE001",
                  "exam_name": "NIT",
                  "exam_image": "assets/exams/MPSC_PSI_Exam.png"
                },
                {
                  "exam_code": "SW002",
                  "exam_name": "SCI",
                  "exam_image": "assets/exams/MPSC_PSI_Exam.png"
                }
              ]
            },
            {
              "category_id": 6,
              "category_name": "RPC",
              "exams": [
                {
                  "exam_code": "CE002",
                  "exam_name": "JET",
                  "exam_image": "assets/exams/MPSC_PSI_Exam.png"
                },
                {
                  "exam_code": "SW004",
                  "exam_name": "GATE",
                  "exam_image": "assets/exams/MPSC_PSI_Exam.png"
                }
              ]
            }
          ]
        }
      ]
    };
    return [CategoryDataModel.fromJson(jsonResponse)];
  }
}
