// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:indrayani/module/exam_questions_module/exam_questions_view_model/exam_questions_view_model.dart';
// import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_header_container.dart';
// import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
// import 'package:indrayani/utils/initialization_services/singleton_service.dart';
// import 'package:indrayani/utils/loader.dart';
// import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';

// class ExamPageAppBar extends StatefulWidget implements PreferredSizeWidget {
//   @override
//   final Size preferredSize;
//   final String? title;
//   final String imagePath;
//   final String containerText;
//   final double? height;
//   String examCode;

//   ExamPageAppBar({
//     Key? key,
//     this.title,
//     required this.examCode,
//     required this.imagePath,
//     required this.containerText,
//     this.height,
//   })  : preferredSize = const Size.fromHeight(200.0),
//         super(key: key);

//   @override
//   _ExamPageAppBarState createState() => _ExamPageAppBarState();
// }

// class _ExamPageAppBarState extends State<ExamPageAppBar> {
//   late Timer _timer;

//   ExamQuestionsViewModel examQuestionsViewModel =
//       Get.put(ExamQuestionsViewModel());
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       showLoadingDialog();
//       await examQuestionsViewModel.getExamQuestionsList(
//           examCode: widget.examCode,
//           userId: IndrayaniAppGLobal.instance.loginViewModel.loginDataModel
//                   ?.value?.responseBody?.userId ??
//               0);
//       hideLoadingDialog();
//       // initializeTimeSpent();
//       // initializeSelectedOptions();
//       startTimer();
//     });
//   }

//   void startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         // Fetch the exam duration from the API response, use 120 minutes as default if it's null or 0
//         final examDuration = examQuestionsViewModel
//                 .examQuestionsDataModel.value?.responseBody?.examDuration ??
//             0;
//         print("examDuration $examDuration");
//         if (examQuestionsViewModel.examTime.value == 0) {
//           examQuestionsViewModel.examTime.value =
//               examDuration * 60; // Convert minutes to seconds
//         }

//         final examTime = examQuestionsViewModel.examTime.value;

//         if (examTime > 0) {
//           examQuestionsViewModel.examTime.value = examTime - 1;

//           // Check if currentQuestionIndex is within the valid range
//           int currentIndex = examQuestionsViewModel.currentQuestionIndex.value;
//           if (currentIndex >= 0 &&
//               currentIndex <
//                   examQuestionsViewModel.timeSpentOnQuestions.length) {
//             examQuestionsViewModel.timeSpentOnQuestions[currentIndex];
//           } else {
//             // Handle index out of bounds error or invalid state gracefully
//             print('Invalid index: $currentIndex');
//           }
//         } else {
//           _timer.cancel();
//           // Handle exam time up, maybe submit the exam or show an alert
//         }
//       });
//     });
//   }

//   String formatTime(int seconds) {
//     int minutes = seconds ~/ 60;
//     int remainingSeconds = seconds % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
//   }
//   // String formatTime(int seconds) {
//   //   int hours = seconds ~/ 3600;
//   //   int minutes = (seconds % 3600) ~/ 60;
//   //   int remainingSeconds = seconds % 60;
//   //   return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
//   // }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: widget.preferredSize.height,
//       child: Column(
//         children: [
//           AppBar(
//             backgroundColor: primaryColor,
//             leading: Builder(
//               builder: (BuildContext context) {
//                 return IconButton(
//                   icon: Icon(Icons.menu),
//                   onPressed: () {
//                     Scaffold.of(context).openDrawer();
//                   },
//                 );
//               },
//             ),
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ConstantText(text: widget.title),
//               ],
//             ),
//             actions: [
//               Container(
//                 padding: const EdgeInsets.only(right: 10.0),
//                 child: Image.asset(
//                   "assets/images/Logo/logo100x100.png",
//                   height: 50.0,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: CustomContainer(
//                   imagePath: widget.imagePath,
//                   text: widget.containerText,
//                   containerHeight: 50.0,
//                 ),
//               ),
//               Container(
//                 color: Colors.black,
//                 width: MediaQuery.of(context).size.width * 0.3,
//                 height: 50.0,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.alarm, color: Colors.white),
//                     const SizedBox(width: 10.0),
//                     ConstantText(
//                       text: formatTime(
//                           examQuestionsViewModel.secondsElapsed.value),
//                       // formatTime(examQuestionsViewModel
//                       //         .timeSpentOnQuestions[
//                       //     examQuestionsViewModel.currentQuestionIndex.value]),
//                       color: Colors.white,
//                       fontSize: 18.0,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height * 0.03,
//             // width: 300.0,
//             color: primaryColor,
//           )
//         ],
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/exam_questions_module/exam_questions_data_model/exam_questions_data_model.dart';
import 'package:indrayani/module/exam_questions_module/exam_questions_view_model/exam_questions_view_model.dart';
import 'package:indrayani/module/score_module/screen/score_card_screen.dart';
import 'package:indrayani/module/subscription_module/screen/subscription_screen.dart';
import 'package:indrayani/utils/WebService/api_base_model.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_header_container.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/initialization_services/singleton_service.dart';
import 'package:indrayani/utils/loader.dart';
import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';

