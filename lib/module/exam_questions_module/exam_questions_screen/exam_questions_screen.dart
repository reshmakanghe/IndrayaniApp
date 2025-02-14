//Code change for selected option will be sent in integer
import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';

import 'package:indrayani/module/exam_questions_module/exam_questions_data_model/exam_questions_data_model.dart';
import 'package:indrayani/module/exam_questions_module/exam_questions_view_model/exam_questions_view_model.dart';
import 'package:indrayani/module/score_module/screen/score_card_screen.dart';
import 'package:indrayani/utils/WebService/api_base_model.dart';
import 'package:indrayani/utils/bottom_bar_widget/view_model/bottom_bar_view-model.dart';
import 'package:indrayani/utils/common_widgets/app%20bar%20widget/exam_page_app_bar.dart';

import 'package:indrayani/utils/constants/ColorConstant/color_constant.dart';
import 'package:indrayani/utils/internet_connectivity/internet_connectivity.dart';
import 'package:indrayani/utils/loader.dart';
import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';
import '../../../utils/initialization_services/singleton_service.dart';

class ExamScreen extends StatefulWidget {
  final bool? isQuestionScreen;
  final String examCode;
  const ExamScreen({
    super.key,
    required this.examCode,
    this.isQuestionScreen,
  });

  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  ExamQuestionsViewModel examQuestionsViewModel =
      Get.put(ExamQuestionsViewModel());
  APIBaseModel<ExamQuestionsDataModel?>? examData;
  late Timer _timer;
  late Timer _countdownTimer;
  int totalTime = 60;
  late StreamSubscription<ConnectivityResult>
      _connectivitySubscription; // Total exam time in seconds (e.g., 1 hour)
  NavigationController navigationController = Get.put(NavigationController());
  @override
  void initState() {
    super.initState();
    // preventScreenshots();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      showLoadingDialog();
      await examQuestionsViewModel.getExamQuestionsList(
          examCode: widget.examCode,
          userId: IndrayaniAppGLobal.instance.loginViewModel.loginDataModel
                  ?.value?.responseBody?.userId ??
              0);
      hideLoadingDialog();
      //examData = examQuestionsViewModel.examQuestionsDataModel.value;
      initializeTimeSpent();
      examQuestionsViewModel.resetExam();
      initializeSelectedOptions();
      startTimer2();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        startTimers();
      });
      monitorConnectivity();
      navigationController.setBottomBarVisibility(false);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _countdownTimer.cancel();
    _connectivitySubscription.cancel();
    Get.find<NavigationController>().setBottomBarVisibility(true);
    // allowScreenshots();
    super.dispose();
  }

  // void preventScreenshots() async {
  //   await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  // }

  // void allowScreenshots() async {
  //   await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  // }

  void initializeTimeSpent() {
    int totalQuestions = examQuestionsViewModel
            .examQuestionsDataModel.value?.responseBody?.questions?.length ??
        0;
    //   fallbackQuestions.length;
    examQuestionsViewModel.timeSpentOnQuestions =
        List<int>.filled(totalQuestions, 0);
  }

  void initializeSelectedOptions() {
    int totalQuestions = examQuestionsViewModel
            .examQuestionsDataModel.value?.responseBody?.questions?.length ??
        0;
    //  fallbackQuestions.length;
    print("TOTAL LENGTH --- $totalQuestions");
    examQuestionsViewModel.selectedOptions =
        RxList<int?>.filled(totalQuestions, null);
  }

  void startTimers() {
    examQuestionsViewModel.secondsElapsed.value = 0;
    examQuestionsViewModel.currentQuestionStartTime = 0;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        examQuestionsViewModel.secondsElapsed++;
      });
    });
  }

  void startTimer2() {
    final examDuration = //widget.examData?.responseBody?.examDuration ?? 0;
        examQuestionsViewModel
                .examQuestionsDataModel.value?.responseBody?.examDuration ??
            0;
    final totalTimeInSeconds = examDuration * 60; // Convert minutes to seconds

    examQuestionsViewModel.examTime.value = totalTimeInSeconds;

    examQuestionsViewModel.timer.value =
        Timer.periodic(Duration(seconds: 1), (timer) {
      if (examQuestionsViewModel.examTime.value > 0) {
        examQuestionsViewModel.examTime.value -= 1;
      } else {
        if (!examQuestionsViewModel.isExamSubmitted.value) {
          showLoadingDialog();
          examQuestionsViewModel.handleExamSubmission();
          hideLoadingDialog();
        }
        timer.cancel();
      }
    });
  }

  void goToNextQuestion() {
    saveCurrentQuestionTime();
    if (examQuestionsViewModel.currentQuestionIndex.value <
        (examQuestionsViewModel.examQuestionsDataModel.value?.responseBody
                    ?.questions?.length ??
                0) -
            // fallbackQuestions.length) -
            1) {
      examQuestionsViewModel.currentQuestionIndex.value++;
      updateCurrentQuestionStartTime();
    }
  }

  void goToPreviousQuestion() {
    saveCurrentQuestionTime();
    if (examQuestionsViewModel.currentQuestionIndex.value > 0) {
      examQuestionsViewModel.currentQuestionIndex.value--;
      updateCurrentQuestionStartTime();
    }
  }

  void saveCurrentQuestionTime() {
    int currentQuestionIndex =
        examQuestionsViewModel.currentQuestionIndex.value;

    // Calculate time spent on the current question
    int timeSpent = examQuestionsViewModel.secondsElapsed.value -
        examQuestionsViewModel.currentQuestionStartTime;
    print("timeSpent :  $timeSpent");

    // Update the time spent on the current question
    examQuestionsViewModel.timeSpentOnQuestions[currentQuestionIndex] =
        timeSpent;

    // Update the start time for the next question
    updateCurrentQuestionStartTime();
  }

  void updateCurrentQuestionStartTime() {
    examQuestionsViewModel.currentQuestionStartTime =
        examQuestionsViewModel.secondsElapsed.value;
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  List<String?> getOptions(Questions question) {
    return [
      question.option1,
      question.option2,
      question.option3,
      question.option4
    ];
  }

  void monitorConnectivity() {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        // Internet is connected
        if (!examQuestionsViewModel.isExamSubmitted.value) {
          showLoadingDialog();
          try {
            // Handle exam submission
            final response =
                await examQuestionsViewModel.handleExamSubmission();
            if (response?.status == true) {
              Get.off(ScoreCardScreen(
                examCode: examQuestionsViewModel
                        .examQuestionsDataModel.value?.responseBody?.examCode ??
                    "",
                resultId: examQuestionsViewModel
                        .examQuestionsDataModel.value?.responseBody?.resultId ??
                    0,
              ));
            } else {
              Get.snackbar(
                backgroundColor: Colors.black.withOpacity(0.7),
                colorText: Colors.white,
                'Error!!',
                response?.message ?? "",
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          } catch (e) {
            print('Error during exam submission: $e');
          } finally {
            hideLoadingDialog();
          }
        }
      } else {
        // Internet is disconnected
        // Optionally, you could show a message to the user about no internet connection
      }
    });
  }

  final fallbackQuestions = ExamQuestionsViewModel.fallbackQuestions;

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            shadowColor: Colors.black,
            backgroundColor: bodyBGColor,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            title: const ConstantText(
              text: "Are you sure you want to leave the exam?",
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, false); // Dismiss the dialog
                },
                child: ConstantText(
                  text: "Cancel",
                  color: Colors.black,
                ),
                style: ButtonStyle(
                  splashFactory: InkRipple.splashFactory,
                  overlayColor: MaterialStateProperty.resolveWith(
                    (states) {
                      return states.contains(MaterialState.pressed)
                          ? Colors.grey
                          : null;
                    },
                  ),
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  showLoadingDialog();

                  final response =
                      await examQuestionsViewModel.submitExamQustionAnswersList(
                          examCode: examQuestionsViewModel
                              .examQuestionsDataModel
                              .value
                              ?.responseBody
                              ?.examCode,
                          resultId: examQuestionsViewModel
                              .examQuestionsDataModel
                              .value
                              ?.responseBody
                              ?.resultId,
                          totalQuestions: examQuestionsViewModel
                              .examQuestionsDataModel
                              .value
                              ?.responseBody
                              ?.totalQuestions);
                  hideLoadingDialog();
                  if (response?.status == true) {
                    Get.off(ScoreCardScreen(
                      examCode: examQuestionsViewModel.examQuestionsDataModel
                              .value?.responseBody?.examCode ??
                          "",
                      resultId: examQuestionsViewModel.examQuestionsDataModel
                              .value?.responseBody?.resultId ??
                          0,
                    ));
                  } else {
                    Get.off(ScoreCardScreen(
                      examCode: examQuestionsViewModel.examQuestionsDataModel
                              .value?.responseBody?.examCode ??
                          "0",
                      resultId: examQuestionsViewModel.examQuestionsDataModel
                              .value?.responseBody?.resultId ??
                          0,
                    ));
                    // Get.snackbar(
                    //   backgroundColor: Colors.black.withOpacity(0.7),
                    //   colorText: Colors.white,
                    //   'Error!!',
                    //   response?.message ?? "",
                    //   snackPosition: SnackPosition.BOTTOM,
                    // );
                  }
                  // Confirm to leave the screen
                },
                child: const ConstantText(
                  text: "Leave",
                  color: Colors.black,
                ),
                style: ButtonStyle(
                  splashFactory: InkRipple.splashFactory,
                  overlayColor: MaterialStateProperty.resolveWith(
                    (states) {
                      return states.contains(MaterialState.pressed)
                          ? Colors.grey
                          : null;
                    },
                  ),
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    Get.find<NavigationController>().setBottomBarVisibility(true);
    APIBaseModel<ExamQuestionsDataModel?>? examData =
        examQuestionsViewModel.examQuestionsDataModel.value;

    return WillPopScope(
        onWillPop: _onWillPop,
        child: InternetAwareWidget(
          child: Scaffold(
            backgroundColor: bodyBGColor,
            appBar: ExamPageAppBar(
              //  resultId: resultId ?? 0,
              //  examData: examData,
              containerText: "EXAM",
              examCode: widget.examCode,
              imagePath: "assets/Icon/que_icon.png",
            ),
            //  drawer: const UserDrawer(),
            body: Stack(
              alignment: Alignment.center,
              children: [
                Obx(() {
                  final totalQuestions = examQuestionsViewModel
                          .examQuestionsDataModel
                          .value
                          ?.responseBody
                          ?.questions
                          ?.length ??
                      0;
                  fallbackQuestions.length;

                  final currentQuestion = examQuestionsViewModel
                          .examQuestionsDataModel
                          .value
                          ?.responseBody
                          ?.questions?[
                      examQuestionsViewModel.currentQuestionIndex.value];
                  final displayQuestion = currentQuestion ??
                      fallbackQuestions[
                          examQuestionsViewModel.currentQuestionIndex.value];
                  final options = getOptions(displayQuestion);

                  // ignore: unrelated_type_equality_checks
                  if (totalQuestions == 0 || totalQuestions == []) {
                    return const Center(
                      child: Text("No exams found !"),
                    );
                  } else {
                    return InternetAwareWidget(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context)
                                              .size
                                              .width >
                                          600
                                      ? 40
                                      : MediaQuery.of(context).size.width > 300
                                          ? 30
                                          : 20),
                              child: Text(
                                'Question ${examQuestionsViewModel.currentQuestionIndex.value + 1}:\n${displayQuestion.question}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 6, // Limits the text to 6 lines
                                overflow: TextOverflow
                                    .ellipsis, // Optionally add this to show '...' when the text overflows
                              ),
                            ),
                            Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    List.generate(options.length, (index) {
                                  final option = options[index];
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 20.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.3)),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: RadioListTile<int?>(
                                      title: ConstantText(
                                        text: option ?? '',
                                        maxLines: 3,
                                      ),
                                      value: index + 1,
                                      groupValue: examQuestionsViewModel
                                              .selectedOptions[
                                          examQuestionsViewModel
                                              .currentQuestionIndex.value],
                                      onChanged: (int? value) {
                                        setState(() {
                                          examQuestionsViewModel
                                                  .selectedOptions[
                                              examQuestionsViewModel
                                                  .currentQuestionIndex
                                                  .value] = value;
                                        });
                                      },
                                      selected: examQuestionsViewModel
                                                  .selectedOptions[
                                              examQuestionsViewModel
                                                  .currentQuestionIndex
                                                  .value] ==
                                          index + 1,
                                      selectedTileColor: primaryColor,
                                      activeColor: Colors.black,
                                      dense: true,
                                    ),
                                  );
                                })),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context)
                                              .size
                                              .width >
                                          600
                                      ? 50
                                      : MediaQuery.of(context).size.width > 300
                                          ? 30
                                          : 20),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: goToPreviousQuestion,
                                    style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              Colors.black),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.arrow_left,
                                          color: Colors.white,
                                        ),
                                        ConstantText(
                                          text: 'Back',
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: ConstantText(
                                        text:
                                            '${examQuestionsViewModel.currentQuestionIndex.value + 1}/${examQuestionsViewModel.examQuestionsDataModel.value?.responseBody?.questions?.length}',
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        style:
                                            const TextStyle(fontFamily: 'Sans'),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              Colors.black),
                                    ),
                                    onPressed: () {
                                      if (examQuestionsViewModel
                                              .currentQuestionIndex.value <
                                          totalQuestions - 1) {
                                        goToNextQuestion();
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              shadowColor: Colors.black,
                                              backgroundColor: bodyBGColor,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 20.0),
                                              title: const ConstantText(
                                                text:
                                                    "Are you sure to submit the Exam?",
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: ConstantText(
                                                    text: "Cancel",
                                                    color: Colors.black,
                                                  ),
                                                  style: ButtonStyle(
                                                    splashFactory:
                                                        InkRipple.splashFactory,
                                                    overlayColor:
                                                        MaterialStateProperty
                                                            .resolveWith(
                                                      (states) {
                                                        return states.contains(
                                                                MaterialState
                                                                    .pressed)
                                                            ? Colors.grey
                                                            : null;
                                                      },
                                                    ),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(primaryColor),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    saveCurrentQuestionTime();
                                                    // Navigator.pop(context);
                                                    showLoadingDialog();

                                                    final response = await examQuestionsViewModel.submitExamQustionAnswersList(
                                                        examCode:
                                                            examQuestionsViewModel
                                                                .examQuestionsDataModel
                                                                .value
                                                                ?.responseBody
                                                                ?.examCode,
                                                        resultId:
                                                            examQuestionsViewModel
                                                                .examQuestionsDataModel
                                                                .value
                                                                ?.responseBody
                                                                ?.resultId,
                                                        totalQuestions:
                                                            examQuestionsViewModel
                                                                .examQuestionsDataModel
                                                                .value
                                                                ?.responseBody
                                                                ?.totalQuestions);
                                                    hideLoadingDialog();
                                                    Get.snackbar(
                                                      backgroundColor: Colors
                                                          .black
                                                          .withOpacity(0.7),
                                                      colorText: Colors.white,
                                                      '',
                                                      response?.message ?? "",
                                                      snackPosition:
                                                          SnackPosition.BOTTOM,
                                                    );
                                                    if (response?.status ==
                                                        true) {
                                                      Get.off(ScoreCardScreen(
                                                        examCode: examQuestionsViewModel
                                                                .examQuestionsDataModel
                                                                .value
                                                                ?.responseBody
                                                                ?.examCode ??
                                                            "",
                                                        resultId: examQuestionsViewModel
                                                                .examQuestionsDataModel
                                                                .value
                                                                ?.responseBody
                                                                ?.resultId ??
                                                            0,
                                                      ));
                                                    } else {
                                                      Get.snackbar(
                                                        backgroundColor: Colors
                                                            .black
                                                            .withOpacity(0.7),
                                                        colorText: Colors.white,
                                                        'Error!!',
                                                        response?.message ?? "",
                                                        snackPosition:
                                                            SnackPosition
                                                                .BOTTOM,
                                                      );
                                                    }
                                                  },
                                                  child: const ConstantText(
                                                    text: "Submit",
                                                    color: Colors.black,
                                                  ),
                                                  style: ButtonStyle(
                                                    splashFactory:
                                                        InkRipple.splashFactory,
                                                    overlayColor:
                                                        MaterialStateProperty
                                                            .resolveWith(
                                                      (states) {
                                                        return states.contains(
                                                                MaterialState
                                                                    .pressed)
                                                            ? Colors.grey
                                                            : null;
                                                      },
                                                    ),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(primaryColor),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ConstantText(
                                          text: 'Next',
                                          color: Colors.white,
                                        ),
                                        Icon(
                                          Icons.arrow_right,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ));
  }
}
