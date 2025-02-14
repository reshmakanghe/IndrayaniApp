// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:indrayani/module/Cart/view_model/exam_cart_view_model.dart';
// // import 'package:indrayani/module/home/model/home_data_model.dart';
// // import 'package:indrayani/module/home/view_model/home_view_model.dart';
// // import 'package:indrayani/utils/common_widgets/custom_app_bar.dart';
// // import 'package:indrayani/utils/common_widgets/exam_card.dart';
// // import 'package:indrayani/utils/common_widgets/header_curved_container.dart';
// // import 'package:indrayani/utils/common_widgets/home_custom_app_bar.dart';
// // import 'package:indrayani/utils/common_widgets/user_drawer.dart';
// // import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
// // import 'package:indrayani/utils/internet_connectivity.dart';
// // import 'package:indrayani/utils/internet_connectivity/internet_connectivity.dart';
// // import 'package:indrayani/utils/loader.dart';
// // import 'package:indrayani/utils/widgetConstant/common_widget/common_widget.dart';
// // import 'package:pinput/pinput.dart';

// // class HomeScreen extends StatefulWidget {
// //   @override
// //   _HomeScreenState createState() => _HomeScreenState();
// // }

// // class _HomeScreenState extends State<HomeScreen> {
// //   bool isTrendingSelected = true;
// //   CartViewModel cartViewModel = Get.put(CartViewModel());
// //   HomeDataViewModel homeDataViewModel = Get.put(HomeDataViewModel());

// //   final List<Map<String, dynamic>> trendingExams = [
// //     {
// //       "examName": "JEE",
// //       "dificultyLevel": "Hard",
// //       "examCode": "JE01",
// //       "price": 1200,
// //       "imageUrl": "assets/exams/MPSC_PSI_Exam.png",
// //       "enddate": "2025-02-23",
// //       "startDate": "2024-09-23"
// //     },
// //     {
// //       "examName": "NEET",
// //       "dificultyLevel": "Medium",
// //       "examCode": "NE01",
// //       "price": 1000,
// //       "imageUrl": "assets/exams/MPSC_PSI_Exam.png",
// //       "enddate": "2025-02-23",
// //       "startDate": "2024-09-23"
// //     },
// //     {
// //       "examName": "NEET",
// //       "dificultyLevel": "Medium",
// //       "examCode": "NE01",
// //       "price": 1000,
// //       "imageUrl": "assets/exams/MPSC_PSI_Exam.png",
// //     },
// //     {
// //       "examName": "NEET",
// //       "dificultyLevel": "Medium",
// //       "examCode": "NE01",
// //       "price": 1000,
// //       "imageUrl": "assets/exams/MPSC_PSI_Exam.png"
// //     },
// //     {
// //       "examName": "NEET",
// //       "dificultyLevel": "Medium",
// //       "examCode": "NE01",
// //       "price": 1000,
// //       "imageUrl": "assets/exams/MPSC_PSI_Exam.png",
// //       "enddate": "2025-02-23",
// //       "startDate": "2024-09-23"
// //     },
// //     {
// //       "examName": "NEET",
// //       "dificultyLevel": "Medium",
// //       "enddate": "2025-02-23",
// //       "startDate": "2024-09-23",
// //       "examCode": "NE01",
// //       "price": 1000,
// //       "imageUrl": "assets/exams/MPSC_PSI_Exam.png"
// //     },
// //     {
// //       "examName": "NEET",
// //       "dificultyLevel": "Medium",
// //       "examCode": "NE01",
// //       "price": 1000,
// //       "imageUrl": "assets/exams/MPSC_PSI_Exam.png",
// //       "enddate": "2025-02-23",
// //       "startDate": "2024-09-23"
// //     },
// //     {
// //       "examName": "NEET",
// //       "dificultyLevel": "Medium",
// //       "examCode": "NE01",
// //       "price": 1000,
// //       "imageUrl": "assets/exams/MPSC_PSI_Exam.png",
// //       "enddate": "2025-02-23",
// //       "startDate": "2024-09-23"
// //     },
// //     {
// //       "examName": "JEE",
// //       "dificultyLevel": "Hard",
// //       "examCode": "JE01",
// //       "price": 1200,
// //       "imageUrl": "assets/exams/MPSC_PSI_Exam.png",
// //       "enddate": "2025-02-23",
// //       "startDate": "2024-09-23"
// //     },
// //     {
// //       "examName": "JEE",
// //       "dificultyLevel": "Hard",
// //       "examCode": "JE01",
// //       "price": 1200,
// //       "imageUrl": "assets/exams/MPSC_PSI_Exam.png",
// //       "enddate": "2025-02-23",
// //       "startDate": "2024-09-23"
// //     },
// //     {
// //       "examName": "JEE",
// //       "dificultyLevel": "Hard",
// //       "examCode": "JE01",
// //       "price": 1200,
// //       "imageUrl": "assets/exams/MPSC_PSI_Exam.png",
// //     },
// //   ];