class ExamPageAppBar extends StatefulWidget implements PreferredSizeWidget {
  //final ExamQuestionsDataModel? examData;

  // final int resultId;
  @override
  final Size preferredSize;
  final String? title;
  final String imagePath;
  final String containerText;
  final double? height;
  final String examCode;

  ExamPageAppBar({
    Key? key,
    this.title,
    //   required this.resultId,
    required this.examCode,
    required this.imagePath,
    required this.containerText,
    this.height,
  })  : preferredSize = const Size.fromHeight(200.0),
        super(key: key);

  @override
  _ExamPageAppBarState createState() => _ExamPageAppBarState();
}

class _ExamPageAppBarState extends State<ExamPageAppBar> {
  ExamQuestionsViewModel examQuestionsViewModel =
      Get.put(ExamQuestionsViewModel());

  @override
  void initState() {
    super.initState();
    // examData = examQuestionsViewModel.examQuestionsDataModel.value;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // showLoadingDialog();
      // await examQuestionsViewModel.getExamQuestionsList(
      //     // resultId: widget.resultId,
      //     examCode: widget.examCode,
      //     userId: IndrayaniAppGLobal.instance.loginViewModel.loginDataModel
      //             ?.value?.responseBody?.userId ??
      //         0);
      // hideLoadingDialog();
      // initializeTimeSpent();
      // initializeSelectedOptions();
      // startTimer2();
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   startTimer();
    // });
  }

  // void startTimer2() {
  //   final examDuration = //widget.examData?.responseBody?.examDuration ?? 0;
  //       examQuestionsViewModel
  //               .examQuestionsDataModel.value?.responseBody?.examDuration ??
  //           0;
  //   final totalTimeInSeconds = examDuration * 60; // Convert minutes to seconds

  //   examQuestionsViewModel.examTime.value = totalTimeInSeconds;

  //   examQuestionsViewModel.timer.value =
  //       Timer.periodic(Duration(seconds: 1), (timer) {
  //     if (examQuestionsViewModel.examTime.value > 0) {
  //       examQuestionsViewModel.examTime.value -= 1;
  //     } else {
  //       if (!examQuestionsViewModel.isExamSubmitted.value) {
  //         showLoadingDialog();
  //         examQuestionsViewModel.handleExamSubmission();
  //         hideLoadingDialog();
  //       }
  //       timer.cancel();
  //     }
  //   });
  // }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    examQuestionsViewModel.timer.value?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.preferredSize.height,
      child: Column(
        children: [
          AppBar(
            backgroundColor: primaryColor,
            leading: Container(),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstantText(text: widget.title),
              ],
            ),
            actions: [
              Container(
                padding: const EdgeInsets.only(right: 10.0),
                child: Image.asset(
                  "assets/images/Logo/logo100x100.png",
                  height: 50.0,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CustomContainer(
                  imagePath: widget.imagePath,
                  text: widget.containerText,
                  containerHeight: 50.0,
                ),
              ),
              Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width * 0.3,
                height: 50.0,
                child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.alarm, color: Colors.white),
                        const SizedBox(width: 10.0),
                        ConstantText(
                          text:
                              formatTime(examQuestionsViewModel.examTime.value),
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ],
                    )),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.03,
            color: primaryColor,
          ),
        ],
      ),
    );
  }
}
