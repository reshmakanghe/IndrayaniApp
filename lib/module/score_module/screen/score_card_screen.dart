import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/home/screens/home_screen.dart';
import 'package:indrayani/module/review_questions_module/screen/review_question_screen.dart';
import 'package:indrayani/module/score_module/view_model/score_card_view_model.dart';

import 'package:indrayani/utils/common_widgets/app%20bar%20widget/custom_app_bar.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/header_curved_container.dart';
import 'package:indrayani/utils/bottom_bar_widget/screen/bottom_bar_widget.dart';
import 'package:indrayani/utils/common_widgets/user_drawer.dart';
import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/internet_connectivity.dart';
import 'package:indrayani/utils/loader.dart';
import 'package:indrayani/utils/widgetConstant/common_widget/common_widget.dart';
import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';
import 'package:pie_chart/pie_chart.dart';

//working code
// class to draw the profile screen
// class ScoreCardScreen extends StatefulWidget {
//   String examCode;
//   int resultId;
//   ScoreCardScreen({super.key, required this.examCode, required this.resultId});
//   @override
//   State<ScoreCardScreen> createState() => _ScoreCardScreenState();
// }

// class _ScoreCardScreenState extends State<ScoreCardScreen> {
//   ScoreCardViewModel scoreCardViewModel = Get.put(ScoreCardViewModel());
//   // late Map<String, dynamic> dataMap;
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       showLoadingDialog();
//       await scoreCardViewModel.getScoreCard(
//           examCode: widget.examCode, resultId: widget.resultId);
//       hideLoadingDialog();
//     });

//     super.initState();
//     checkConnectivity();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Map<String, double> dataMap = {
//       "${scoreCardViewModel.scoreCardDataModel.value?.responseBody?.first?.skipAns ?? 0}/${scoreCardViewModel.scoreCardDataModel.value?.responseBody?.first?.totalQuestions ?? 0}  -  Un-Attempted Question":
//           double.parse(
//               "${scoreCardViewModel.scoreCardDataModel.value?.responseBody?.first?.skipAns ?? 0}"),
//       "${scoreCardViewModel.scoreCardDataModel.value?.responseBody?.first?.unskipAns ?? 0}/${scoreCardViewModel.scoreCardDataModel.value?.responseBody?.first?.totalQuestions ?? 0}  -  Attempted Question":
//           double.parse(
//               "${scoreCardViewModel.scoreCardDataModel.value?.responseBody?.first?.unskipAns ?? 0}"),
//       "${scoreCardViewModel.scoreCardDataModel.value?.responseBody?.first?.rightAns ?? 0}/${scoreCardViewModel.scoreCardDataModel.value?.responseBody?.first?.totalQuestions ?? 0}   -  Correct Question":
//           double.parse(
//               "${scoreCardViewModel.scoreCardDataModel.value?.responseBody?.first?.rightAns ?? 0}"), // Example double value
//       "${scoreCardViewModel.scoreCardDataModel.value?.responseBody?.first?.wrongAns ?? 0}/${scoreCardViewModel.scoreCardDataModel.value?.responseBody?.first?.totalQuestions ?? 0}   -  Incorrect Question":
//           double.parse(
//               "${scoreCardViewModel.scoreCardDataModel.value?.responseBody?.first?.wrongAns ?? 0}"), // Example double value
//     };
//     double chartRadius = MediaQuery.of(context).size.width / 1.8;
//     double centerX = MediaQuery.of(context).size.width / 2;
//     double centerY = chartRadius / 2;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: bodyBGColor,
//         appBar: const CustomAppBar(
//           containerText: "SCORE",
//           imagePath: "assets/Icon/score-icon-8.png",
//         ),
//         drawer: UserDrawer(),
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
//             Padding(
//               padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     spaceWidget(height: 30.0),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Column(
//                           children: [
//                             const ConstantText(
//                               text: "Exam Code",
//                               fontSize: 12.0,
//                             ),
//                             ConstantText(
//                               text: scoreCardViewModel.scoreCardDataModel.value
//                                       ?.responseBody?.first?.examCode ??
//                                   "",
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ],
//                         ),
//                         Spacer(
//                           flex: 1,
//                         ),
//                         Container(
//                           height: 30, // Adjust the height to fit your needs
//                           child: VerticalDivider(
//                             color: Colors.black.withOpacity(0.3),
//                             thickness: 1,
//                           ),
//                         ),
//                         Spacer(
//                           flex: 1,
//                         ),
//                         Column(
//                           children: [
//                             const ConstantText(
//                               text: "Exam Name",
//                               fontSize: 12.0,
//                             ),
//                             ConstantText(
//                               text: scoreCardViewModel.scoreCardDataModel.value
//                                       ?.responseBody?.first?.examName ??
//                                   "",
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ],
//                         ),
//                         Spacer(
//                           flex: 1,
//                         ),
//                         Container(
//                           height: 30, // Adjust the height to fit your needs
//                           child: VerticalDivider(
//                             color: Colors.black.withOpacity(0.3),
//                             thickness: 1,
//                           ),
//                         ),
//                         Spacer(
//                           flex: 1,
//                         ),
//                         Column(
//                           children: [
//                             const ConstantText(
//                               text: "Difficulty Level",
//                               fontSize: 12.0,
//                             ),
//                             ConstantText(
//                               text: scoreCardViewModel.scoreCardDataModel.value
//                                       ?.responseBody?.first?.difficultyLevel ??
//                                   "",
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Divider(
//                       color: Colors.black.withOpacity(0.1),
//                       thickness: 1,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Column(
//                           children: [
//                             ConstantText(
//                               text: "Exam Type",
//                               fontSize: 12.0,
//                             ),
//                             ConstantText(
//                               text:
//                                   "${scoreCardViewModel.scoreCardDataModel.value?.responseBody?.first?.timeTaken ?? "Type"}",
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ],
//                         ),
//                         Spacer(
//                           flex: 2,
//                         ),
//                         Container(
//                           height: 30, // Adjust the height to fit your needs
//                           child: VerticalDivider(
//                             color: Colors.black.withOpacity(0.3),
//                             thickness: 1,
//                           ),
//                         ),
//                         Spacer(
//                           flex: 2,
//                         ),
//                         Column(
//                           children: [
//                             const ConstantText(
//                               text: "Average time for\n each question",
//                               fontSize: 12.0,
//                             ),
//                             ConstantText(
//                               text:
//                                   "${scoreCardViewModel.scoreCardDataModel.value?.responseBody?.first?.questionAvgTime ?? ""}",
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ],
//                         ),
//                         Spacer(
//                           flex: 2,
//                         ),
//                         Container(
//                           height: 30, // Adjust the height to fit your needs
//                           child: VerticalDivider(
//                             color: Colors.black.withOpacity(0.3),
//                             thickness: 1,
//                           ),
//                         ),
//                         Spacer(
//                           flex: 2,
//                         ),
//                         Column(
//                           children: [
//                             const ConstantText(
//                               text: "Total Question",
//                               fontSize: 12.0,
//                             ),
//                             ConstantText(
//                               text:
//                                   "${scoreCardViewModel.scoreCardDataModel.value?.responseBody?.first?.totalQuestions ?? ""}",
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     spaceWidget(height: 40.0),
//                     PieChart(
//                       dataMap: dataMap,

