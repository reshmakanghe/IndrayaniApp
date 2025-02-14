import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/category_module/model/category_data_model.dart';
import 'package:indrayani/module/category_module/view_model/category_view_model.dart';
import 'package:indrayani/module/category_module/screen/category_exam_list.dart';
import 'package:indrayani/module/home/screens/exam_details.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_app_bar.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/internet_connectivity.dart';
import 'package:indrayani/utils/loader.dart';

class CategoryScreen extends StatefulWidget {
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Categories> categories = [];
  List<Categories> filteredCategories = [];
  List<bool> expandedItems = [];
  final TextEditingController _searchController = TextEditingController();
  bool isApiFetched = false;
  List<Map<String, dynamic>> selectedExams = [];
  String searchQuery = '';
  CategoryViewModel categoryViewModel = Get.put(CategoryViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      showLoadingDialog();
      await fetchCategoryExams();
      hideLoadingDialog();
    });
    checkConnectivity();
  }

  Future<void> fetchCategoryExams() async {
    // Simulate API call or replace it with your actual API call
    await Future.delayed(
        const Duration(seconds: 2)); // Replace with actual API call

    // Static data for testing
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

    setState(() {
      CategoryDataModel dataModel = CategoryDataModel.fromJson(jsonResponse);
      categories = dataModel.categories!;
      filteredCategories = List.from(categories);
      expandedItems = List<bool>.filled(filteredCategories.length, false);
      isApiFetched = true;
    });
  }

  void clearSearch() {
    setState(() {
      _searchController.clear();
      filterCategories('');
    });
  }

  void filterCategories(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCategories = List.from(categories);
      } else {
        filteredCategories = categories
            .where((category) => category.categoryName!
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
      expandedItems = List<bool>.filled(filteredCategories.length, false);
    });
  }

  void navigateToCategoryExamList(String examCode, String examName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExamDetailsPage(
          examCode: examCode,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bodyBGColor,
        appBar: const CustomAppBar(
          containerText: "Exam Category",
          imagePath: "assets/Icon/about_exam_icon.png",
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: HeaderCurvedContainer(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 70.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.82,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                      ),
                    ),
                    child: TextFormField(
                      controller: _searchController,
                      onChanged: (value) {
                        filterCategories(value);
                      },
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10, top: 9),
                        suffixIcon: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 13, 38, 104),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.search),
                            color: Colors.white,
                            onPressed: () {
                              // Implement search functionality if needed
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 60),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 200,
                      child: Card(
                        elevation: 3,
                        color: Colors.white,
                        child: Obx(() {
                          var categoryDataModel =
                              categoryViewModel.categoryDataModel.value;
                          if (categoryDataModel == null ||
                              categoryDataModel.responseBody == null) {
                            if (categories.isEmpty) {
                              fetchCategoryExams(); // Ensure static data is available
                            }
                            return ListView.builder(
                              itemCount: filteredCategories.length,
                              itemBuilder: (context, index) {
                                var category = filteredCategories[index];
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Container(
                                        color:
                                            Color.fromARGB(255, 235, 177, 54),
                                        child: ExpansionTile(
                                          title: Text(
                                            category.categoryName ?? '',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          tilePadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 16.0),
                                          backgroundColor:
                                              Color.fromARGB(255, 235, 177, 54),
                                          collapsedBackgroundColor:
                                              Color.fromARGB(255, 235, 177, 54),
                                          shape: const RoundedRectangleBorder(
                                            side: BorderSide
                                                .none, // Removes the border color
                                          ),
                                          children:
                                              category.subcats!.map((subcat) {
                                            return Column(
                                              children: [
                                                SizedBox(
                                                    height: 8.0,
                                                    child: Container(
                                                        color: Colors.white)),
                                                Container(
                                                  color: Colors.yellow[100],
                                                  child: ExpansionTile(
                                                    title: Text(
                                                      subcat.categoryName ?? '',
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    leading: const Icon(
                                                        Icons.add,
                                                        color: Colors.black),
                                                    tilePadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 16.0),
                                                    backgroundColor:
                                                        Colors.yellow[100],
                                                    collapsedBackgroundColor:
                                                        Colors.yellow[200],
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide
                                                          .none, // Removes the border color
                                                    ),
                                                    children: subcat.exams!
                                                        .map((exam) {
                                                      return Container(
                                                        color: Colors.white,
                                                        child: ListTile(
                                                          title: Text(
                                                              exam.examName ??
                                                                  ''),
                                                          onTap: () {
                                                            navigateToCategoryExamList(
                                                                exam.examCode ??
                                                                    '',
                                                                exam.examName ??
                                                                    '');
                                                          },
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side: BorderSide
                                                                .none, // Removes the border color
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            // Check if categories are still empty, use static data if necessary
                            return const Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            );
                          }
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// Integrated Code:
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:indrayani/module/category_module/model/category_data_model.dart';
// import 'package:indrayani/module/category_module/view_model/category_view_model.dart';
// import 'package:indrayani/module/category_module/screen/category_exam_list.dart';
// import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_app_bar.dart';
// import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
// import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
// import 'package:indrayani/utils/internet_connectivity.dart';
// import 'package:indrayani/utils/loader.dart';

// class CategoryScreen extends StatefulWidget {
//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final CategoryViewModel categoryViewModel = Get.put(CategoryViewModel());
//   List<CategoryDataModel?> categories = [];
//   List<CategoryDataModel?> filteredCategories = [];
//   List<bool> expandedItems = [];
//   bool isApiFetched = false;
//   final Categories categorys = Get.put(Categories());
//   final Subcats subCats = Get.put(Subcats());
//   get selectedExams => null;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       showLoadingDialog();
//       await categoryViewModel.fetchCategoryExams();
//       hideLoadingDialog();
//       setState(() {
//         categories = categoryViewModel.categoryDataModel.value?.responseBody ?? [];
//         filteredCategories = List.from(categories);
//         expandedItems = List<bool>.filled(filteredCategories.length, false);
//         isApiFetched = true;
//       });
//     });
//     checkConnectivity();
//   }

//   void clearSearch() {
//     setState(() {
//       _searchController.clear();
//       filterCategories('');
//     });
//   }

//    void filterCategories(String query) {
//     setState(() {
//       if (query.isEmpty) {
//         filteredCategories = List.from(categories);
//       } else {
//         filteredCategories = categories
//             .where((category) =>
//                 categorys?.categoryName?.toLowerCase().contains(query.toLowerCase()) ?? false)
//             .toList();
//       }
//       expandedItems = List<bool>.filled(filteredCategories.length, false);
//     });
//   }

//   void navigateToCategoryExamList(String examCode, String examName) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CategoryExamListScreen(
//           selectedExams: selectedExams,
//           examCode: examCode,
//           examName: examName,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: bodyBGColor,
//         appBar: const CustomAppBar(
//           containerText: "Exam Category",
//           imagePath: "assets/Icon/about_exam_icon.png",
//         ),
//         body: Stack(
//           alignment: Alignment.center,
//           children: [
//             CustomPaint(
//               painter: HeaderCurvedContainer(),
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//               ),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.only(top: 70.0),
//                   child: Container(
//                     height: MediaQuery.of(context).size.height * 0.06,
//                     width: MediaQuery.of(context).size.width * 0.82,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(
//                         width: 1,
//                       ),
//                     ),
//                     child: TextFormField(
//                       controller: _searchController,
//                       onChanged: (value) {
//                         filterCategories(value);
//                       },
//                       decoration: InputDecoration(
//                         hintText: "Search",
//                         border: InputBorder.none,
//                         contentPadding: EdgeInsets.only(left: 10, top: 9),
//                         suffixIcon: Container(
//                           decoration: BoxDecoration(
//                             color: Color.fromARGB(255, 13, 38, 104),
//                           ),
//                           child: IconButton(
//                             icon: Icon(Icons.search),
//                             color: Colors.white,
//                             onPressed: () {
//                               // Implement search functionality if needed
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Obx(() {
//                   if (categoryViewModel.categoryDataModel.value?.responseBody == null) {
//                     return const Center(
//                       child: CircularProgressIndicator(
//                         color: primaryColor,
//                       ),
//                     );
//                   } else {
//                     return Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 8.0, bottom: 60),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width * 0.9,
//                           height: 200,
//                           child: Card(
//                             elevation: 3,
//                             color: Colors.white,
//                             child: ListView.builder(
//                               itemCount: filteredCategories.length,
//                               itemBuilder: (context, index) {
//                                 var category = filteredCategories[index];
//                                 return Column(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 8.0),
//                                       child: Container(
//                                         color: Color.fromARGB(255, 235, 177, 54),
//                                         child: ExpansionTile(
//                                           title: Text(
//                                             categorys?.categoryName ?? '',
//                                             style: TextStyle(color: Colors.black),
//                                           ),
//                                           tilePadding: EdgeInsets.symmetric(horizontal: 16.0),
//                                           backgroundColor: Color.fromARGB(255, 235, 177, 54),
//                                           collapsedBackgroundColor: Color.fromARGB(255, 235, 177, 54),
//                                           children: categorys?.subcats?.map((subcat) {
//                                             return Column(
//                                               children: [
//                                                 SizedBox(
//                                                   height: 8.0,
//                                                   child: Container(color: Colors.white),
//                                                 ),
//                                                 Container(
//                                                   color: Colors.yellow[100],
//                                                   child: ExpansionTile(
//                                                     title: Text(
//                                                       subcat.categoryName ?? '',
//                                                       style: TextStyle(color: Colors.black),
//                                                     ),
//                                                     leading: Icon(Icons.add, color: Colors.black),
//                                                     tilePadding: EdgeInsets.symmetric(horizontal: 16.0),
//                                                     backgroundColor: Colors.yellow[100],
//                                                     collapsedBackgroundColor: Colors.yellow[200],
//                                                     children: subcat.exams?.map((exam) {
//                                                       return Container(
//                                                         color: Colors.white,
//                                                         child: ListTile(
//                                                           title: Text(exam.examName ?? ''),
//                                                           onTap: () {
//                                                             navigateToCategoryExamList(
//                                                               exam.examCode ?? '',
//                                                               exam.examName ?? '',
//                                                             );
//                                                           },
//                                                         ),
//                                                       );
//                                                     }).toList() ?? [],
//                                                   ),
//                                                 ),
//                                               ],
//                                             );
//                                           }).toList() ?? [],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }
//                 }),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:indrayani/module/category_module/model/category_data_model.dart';
// import 'package:indrayani/module/category_module/view_model/category_view_model.dart';
// import 'package:indrayani/module/category_module/screen/category_exam_list.dart';
// import 'package:indrayani/module/home/screens/exam_details.dart';
// import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_app_bar.dart';
// import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
// import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
// import 'package:indrayani/utils/internet_connectivity.dart';
// import 'package:indrayani/utils/loader.dart';

// class CategoryScreen extends StatefulWidget {
//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final CategoryViewModel categoryViewModel = Get.put(CategoryViewModel());
//   List<CategoryDataModel?> categories = [];
//   List<CategoryDataModel?> filteredCategories = [];
//   List<bool> expandedItems = [];
//   bool isApiFetched = false;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       showLoadingDialog();
//       await categoryViewModel.fetchCategoryExams();
//       hideLoadingDialog();
//       setState(() {
//         categories = categoryViewModel.categoryDataModel.value?.responseBody ?? [];
//         filteredCategories = List.from(categories);
//         expandedItems = List<bool>.filled(filteredCategories.length, false);
//         isApiFetched = true;
//       });
//     });
//     checkConnectivity();
//   }

//   // void clearSearch() {
//   //   setState(() {
//   //     _searchController.clear();
//   //     filterCategories('');
//   //   });
//   // }

//   void filterCategories(String query) {
//     setState(() {
//       if (query.isEmpty) {
//         filteredCategories = List.from(categories);
//       } else {
//         filteredCategories = categories
//             .where((category) =>
//                 category?.categories?.any((cat) =>
//                     cat.categoryName?.toLowerCase().contains(query.toLowerCase()) ?? false) ?? false)
//             .toList();
//       }
//       expandedItems = List<bool>.filled(filteredCategories.length, false);
//     });
//   }

//   void navigateToCategoryExamList(String examCode, String examName, List<Map<String, dynamic>> selectedExams) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ExamDetailsPage(
//          examCode: examCode,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: bodyBGColor,
//         appBar: const CustomAppBar(
//           containerText: "Exam Category",
//           imagePath: "assets/Icon/about_exam_icon.png",
//         ),
//         body: Stack(
//           alignment: Alignment.center,
//           children: [
//             CustomPaint(
//               painter: HeaderCurvedContainer(),
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//               ),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.only(top: 70.0),
//                   child: Container(
//                     height: MediaQuery.of(context).size.height * 0.06,
//                     width: MediaQuery.of(context).size.width * 0.82,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(
//                         width: 1,
//                       ),
//                     ),
//                     child: TextFormField(
//                       controller: _searchController,
//                       onChanged: (value) {
//                         filterCategories(value);
//                       },
//                       decoration: InputDecoration(
//                         hintText: "Search",
//                         border: InputBorder.none,
//                         contentPadding: EdgeInsets.only(left: 10, top: 9),
//                         suffixIcon: Container(
//                           decoration: BoxDecoration(
//                             color: Color.fromARGB(255, 13, 38, 104),
//                           ),
//                           child: IconButton(
//                             icon: Icon(Icons.search),
//                             color: Colors.white,
//                             onPressed: () {
//                               // Implement search functionality if needed
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Obx(() {
//                   if (categoryViewModel.categoryDataModel.value?.responseBody == null) {
//                     return const Center(
//                       child: CircularProgressIndicator(
//                         color: primaryColor,
//                       ),
//                     );
//                   } else {
//                     return Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 8.0, bottom: 60),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width * 0.9,
//                           height: 200,
//                           child: Card(
//                             elevation: 3,
//                             color: Colors.white,
//                             child: ListView.builder(
//                               itemCount: filteredCategories.length,
//                               itemBuilder: (context, index) {
//                                 var categoryData = filteredCategories[index];
//                                 return Column(
//                                   children: categoryData?.categories?.map((category) {
//                                     return Padding(
//                                       padding: const EdgeInsets.only(top: 8.0),
//                                       child: Container(
//                                         color: Color.fromARGB(255, 235, 177, 54),
//                                         child: ExpansionTile(
//                                           title: Text(
//                                             category.categoryName ?? '',
//                                             style: TextStyle(color: Colors.black),
//                                           ),
//                                           tilePadding: EdgeInsets.symmetric(horizontal: 16.0),
//                                           backgroundColor: Color.fromARGB(255, 235, 177, 54),
//                                           collapsedBackgroundColor: Color.fromARGB(255, 235, 177, 54),
//                                           children: category.subcats?.map((subcat) {
//                                             return Column(
//                                               children: [
//                                                 SizedBox(
//                                                   height: 8.0,
//                                                   child: Container(color: Colors.white),
//                                                 ),
//                                                 Container(
//                                                   color: Colors.yellow[100],
//                                                   child: ExpansionTile(
//                                                     title: Text(
//                                                       subcat.categoryName ?? '',
//                                                       style: TextStyle(color: Colors.black),
//                                                     ),
//                                                     leading: Icon(Icons.add, color: Colors.black),
//                                                     tilePadding: EdgeInsets.symmetric(horizontal: 16.0),
//                                                     backgroundColor: Colors.yellow[100],
//                                                     collapsedBackgroundColor: Colors.yellow[200],
//                                                     children: subcat.exams?.map((exam) {
//                                                       return Container(
//                                                         color: Colors.white,
//                                                         child: ListTile(
//                                                           title: Text(exam.examName ?? ''),
//                                                           onTap: () {
//                                                             navigateToCategoryExamList(
//                                                               exam.examCode ?? '',
//                                                               exam.examName ?? '',
//                                                               subcat.exams!.map((e) => {
//                                                                 'exam_code': e.examCode,
//                                                                 'exam_name': e.examName,
//                                                                 'exam_image': e.examImage,
//                                                               }).toList(),
//                                                             );
//                                                           },
//                                                         ),
//                                                       );
//                                                     }).toList() ?? [],
//                                                   ),
//                                                 ),
//                                               ],
//                                             );
//                                           }).toList() ?? [],
//                                         ),
//                                       ),
//                                     );
//                                   }).toList() ?? [],
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }
//                 }),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:indrayani/module/category_module/model/category_data_model.dart';
// import 'package:indrayani/module/category_module/view_model/category_view_model.dart';
// import 'package:indrayani/module/home/screens/exam_details.dart';
// import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_app_bar.dart';
// import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
// import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
// import 'package:indrayani/utils/internet_connectivity.dart';
// import 'package:indrayani/utils/loader.dart';

// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen({super.key});

//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   CategoryViewModel categoryViewModel= Get.put(CategoryViewModel());
//   @override
//  void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       showLoadingDialog();
//       await categoryViewModel.fetchCategoryExams();
//       hideLoadingDialog();
//     });
//     super.initState();
//     checkConnectivity();
//  }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: bodyBGColor,
//         appBar: const CustomAppBar(
//           containerText: "Exam Category",
//           imagePath: "assets/Icon/about_exam_icon.png",
//         ),
//         body: Stack(
//           alignment: Alignment.center,
//           children: [
//             CustomPaint(
//               painter: HeaderCurvedContainer(),
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//               ),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.only(top: 70.0),
//                   child: Container(
//                     height: MediaQuery.of(context).size.height * 0.06,
//                     width: MediaQuery.of(context).size.width * 0.82,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(
//                         width: 1,
//                       ),
//                     ),
//                     child: TextFormField(
//                       controller: categoryViewModel.searchController,
//                       onChanged: (value) {
//                         categoryViewModel.filterCategories(value);
//                       },
//                       decoration: InputDecoration(
//                         hintText: "Search",
//                         border: InputBorder.none,
//                         contentPadding: EdgeInsets.only(left: 10, top: 9),
//                         suffixIcon: Container(
//                           decoration: BoxDecoration(
//                             color: Color.fromARGB(255, 13, 38, 104),
//                           ),
//                           child: IconButton(
//                             icon: Icon(Icons.search),
//                             color: Colors.white,
//                             onPressed: () {
//                               // Implement search functionality if needed
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Obx(() {
//                   final categoryData = categoryViewModel.categoryDataModel.value;

//                   if (categoryData == null) {
//                     return const Center(
//                       child: CircularProgressIndicator(
//                         color: primaryColor,
//                       ),
//                     );
//                   } else {
//                     List<CategoryDataModel?> filteredCategories = categoryViewModel.filteredCategories;
//                     return Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 8.0, bottom: 60),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width * 0.9,
//                           height: 200,
//                           child: Card(
//                             elevation: 3,
//                             color: Colors.white,
//                             child: ListView.builder(
//                               itemCount: filteredCategories.length,
//                               itemBuilder: (context, index) {
//                                 var categoryData = filteredCategories[index];
//                                 return Column(
//                                   children: categoryData?.categories?.map((category) {
//                                     return Padding(
//                                       padding: const EdgeInsets.only(top: 8.0),
//                                       child: Container(
//                                         color: Color.fromARGB(255, 235, 177, 54),
//                                         child: ExpansionTile(
//                                           title: Text(
//                                             category.categoryName ?? '',
//                                             style: TextStyle(color: Colors.black),
//                                           ),
//                                           tilePadding: EdgeInsets.symmetric(horizontal: 16.0),
//                                           backgroundColor: Color.fromARGB(255, 235, 177, 54),
//                                           collapsedBackgroundColor: Color.fromARGB(255, 235, 177, 54),
//                                           children: category.subcats?.map((subcat) {
//                                             return Column(
//                                               children: [
//                                                 SizedBox(
//                                                   height: 8.0,
//                                                   child: Container(color: Colors.white),
//                                                 ),
//                                                 Container(
//                                                   color: Colors.yellow[100],
//                                                   child: ExpansionTile(
//                                                     title: Text(
//                                                       subcat.categoryName ?? '',
//                                                       style: TextStyle(color: Colors.black),
//                                                     ),
//                                                     leading: Icon(Icons.add, color: Colors.black),
//                                                     tilePadding: EdgeInsets.symmetric(horizontal: 16.0),
//                                                     backgroundColor: Colors.yellow[100],
//                                                     collapsedBackgroundColor: Colors.yellow[200],
//                                                     children: subcat.exams?.map((exam) {
//                                                       return Container(
//                                                         color: Colors.white,
//                                                         child: ListTile(
//                                                           title: Text(exam.examName ?? ''),
//                                                           onTap: () {
//                                                              Navigator.of(context).push(MaterialPageRoute(
//                                                               builder: (context) => ExamDetailsPage(
//                                                                 examCode:exam.examCode ?? "JE01",
//                                                               ),
//                                                             ));
//                                                           },
//                                                         ),
//                                                       );
//                                                     }).toList() ?? [],
//                                                   ),
//                                                 ),
//                                               ],
//                                             );
//                                           }).toList() ?? [],
//                                         ),
//                                       ),
//                                     );
//                                   }).toList() ?? [],
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }
//                 }),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// }
