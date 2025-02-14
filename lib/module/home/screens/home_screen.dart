// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:indrayani/module/Cart/view_model/exam_cart_view_model.dart';
// import 'package:indrayani/module/home/model/home_data_model.dart';
// import 'package:indrayani/module/home/view_model/home_view_model.dart';
// import 'package:indrayani/utils/common_widgets/custom_app_bar.dart';
// import 'package:indrayani/utils/common_widgets/exam_card.dart';
// import 'package:indrayani/utils/common_widgets/header_curved_container.dart';
// import 'package:indrayani/utils/common_widgets/home_custom_app_bar.dart';
// import 'package:indrayani/utils/common_widgets/user_drawer.dart';
// import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
// import 'package:indrayani/utils/internet_connectivity.dart';
// import 'package:indrayani/utils/internet_connectivity/internet_connectivity.dart';
// import 'package:indrayani/utils/loader.dart';
// import 'package:indrayani/utils/widgetConstant/common_widget/common_widget.dart';
// import 'package:pinput/pinput.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   bool isTrendingSelected = true;
//   CartViewModel cartViewModel = Get.put(CartViewModel());
//   HomeDataViewModel homeDataViewModel = Get.put(HomeDataViewModel());

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
//       "examName": "NEET",
//       "dificultyLevel": "Medium",
//       "examCode": "NE01",
//       "price": 1000,
//       "imageUrl": "assets/exams/MPSC_PSI_Exam.png",
//     },
//     {
//       "examName": "NEET",
//       "dificultyLevel": "Medium",
//       "examCode": "NE01",
//       "price": 1000,
//       "imageUrl": "assets/exams/MPSC_PSI_Exam.png"
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
//       "examName": "NEET",
//       "dificultyLevel": "Medium",
//       "enddate": "2025-02-23",
//       "startDate": "2024-09-23",
//       "examCode": "NE01",
//       "price": 1000,
//       "imageUrl": "assets/exams/MPSC_PSI_Exam.png"
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
//       "examName": "NEET",
//       "dificultyLevel": "Medium",
//       "examCode": "NE01",
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

//   void toggleButtonState(bool isTrending) {
//     setState(() {
//       isTrendingSelected = isTrending;
//     });
//   }

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       showLoadingDialog();
//       await homeDataViewModel.getTrendingExamList();
//       hideLoadingDialog();
//       showLoadingDialog();
//       await homeDataViewModel.getUpcomingExamList();
//       hideLoadingDialog();
//     });

//     super.initState();
//     checkConnectivity();
//   }