//                       animationDuration: Duration(milliseconds: 800),
//                       chartLegendSpacing: 80,
//                       chartRadius: MediaQuery.of(context).size.width / 1.8,
//                       colorList: colorList,
//                       initialAngleInDegree: 270,
//                       chartType: ChartType.ring,
//                       ringStrokeWidth: 60,
//                       //  centerText: "Your Score \n60%",
//                       centerWidget: Container(
//                         width: MediaQuery.of(context).size.width * 0.32,
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.white,
//                         ),
//                         child: const Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             ConstantText(
//                               text: "Your score",
//                             ),
//                             ConstantText(
//                               text: "60%",
//                               fontWeight: FontWeight.bold,
//                               fontSize: 40.0,
//                             )
//                           ],
//                         ),
//                       ),
//                       //totalValue: 10.0,

//                       legendOptions: const LegendOptions(
//                         legendShape: BoxShape.rectangle,
//                         showLegendsInRow: true,
//                         legendPosition: LegendPosition.bottom,
//                         showLegends: true,
//                         // legendShape: _BoxShape.circle,
//                         legendTextStyle: TextStyle(
//                           fontWeight: FontWeight.normal,
//                         ),
//                       ),
//                       chartValuesOptions: const ChartValuesOptions(
//                           showChartValueBackground: false,
//                           showChartValues: true,
//                           showChartValuesInPercentage: true,
//                           showChartValuesOutside: true,
//                           decimalPlaces: 0,
//                           chartValueStyle:
//                               TextStyle(fontSize: 15.0, color: Colors.black)),