// //   void toggleButtonState(bool isTrending) {
// //     setState(() {
// //       isTrendingSelected = isTrending;
// //     });
// //   }

// //   @override
// //   void initState() {
// //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
// //       showLoadingDialog();
// //       await homeDataViewModel.getTrendingExamList();
// //       hideLoadingDialog();
// //       showLoadingDialog();
// //       await homeDataViewModel.getUpcomingExamList();
// //       hideLoadingDialog();
// //     });

// //     super.initState();
// //     checkConnectivity();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: InternetAwareWidget(
// //         child: Scaffold(
// //           backgroundColor: bodyBGColor,
// //           appBar: const HomeCustomAppBar(
// //             containerText: "EXAMS",
// //             imagePath: "assets/images/Logo/logo100x100.png",
// //           ),
// //           drawer: const UserDrawer(),
// //           body: Stack(
// //             alignment: Alignment.center,
// //             children: [
// //               CustomPaint(
// //                 painter: HeaderCurvedContainer(),
// //                 child: SizedBox(
// //                   width: MediaQuery.of(context).size.width,
// //                   height: MediaQuery.of(context).size.height,
// //                 ),
// //               ),
// //               SingleChildScrollView(
// //                 child: Column(
// //                   children: [
// //                     Container(
// //                       width: MediaQuery.of(context).size.width,
// //                       height: MediaQuery.of(context).size.height,
// //                       padding: const EdgeInsets.all(10.0),
// //                       child: ListView.builder(
// //                         itemCount: trendingExams.length,
// //                         itemBuilder: (context, index) {
// //                           final exam = trendingExams[index];
// //                           return ExamCard(
// //                             examName: exam['examName'],
// //                             dificultyLevel: exam['dificultyLevel'],
// //                             id: exam['id'],
// //                             price: exam['price'],
// //                             imageUrl: exam['imageUrl'],
// //                             endDate: exam['e'],
// //                           );
// //                         },
// //                         //API Call
// //                         // itemCount: homeDataViewModel.examListDataModel.value
// //                         //         ?.responseBody?.length ??
// //                         //     0,
// //                         // itemBuilder: (context, index) {
// //                         //   final exam = homeDataViewModel
// //                         //       .examListDataModel.value?.responseBody?[index];
// //                         //   return SizedBox(
// //                         //     // Set the height you want for each card
// //                         //     child: ExamCard(
// //                         //       examName: exam?.examName,
// //                         //       dificultyLevel: exam?.dificultyLevel,
// //                         //       id: exam?.examCode,
// //                         //       price: exam?.price,
// //                         //       imageUrl: exam?.examImage,
// //                         //     ),
// //                         //   );
// //                         // },
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:indrayani/module/Cart/view_model/exam_cart_view_model.dart';
// import 'package:indrayani/module/home/model/home_data_model.dart';
// import 'package:indrayani/module/home/view_model/home_view_model.dart';
// import 'package:indrayani/module/home/view_model/toggle_button_view_controller.dart';
// import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_app_bar.dart';
// import 'package:indrayani/utils/exam_card.dart';
// import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
// import 'package:indrayani/utils/common_widgets/app%20bar%20widget/home_custom_app_bar.dart';
// import 'package:indrayani/utils/common_widgets/user_drawer.dart';
// import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
// import 'package:indrayani/utils/internet_connectivity.dart';
// import 'package:indrayani/utils/internet_connectivity/internet_connectivity.dart';
// import 'package:indrayani/utils/loader.dart';
// import 'package:pinput/pinput.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final CartViewModel cartViewModel = Get.put(CartViewModel());

//   final HomeDataViewModel homeDataViewModel = Get.put(HomeDataViewModel());

//   final ToggleButtonsController toggleButtonsController =
//       Get.put(ToggleButtonsController());