//   @override
//   Widget build(BuildContext context) {
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
//               SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height,
//                       padding: const EdgeInsets.all(10.0),
//                       child: ListView.builder(
//                         itemCount: trendingExams.length,
//                         itemBuilder: (context, index) {
//                           final exam = trendingExams[index];
//                           return ExamCard(
//                             examName: exam['examName'],
//                             dificultyLevel: exam['dificultyLevel'],
//                             id: exam['id'],
//                             price: exam['price'],
//                             imageUrl: exam['imageUrl'],
//                             endDate: exam['e'],
//                           );
//                         },
//                         //API Call
//                         // itemCount: homeDataViewModel.examListDataModel.value
//                         //         ?.responseBody?.length ??
//                         //     0,
//                         // itemBuilder: (context, index) {
//                         //   final exam = homeDataViewModel
//                         //       .examListDataModel.value?.responseBody?[index];
//                         //   return SizedBox(
//                         //     // Set the height you want for each card
//                         //     child: ExamCard(
//                         //       examName: exam?.examName,
//                         //       dificultyLevel: exam?.dificultyLevel,
//                         //       id: exam?.examCode,
//                         //       price: exam?.price,
//                         //       imageUrl: exam?.examImage,
//                         //     ),
//                         //   );
//                         // },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/Cart/view_model/exam_cart_view_model.dart';
import 'package:indrayani/module/home/model/home_data_model.dart';
import 'package:indrayani/module/home/view_model/home_view_model.dart';
import 'package:indrayani/module/home/view_model/toggle_button_view_controller.dart';
import 'package:indrayani/utils/bottom_bar_widget/view_model/bottom_bar_view-model.dart';
import 'package:indrayani/utils/bottom_bar_widget/view_model/custom_bottom_bar.dart';
import 'package:indrayani/utils/exam_card.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/home_custom_app_bar.dart';
import 'package:indrayani/utils/common_widgets/user_drawer.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/internet_connectivity.dart';
import 'package:indrayani/utils/internet_connectivity/internet_connectivity.dart';
import 'package:indrayani/utils/loader.dart';
import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CartViewModel cartViewModel = Get.put(CartViewModel());

  final HomeDataViewModel homeDataViewModel = Get.put(HomeDataViewModel());

  final ToggleButtonsController toggleButtonsController =
      Get.put(ToggleButtonsController());

  final List<Map<String, dynamic>> trendingExams = [];
  final List<Color> colorPattern = [
    Color.fromARGB(225, 255, 248, 209),
    Color.fromARGB(255, 177, 220, 226), // Peach color
    Color.fromARGB(255, 255, 172, 106),
  ];

  // void toggleButtonState(bool isTrending) {
  //   setState(() {
  //     isTrendingSelected = isTrending;
  //   });
  // }

  @override
  void initState() {
    super.initState();

    // Prevent screenshots on this screen
    // _disableScreenshots();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      showLoadingDialog();
      await homeDataViewModel.getTrendingExamList();
      hideLoadingDialog();
      showLoadingDialog();
      await homeDataViewModel.getUpcomingExamList();
      hideLoadingDialog();
    });

    checkConnectivity();
  }

  @override
  void dispose() {
    // Re-enable screenshots when leaving this screen
    // _enableScreenshots();
    super.dispose();
  }

  // Future<void> _disableScreenshots() async {
  //   await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  // }

  // Future<void> _enableScreenshots() async {
  //   await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  // }

  @override
  Widget build(BuildContext context) {
    // Load trending exams by default
    return Obx(
      () {
        final bottomBarVisibility =
            Get.find<NavigationController>().showBottomBar.value;
        return WillPopScope(
          onWillPop: () async {
            // Prevent the default behavior of going back to the previous screen
            // Exit the app instead
            SystemNavigator.pop();
            return false;
          },
          child: SafeArea(
            child: InternetAwareWidget(
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: bodyBGColor,
                appBar: const HomeCustomAppBar(
                  containerText: "EXAMS",
                  imagePath: "assets/images/Logo/logo100x100.png",
                ),
                drawer: const UserDrawer(),
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
                    Obx(() {
                      final trendingExams = homeDataViewModel
                          .trendingExamListDataModel.value?.responseBody;
                      final upcomingExams = homeDataViewModel
                          .upcomingExamListDataModel.value?.responseBody;
                      final trendingModels =
                          homeDataViewModel.trendingExamModels;

                      if (trendingExams == null &&
                          upcomingExams == null &&
                          trendingModels.isEmpty) {
                        return Center(
                            child: Animate(
                                // effects: [FadeEffect(), ScaleEffect()],
                                child:
                                    const ConstantText(text: "No Exams found!")
                                        .animate()
                                        .fadeIn(duration: 600.ms)
                                        .then(delay: 200.ms) // baseline=800ms
                                        .slide()));
                      } else if ((trendingExams?.isEmpty ?? true) &&
                          (upcomingExams?.isEmpty ?? true) &&
                          trendingModels.isEmpty) {
                        return const Center(
                          child: Text("No exams found !"),
                        );
                      } else {
                        final List<TrendigUpcomingExamDataModel?> exams;
                        if (toggleButtonsController.isTrendingSelected.value) {
                          exams = trendingExams ?? [];
                        } else {
                          exams = upcomingExams ?? trendingModels;
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.all(10.0),
                          itemCount: exams.length + 1,
                          itemBuilder: (context, index) {
                            if (index == exams.length) {
                              // Last item (spacer)
                              return SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.07, // Adjust the height as needed
                              );
                            }
                            final exam = exams[index];
                            final color =
                                colorPattern[index % colorPattern.length];
                            return ExamCard(
                              title: exam?.examName,
                              difficulty: exam?.difficultyLevel,
                              id: exam?.examCode,
                              price: exam?.price,
                              imageUrl: exam?.img,
                              startDate: exam?.startDate,
                              endDate: exam?.endDate,
                              totalMarks: exam?.totalMarks,
                              availableOn: exam?.availableOn,
                              isPurchase: exam?.isPurchase,
                              color: color,
                              isHomeScreen: true,
                              isCartScreen: false,
                              isTrending: toggleButtonsController
                                  .isTrendingSelected.value,
                            );
                          },
                        );
                      }
                    }),

                    // Obx(() {
                    //   // ignore: prefer_is_empty
                    //   if (homeDataViewModel.trendingExamListDataModel.value
                    //               ?.responseBody?.length ==
                    //           null &&
                    //       homeDataViewModel.trendingExamModels.length == null &&
                    //       homeDataViewModel.upcomingExamListDataModel.value
                    //               ?.responseBody?.length ==
                    //           null) {
                    //     return Center(
                    //     //  child: const ConstantText(text: "No exams found !!!"),
                    //           child: CircularProgressIndicator(
                    //         color: primaryColor,
                    //       ),
                    //     );
                    //   } else {
                    //     final List<TrendigUpcomingExamDataModel?> exams;
                    //     if (toggleButtonsController.isTrendingSelected.value) {
                    //       // homeDataViewModel.getTrendingExamList();
                    //       exams = homeDataViewModel
                    //               .trendingExamListDataModel.value?.responseBody ??
                    //           [];
                    //     } else {
                    //       exams = homeDataViewModel
                    //               .upcomingExamListDataModel.value?.responseBody ??
                    //           homeDataViewModel.trendingExamModels;
                    //     }

                    //     return ListView.builder(
                    //       padding: const EdgeInsets.all(10.0),
                    //       itemCount: exams.length,
                    //       //exams.responseBody?.length ?? 0,
                    //       itemBuilder: (context, index) {
                    //         final exam = exams[index];
                    //         final color = colorPattern[index %
                    //             colorPattern.length]; //exams!.responseBody![index];
                    //         return ExamCard(
                    //           title: exam?.examName,
                    //           difficulty: exam?.difficulty,
                    //           id: exam?.examCode,
                    //           price: exam?.price,
                    //           imageUrl: exam?.img,
                    //           startDate: exam?.startDate,
                    //           endDate: exam?.endDate,
                    //           totalMarks: exam?.totalMarks,
                    //           availableOn: exam?.availableOn,
                    //           color: color,
                    //           isHomeScreen: true,
                    //           isTrending:
                    //               toggleButtonsController.isTrendingSelected.value,
                    //         );
                    //       },
                    //     );
                    //   }
                    // }),
                  ],
                ),
                bottomNavigationBar:
                    bottomBarVisibility ? CustomBottomNavBar() : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