//                       // gradientList: ---To add gradient colors---
//                       // emptyColorGradient: ---Empty Color gradient---
//                     ),
//                     spaceWidget(height: 10.0),
//                     Center(
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => ReviewQuestionScreen(
//                                     examCode: "1",
//                                   )));
//                         },
//                         style: ButtonStyle(
//                           splashFactory: InkRipple.splashFactory,
//                           overlayColor: MaterialStateProperty.resolveWith(
//                             (states) {
//                               return states.contains(MaterialState.pressed)
//                                   ? Colors.grey
//                                   : null;
//                             },
//                           ),
//                           backgroundColor: MaterialStateProperty.all(
//                             primaryColor,
//                           ),
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                   10.0), // Set to 0 for square shape
//                             ),
//                           ),
//                         ),
//                         child: const ConstantText(
//                           text: 'Review Questions ',
//                           color: Colors.black,
//                           fontSize: 16.0,
//                         ),
//                       ),
//                     ),
//                     spaceWidget(height: 20.0),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//}

class ScoreCardScreen extends StatefulWidget {
  final String examCode;
  final int resultId;

  const ScoreCardScreen(
      {super.key, required this.examCode, required this.resultId});

  @override
  State<ScoreCardScreen> createState() => _ScoreCardScreenState();
}