//   final List<Map<String, dynamic>> trendingExams = [
//     {
//       "examName": "JEE",
//       "dificultyLevel": "Hard",
//       "examCode": "JE01",
//       "price": 1200,
//       "imageUrl": "assets/exams/MPSC_PSI_Exam.png",
//       "enddate": "2025-02-23",
//       "startDate": "2024-09-23"
//     },
//     {
//       "examName": "NEET",
//       "dificultyLevel": "Medium",
//       "examCode": "NE01",
//       "price": 1000,
//       "imageUrl": "assets/exams/MPSC_PSI_Exam.png",
//       "enddate": "2025-02-23",
//       "startDate": "2024-09-23"
//     },
//     {
//       "examName": "MHCET",
//       "dificultyLevel": "Medium",
//       "examCode": "NE01",
//       "price": 1000,
//       "imageUrl": "assets/exams/MPSC_PSI_Exam.png",
//     },
//     {
//       "examName": "PSI",
//       "dificultyLevel": "Medium",
//       "examCode": "PSI",
//       "price": 1000,
//       "imageUrl": "assets/exams/MPSC_PSI_Exam.png"
//     },
//     {
//       "examName": "NIT",
//       "dificultyLevel": "Medium",
//       "examCode": "NIT",
//       "price": 1000,
//       "imageUrl": "assets/exams/MPSC_PSI_Exam.png",
//       "enddate": "2025-02-23",
//       "startDate": "2024-09-23"
//     },
//     {
//       "examName": "SCI",
//       "dificultyLevel": "Medium",
//       "enddate": "2025-02-23",
//       "startDate": "2024-09-23",
//       "examCode": "SCI",
//       "price": 1000,
//       "imageUrl": "assets/exams/MPSC_PSI_Exam.png"
//     },
//     {
//       "examName": "JET",
//       "dificultyLevel": "Medium",
//       "examCode": "JET",
//       "price": 1000,
//       "imageUrl": "assets/exams/MPSC_PSI_Exam.png",
//       "enddate": "2025-02-23",
//       "startDate": "2024-09-23"
//     },
//     {
//       "examName": "GATE",
//       "dificultyLevel": "Medium",
//       "examCode": "GATE",
//       "price": 1000,
//       "imageUrl": "assets/exams/MPSC_PSI_Exam.png",
//       "enddate": "2025-02-23",
//       "startDate": "2024-09-23"
//     },
//     {
//       "examName": "JEE",
//       "dificultyLevel": "Hard",
//       "examCode": "JE01",
//       "price": 1200,
//       "imageUrl": "assets/exams/MPSC_PSI_Exam.png",
//       "enddate": "2025-02-23",
//       "startDate": "2024-09-23"
//     },
//     {
//       "examName": "JEE",
//       "dificultyLevel": "Hard",
//       "examCode": "JE01",
//       "price": 1200,
//       "imageUrl": "assets/exams/MPSC_PSI_Exam.png",
//       "enddate": "2025-02-23",
//       "startDate": "2024-09-23"
//     },
//     {
//       "examName": "JEE",
//       "dificultyLevel": "Hard",
//       "examCode": "JE01",
//       "price": 1200,
//       "imageUrl": "assets/exams/MPSC_PSI_Exam.png",
//     },
//   ];
//   final List<Color> colorPattern = [
//     Color.fromARGB(225, 255, 248, 209),
//     Color.fromARGB(255, 177, 220, 226), // Peach color
//     Color.fromARGB(255, 255, 172, 106),
//   ];

//   // void toggleButtonState(bool isTrending) {
//   //   setState(() {
//   //     isTrendingSelected = isTrending;
//   //   });
//   // }
//   List<TrendigUpcomingExamDataModel> trendingExamModels = [];
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       showLoadingDialog();
//       await homeDataViewModel.getTrendingExamList();
//       hideLoadingDialog();
//       showLoadingDialog();
//       await homeDataViewModel.getUpcomingExamList();
//       hideLoadingDialog();
//       trendingExamModels = trendingExams.map((exam) {
//         return TrendigUpcomingExamDataModel.fromJson(exam);
//       }).toList();
//     });

//     super.initState();
//     checkConnectivity();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Load trending exams by default
//     return SafeArea(
//       child: InternetAwareWidget(
//         child: Scaffold(
//           backgroundColor: bodyBGColor,
//           appBar: const HomeCustomAppBar(
//             containerText: "EXAMS",
//             imagePath: "assets/images/Logo/logo100x100.png",
//           ),
//           drawer: const UserDrawer(),
//           body: Stack(
//             alignment: Alignment.center,
//             children: [
//               CustomPaint(
//                 painter: HeaderCurvedContainer(),
//                 child: SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height,
//                 ),
//               ),
//               Obx(() {
//                 // ignore: prefer_is_empty
//                 if (homeDataViewModel.trendingExamListDataModel.value
//                             ?.responseBody?.length ==
//                         null &&
//                     trendingExamModels.length == null &&
//                     homeDataViewModel.upcomingExamListDataModel.value
//                             ?.responseBody?.length ==
//                         null) {
//                   return const Center(
//                       child: CircularProgressIndicator(
//                     color: primaryColor,
//                   ));
//                 } else {
//                   final exams = toggleButtonsController.isTrendingSelected.value
//                       ? homeDataViewModel
//                               .trendingExamListDataModel.value?.responseBody ??
//                           trendingExamModels
//                       : homeDataViewModel
//                               .upcomingExamListDataModel.value?.responseBody ??
//                           trendingExamModels;

//                   return ListView.builder(
//                     padding: const EdgeInsets.all(10.0),
//                     itemCount: exams.length,
//                     //exams.responseBody?.length ?? 0,
//                     itemBuilder: (context, index) {
//                       final exam = exams[index];
//                       final color = colorPattern[index %
//                           colorPattern.length]; //exams!.responseBody![index];
//                       return ExamCard(
//                         title: exam?.examName,
//                         difficulty: exam?.dificultyLevel,
//                         id: exam?.examCode,
//                         price: exam?.price,
//                         imageUrl: exam?.examImage,
//                         endDate: exam?.endDate,
//                         color: color,
//                       );
//                     },
//                   );
//                 }
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
