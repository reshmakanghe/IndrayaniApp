// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:indrayani/module/review_questions_module/screen/review_question_app_bar.dart';
// import 'package:indrayani/module/review_questions_module/view_model/review_question_view_model.dart';
// import 'package:indrayani/utils/common_widgets/user_drawer.dart';

// import 'package:indrayani/utils/internet_connectivity/internet_connectivity.dart';
// import 'package:indrayani/utils/loader.dart';
// import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';

// class ReviewQuestionScreen extends StatefulWidget {
//   final String? examCode;
//   final int? resultId;
//   ReviewQuestionScreen({super.key, this.examCode, this.resultId});

//   @override
//   State<ReviewQuestionScreen> createState() => _ReviewQuestionScreenState();
// }

// class _ReviewQuestionScreenState extends State<ReviewQuestionScreen> {
//   final ReviewQuestionViewModel reviewQuestionViewModel =
//       Get.put(ReviewQuestionViewModel());
//   final fallbackQuestions = ReviewQuestionViewModel.fallbackQuestions;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       showLoadingDialog();
//       await reviewQuestionViewModel.getReviewQuestionList(
//           examCode: widget.examCode, resultId: widget.resultId);
//       hideLoadingDialog();
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: const ReviewQuestionAppBar(
//         containerText: "REVIEW QUESTION",
//         imagePath: "assets/Icon/que_icon.png",
//       ),
//       drawer: const UserDrawer(),
//       body: Obx(() {
//         return InternetAwareWidget(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0),
//             child: ListView.builder(
//               itemCount: reviewQuestionViewModel
//                       .reviewQuestionsDataModel.value?.responseBody?.length ??
//                   fallbackQuestions.length,
//               itemBuilder: (context, index) {
//                 final question = reviewQuestionViewModel
//                         .reviewQuestionsDataModel.value?.responseBody?[index] ??
//                     fallbackQuestions[index];
//                 final options = [
//                   question.option1,
//                   question.option2,
//                   question.option3,
//                   question.option4,
//                 ];
//                 final correctAnswer = question.rightOption;
//                 final selectedAnswer = question.userAnswer;

//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ConstantText(
//                             // maxLines: 6,
//                             text: 'Question ${index + 1}:',
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           ConstantText(
//                             maxLines: 6,
//                             text: '${question.question}',
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           ...options.map((option) {
//                             final isSelected = option == selectedAnswer;
//                             final isCorrectOption = option == correctAnswer;

//                             return Container(
//                               margin: const EdgeInsets.symmetric(vertical: 5.0),
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: isSelected
//                                       ? (isCorrectOption
//                                           ? Colors.green.withOpacity(0.3)
//                                           : Colors.red.withOpacity(0.3))
//                                       : Colors.grey.withOpacity(0.3),
//                                 ),
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 color: isSelected
//                                     ? (isCorrectOption
//                                         ? Colors.green.withOpacity(0.3)
//                                         : Colors.red.withOpacity(0.3))
//                                     : isCorrectOption
//                                         ? Colors.green.withOpacity(0.3)
//                                         : Colors.white,
//                               ),
//                               child: ListTile(
//                                 contentPadding: EdgeInsets.zero,
//                                 dense: true,
//                                 leading: Radio<String>(
//                                   value: option ?? '',
//                                   groupValue: selectedAnswer,
//                                   onChanged: (_) {},
//                                   activeColor: isCorrectOption
//                                       ? Colors.green
//                                       : Colors.red,
//                                 ),
//                                 title: ConstantText(
//                                   text: option ?? '',
//                                   maxLines: 3,
//                                   style: TextStyle(
//                                     fontWeight: isSelected
//                                         ? FontWeight.bold
//                                         : FontWeight.normal,
//                                     color: isSelected || isCorrectOption
//                                         ? Colors.black
//                                         : null,
//                                   ),
//                                 ),
//                                 trailing: isSelected || isCorrectOption
//                                     ? Icon(
//                                         isCorrectOption
//                                             ? Icons.check_circle
//                                             : Icons.cancel,
//                                         color: isCorrectOption
//                                             ? Colors.green
//                                             : Colors.red,
//                                       )
//                                     : null,
//                                 onTap: () {
//                                   // Handle option selection if needed
//                                 },
//                               ),
//                             );
//                           }).toList(),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                       child: Divider(
//                         color: Colors.grey.withOpacity(0.3),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/home/screens/home_screen.dart';
import 'package:indrayani/module/review_questions_module/screen/review_question_app_bar.dart';
import 'package:indrayani/module/review_questions_module/view_model/review_question_view_model.dart';
import 'package:indrayani/utils/bottom_bar_widget/view_model/bottom_bar_view-model.dart';
import 'package:indrayani/utils/bottom_bar_widget/view_model/custom_bottom_bar.dart';
import 'package:indrayani/utils/common_widgets/user_drawer.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/internet_connectivity/internet_connectivity.dart';
import 'package:indrayani/utils/loader.dart';
import 'package:indrayani/utils/widgetConstant/common_widget/common_widget.dart';
import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';

class ReviewQuestionScreen extends StatefulWidget {
  final String? examCode;
  final int? resultId;
  bool _isExpanded = false;
  ReviewQuestionScreen({super.key, this.examCode, this.resultId});

  @override
  State<ReviewQuestionScreen> createState() => _ReviewQuestionScreenState();
}

class _ReviewQuestionScreenState extends State<ReviewQuestionScreen> {
  final ReviewQuestionViewModel reviewQuestionViewModel =
      Get.put(ReviewQuestionViewModel());
  final fallbackQuestions = ReviewQuestionViewModel.fallbackQuestions;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      showLoadingDialog();
      await reviewQuestionViewModel.getReviewQuestionList(
          examCode: widget.examCode, resultId: widget.resultId);
      hideLoadingDialog();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Obx(() {
      final bottomBarVisibility =
          Get.find<NavigationController>().showBottomBar.value;
      final itemCount = (reviewQuestionViewModel
                  .reviewQuestionsDataModel.value?.responseBody?.length ??
              fallbackQuestions.length) +
          1; // +1 for the "Back to Home" button

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: const ReviewQuestionAppBar(
          containerText: "REVIEW QUESTION",
          imagePath: "assets/Icon/que_icon.png",
        ),
        drawer: const UserDrawer(),
        body: InternetAwareWidget(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.builder(
              itemCount: itemCount,
              itemBuilder: (context, index) {
                if (index == itemCount - 1) {
                  // Last item, show the "Back to Home" button
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => HomeScreen()))
                              .then((_) {
                            // Reset state after navigation is complete
                            // examQuestionsViewModel
                            //     .isExamScreen.value = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          backgroundColor: Colors.black,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          minimumSize: const Size(10.0, 30.0),
                        ),
                        child: const Text(
                          "Back to Home",
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                }

                final question = reviewQuestionViewModel
                        .reviewQuestionsDataModel.value?.responseBody?[index] ??
                    fallbackQuestions[index];
                final options = [
                  question.option1,
                  question.option2,
                  question.option3,
                  question.option4,
                ];
                final correctAnswer = question.rightOption;
                final selectedAnswer = question.userAnswer;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ConstantText(
                            text: 'Question ${index + 1}:',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ConstantText(
                            maxLines: 6,
                            text: '${question.question}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ...options.map((option) {
                            final optionValue = options.indexOf(option) + 1;
                            final isSelected = optionValue == selectedAnswer;
                            final isCorrectOption =
                                optionValue == correctAnswer;
                            final isUserAnswer = optionValue == selectedAnswer;

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isUserAnswer
                                      ? (isCorrectOption
                                          ? Colors.green.withOpacity(0.2)
                                          : Colors.red.withOpacity(0.2))
                                      : Colors.grey.withOpacity(0.3),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                                color: isUserAnswer
                                    ? (isCorrectOption
                                        ? Colors.green.withOpacity(0.2)
                                        : Colors.red.withOpacity(0.2))
                                    : isCorrectOption
                                        ? Colors.green.withOpacity(0.2)
                                        : Colors.white,
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                leading: Radio<int>(
                                  value: optionValue,
                                  groupValue: selectedAnswer,
                                  onChanged: (_) {},
                                  activeColor: Colors.black,
                                ),
                                title: ConstantText(
                                  text: option ?? '',
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontWeight: isUserAnswer
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                trailing: isUserAnswer
                                    ? Icon(
                                        isCorrectOption
                                            ? Icons.check_circle
                                            : Icons.cancel,
                                        color: isCorrectOption
                                            ? Colors.green
                                            : Colors.red,
                                      )
                                    : null,
                                onTap: () {
                                  // Handle option selection if needed
                                },
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    spaceWidget(height: 10.0),
                    question.notes != null
                        ? ListTile(
                            title: Text('Notes:'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  question.notes!,
                                  maxLines: widget._isExpanded
                                      ? null
                                      : 2, // Show all lines if expanded
                                  overflow: widget._isExpanded
                                      ? TextOverflow.visible
                                      : TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                if (question.notes!.length >
                                    100) // Adjust based on your requirement
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget._isExpanded =
                                            !widget._isExpanded;
                                      });
                                    },
                                    child: Text(
                                      widget._isExpanded
                                          ? 'Show Less'
                                          : 'Read More',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 197, 14, 14),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Divider(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    spaceWidget(height: 10.0),
                  ],
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: bottomBarVisibility ? CustomBottomNavBar() : null,
      );
    });
  }
}
  // @override
  // Widget build(BuildContext context) {
  //   return Obx(() {
  //     final bottomBarVisibility =
  //         Get.find<NavigationController>().showBottomBar.value;
  //     return Scaffold(
  //         backgroundColor: Colors.white,
  //         appBar: const ReviewQuestionAppBar(
  //           containerText: "REVIEW QUESTION",
  //           imagePath: "assets/Icon/que_icon.png",
  //         ),
  //         drawer: const UserDrawer(),
  //         body: InternetAwareWidget(
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 10.0),
  //             child: ListView.builder(
  //               itemCount: reviewQuestionViewModel
  //                       .reviewQuestionsDataModel.value?.responseBody?.length ??
  //                   fallbackQuestions.length,
  //               itemBuilder: (context, index) {
  //                 final question = reviewQuestionViewModel
  //                         .reviewQuestionsDataModel
  //                         .value
  //                         ?.responseBody?[index] ??
  //                     fallbackQuestions[index];
  //                 final options = [
  //                   question.option1,
  //                   question.option2,
  //                   question.option3,
  //                   question.option4,
  //                 ];
  //                 final correctAnswer = question.rightOption;
  //                 final selectedAnswer = question.userAnswer;

  //                 return Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           ConstantText(
  //                             text: 'Question ${index + 1}:',
  //                             style: const TextStyle(
  //                               fontSize: 14,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                           ConstantText(
  //                             maxLines: 6,
  //                             text: '${question.question}',
  //                             style: const TextStyle(
  //                               fontSize: 14,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                           ...options.map((option) {
  //                             final optionValue = options.indexOf(option) + 1;
  //                             final isSelected = optionValue == selectedAnswer;
  //                             final isCorrectOption =
  //                                 optionValue == correctAnswer;
  //                             final isUserAnswer =
  //                                 optionValue == selectedAnswer;

  //                             return Container(
  //                               margin:
  //                                   const EdgeInsets.symmetric(vertical: 5.0),
  //                               decoration: BoxDecoration(
  //                                 border: Border.all(
  //                                   color: isUserAnswer
  //                                       ? (isCorrectOption
  //                                           ? Colors.green.withOpacity(0.2)
  //                                           : Colors.red.withOpacity(0.2))
  //                                       : Colors.grey.withOpacity(0.3),
  //                                 ),
  //                                 borderRadius: BorderRadius.circular(10.0),
  //                                 color: isUserAnswer
  //                                     ? (isCorrectOption
  //                                         ? Colors.green.withOpacity(0.2)
  //                                         : Colors.red.withOpacity(0.2))
  //                                     : isCorrectOption
  //                                         ? Colors.green.withOpacity(0.2)
  //                                         : Colors.white,
  //                               ),
  //                               child: ListTile(
  //                                 contentPadding: EdgeInsets.zero,
  //                                 dense: true,
  //                                 leading: Radio<int>(
  //                                   value: optionValue,
  //                                   groupValue: selectedAnswer,
  //                                   onChanged: (_) {},
  //                                   activeColor: Colors.black,
  //                                 ),
  //                                 title: ConstantText(
  //                                   text: option ?? '',
  //                                   maxLines: 3,
  //                                   style: TextStyle(
  //                                     fontWeight: isUserAnswer
  //                                         ? FontWeight.bold
  //                                         : FontWeight.normal,
  //                                     color: Colors.black,
  //                                   ),
  //                                 ),
  //                                 trailing: isUserAnswer
  //                                     ? Icon(
  //                                         isCorrectOption
  //                                             ? Icons.check_circle
  //                                             : Icons.cancel,
  //                                         color: isCorrectOption
  //                                             ? Colors.green
  //                                             : Colors.red,
  //                                       )
  //                                     : null,
  //                                 onTap: () {
  //                                   // Handle option selection if needed
  //                                 },
  //                               ),
  //                             );
  //                           }).toList(),
  //                         ],
  //                       ),
  //                     ),
  //                     spaceWidget(height: 10.0),
  //                     Padding(
  //                       padding: const EdgeInsets.only(left: 10.0, right: 10.0),
  //                       child: Divider(
  //                         color: Colors.grey.withOpacity(0.3),
  //                       ),
  //                     ),
  //                     spaceWidget(height: 10.0),
  //                   ],
  //                 );
  //               },
  //             ),
  //           ),
  //         ),
  //         bottomNavigationBar:
  //             bottomBarVisibility ? CustomBottomNavBar() : null);
  //   });
  // }
//}


    // ElevatedButton(
    //                     onPressed: () {
    //                       Navigator.of(context).push(MaterialPageRoute(
    //                           builder: (context) => HomeScreen()));
    //                     },
    //                     style: ElevatedButton.styleFrom(
    //                       padding: const EdgeInsets.symmetric(horizontal: 25.0),
    //                       backgroundColor: Colors.black,
    //                       shape: const RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.all(Radius.circular(15)),
    //                       ),
    //                       minimumSize: const Size(10.0, 30.0),
    //                     ),
    //                     child: const Text(
    //                       "Back to Home",
    //                       style: TextStyle(
    //                         fontSize: 10.0,
    //                         fontWeight: FontWeight.bold,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                   ),