class _ScoreCardScreenState extends State<ScoreCardScreen> {
  final ScoreCardViewModel scoreCardViewModel = Get.put(ScoreCardViewModel());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //   showLoadingDialog();
      try {
        await scoreCardViewModel.getScoreCard(
          examCode: widget.examCode,
          resultId: widget.resultId,
        );
      } finally {
        //  hideLoadingDialog();
      }
    });

    checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false, // Remove all previous routes
        );
        return true; // Allow back navigation (though the stack is cleared)
      },
      // return WillPopScope(
      //   onWillPop: () async {
      //     // Navigate to home page and remove all previous screens
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (context) =>
      //             // BottomNavigationBarWidget(
      //             // bodyWidget:
      //             HomeScreen(),
      //         // ),
      //       ),
      //     );
      //     return false; // Prevent the default back navigation
      //   },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: bodyBGColor,
          appBar: const CustomAppBar(
            containerText: "SCORE",
            imagePath: "assets/Icon/score-icon-8.png",
          ),
          drawer: UserDrawer(),
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
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: SingleChildScrollView(child: Obx(() {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spaceWidget(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              const ConstantText(
                                text: "Exam Code",
                                fontSize: 12.0,
                              ),
                              ConstantText(
                                text: scoreCardViewModel.scoreCardDataModel
                                        .value?.responseBody?.first?.examCode ??
                                    "",
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          Spacer(flex: 1),
                          Container(
                            height: 30,
                            child: VerticalDivider(
                              color: Colors.black.withOpacity(0.3),
                              thickness: 1,
                            ),
                          ),
                          Spacer(flex: 1),
                          Column(
                            children: [
                              const ConstantText(
                                text: "Exam Name",
                                fontSize: 12.0,
                              ),
                              ConstantText(
                                text: scoreCardViewModel.scoreCardDataModel
                                        .value?.responseBody?.first?.examName ??
                                    "",
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          Spacer(flex: 1),
                          Container(
                            height: 30,
                            child: VerticalDivider(
                              color: Colors.black.withOpacity(0.3),
                              thickness: 1,
                            ),
                          ),
                          Spacer(flex: 1),
                          Column(
                            children: [
                              const ConstantText(
                                text: "Difficulty Level",
                                fontSize: 12.0,
                              ),
                              ConstantText(
                                text: scoreCardViewModel
                                        .scoreCardDataModel
                                        .value
                                        ?.responseBody
                                        ?.first
                                        ?.difficultyLevel ??
                                    "",
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.black.withOpacity(0.1),
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              const ConstantText(
                                text: "Exam Type",
                                fontSize: 12.0,
                              ),
                              ConstantText(
                                text: scoreCardViewModel.scoreCardDataModel
                                        .value?.responseBody?.first?.examType ??
                                    "-",
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          Spacer(flex: 2),
                          Container(
                            height: 30,
                            child: VerticalDivider(
                              color: Colors.black.withOpacity(0.3),
                              thickness: 1,
                            ),
                          ),
                          Spacer(flex: 2),
                          Column(
                            children: [
                              const ConstantText(
                                text: "Average time for\n each question",
                                fontSize: 12.0,
                              ),
                              ConstantText(
                                text:
                                    "${scoreCardViewModel.scoreCardDataModel.value?.responseBody?.first?.questionAvgTime ?? ""}",
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          Spacer(flex: 2),
                          Container(
                            height: 30,
                            child: VerticalDivider(
                              color: Colors.black.withOpacity(0.3),
                              thickness: 1,
                            ),
                          ),
                          Spacer(flex: 2),
                          Column(
                            children: [
                              const ConstantText(
                                text: "Total Question",
                                fontSize: 12.0,
                              ),
                              ConstantText(
                                text:
                                    "${scoreCardViewModel.scoreCardDataModel.value?.responseBody?.first?.totalQuestions ?? ""}",
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ],
                      ),
                      spaceWidget(height: 40.0),
                      Obx(() {
                        var dataMap = scoreCardViewModel.dataMap;

                        if (dataMap.isEmpty) {
                          return Center(child: CircularProgressIndicator());
                        }
                        // Map<String, double> dataMap1 =
                        //     calculateDataMap(legendData);
                        return PieChart(
                          dataMap: dataMap,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: 80,
                          chartRadius: MediaQuery.of(context).size.width / 1.8,
                          colorList: scoreCardViewModel.colorList,
                          initialAngleInDegree: 270,
                          chartType: ChartType.ring,
                          ringStrokeWidth: 60,
                          centerWidget: Container(
                            width: MediaQuery.of(context).size.width * 0.32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const ConstantText(
                                  text: "Your score",
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10.0,
                                  ),
                                  child: Text(
                                    "${scoreCardViewModel.scoreCardDataModel.value?.responseBody?.first?.percentageScore?.toString() ?? ""}%",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          legendOptions: LegendOptions(
                            legendShape: BoxShape.rectangle,
                            showLegendsInRow: true,
                            legendPosition: LegendPosition.bottom,
                            showLegends: true,
                            legendTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            legendLabels: scoreCardViewModel.legendData.value
                                .map((label, value) {
                              return MapEntry(
                                  label, label); // Display the legend as it is
                            }),
                          ),
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: false,
                            showChartValues: true,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: true,
                            decimalPlaces: 0,
                            chartValueStyle: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }),
                      spaceWidget(height: 10.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  // BottomNavigationBarWidget(
                                  // bodyWidget:
                                  ReviewQuestionScreen(
                                examCode: widget.examCode,
                                resultId: widget.resultId,
                                //  )
                              ),
                            ));
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => ReviewQuestionScreen(
                            //     examCode: widget.examCode,
                            //     resultId: widget.resultId,
                            //   ),
                            // ));
                          },
                          style: ButtonStyle(
                            splashFactory: InkRipple.splashFactory,
                            overlayColor: MaterialStateProperty.resolveWith(
                              (states) {
                                return states.contains(MaterialState.pressed)
                                    ? Colors.grey
                                    : null;
                              },
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              primaryColor,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          child: Text(
                            'Review Questions',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                        ),
                      ),
                      spaceWidget(height: 30.0),
                    ],
                  );
                })),
              ),
            ],
          ),
        ),
      ),
    );
  }

//   Map<String, double> calculateDataMap(Map<String, String> legendData) {
//     Map<String, double> dataMap1 = {};

//     legendData.forEach((label, value) {
//       // Split the legend value (e.g., "2/50")
//       List<String> splitValue = value.split('/');
//       double numerator = double.parse(splitValue[0]);
//       double denominator = double.parse(splitValue[1]);

//       // Calculate the percentage
//       double percentage = (numerator / denominator) * 100;

//       // Add the percentage to the dataMap with the original label
//       dataMap1[label] = percentage;
//     });

//     return dataMap1;
//   }

// // Example legend data
//   Map<String, String> legendData = {
//      "${response?.skipAns ?? 0}/${response?.totalQuestions ?? 0}  -  Un-Attempted Question":
//         double.parse("${response?.skipAns ?? 0}"),
//     "${response?.unskipAns ?? 0}/${response?.totalQuestions ?? 0}  -  Attempted Question":
//         double.parse("${response?.unskipAns ?? 0}"),
//     "${response?.rightAns ?? 0}/${response?.totalQuestions ?? 0}   -  Correct Question":
//         double.parse("${response?.rightAns ?? 0}"),
//     "${response?.wrongAns ?? 0}/${response?.totalQuestions ?? 0}   -  Incorrect Question":
//         double.parse("${response?.wrongAns ?? 0}"),
//     // Add more sections as needed
//   };
}
